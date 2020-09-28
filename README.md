# bookList scripts

This repo holds master versions of scripts used to manipulate ATCL data, in particular to add URLs for available digital versions of the titles listed.

The TEI version of the ATCL database is made by editing  CSV files downloaded from http://www.victorianresearch.org/atcl/snapshots.php and stored locally in a folder called ATCL. There are two csv files, one for authors and one for titles (I don't store them in this repository: if you want to replicate the process, you need to get your own copies from the ATCL site).

## Stage One

It's a two-stage process. First we use the standard TEI stylesheet cvstotei to convert the CSV file to a TEI conformant representation, from which we extract the relevant cells for a TEI `<bibl>`.  We convert the author file first, and then merge its contents into the second to produce the file `atcl-tei-unlinked.xml`
~~~~
csvtotei ATCL/authors.csv authors.tmp
saxon -s:authors.tmp -xsl:Scripts/authors2tei.xsl -o:authors.tei
csvtotei ATCL/titles.csv titles.tmp
saxon -s:titles.tmp -xsl:Scripts/titles2tei.xsl -o:atcl-tei-unlinked.xml
~~~~

As well as standard bibliographic information, the following attributes are added to each `<bibl>` in the generated TEI file:
 - @xml:id holds the ATCL title number prefixed by the letter B (for Bassett)
 - @n adds a (hopefully) unique key to each title, made by concatenating the author's last name with the beginning of the title,  minus any punctuation and spaces. By "The beginning", I mean the string of characters preceding whichever comes first of various punctuation marks or the end of the string -- cataloguing practice is particularly fluid in this respect.
 - We use this "magic key" as a way of identifying the title in other collections of metadata we wish to merge into the TEI file automatically. We also transfer the following classification codes from the ATCL database.
 - @ana holds a three character code indicating some key metadata properties used by the ELTeC project (for which this work was undertaken) specifically:
   - T1, T2, T3, or T4 indicates the time period
   - F M or U indicates the author sex
   - 1, 2, or 3 indicates the number of volumes, a proxy for size
  
In addition, the @ref attribute on `<author>` contains the ATCL author number, prefixed by the letter F, M, or U and a colon. 

## Stage 2

In stage 2, we scan through metadata derived from a number of archives. These metadata lists, stored in the folder `Lists`, are generated from whatever machine-tractable format we can readily download from the relevant archive; for details see the README in the Lists folder. The generation process also adds a "magic key" hopefully identical to that used by the ATCL data. 

For each match found, a `<ref>` element is added to the TEI version of the ATCL data, its @target attribute providing a URL from which the corresponding text may be downloaded in that archive.
