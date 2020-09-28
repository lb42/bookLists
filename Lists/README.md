# bookLists data

This folder should contain files listing the contents of a digital archive to be examined for entries which can be merged into `atcl-tei.xml` because they have matching magic key values.

## An example

A small example file, `vwwp-keyed.xml`, is provided, derived from the  "Victorian Women Writer's Project at Indiana University2 (https://webapp1.dlib.indiana.edu/vwwp/welcome.do). This project's interface does not make its bibliographic data directly available, but it is full searchable so I had to extract it by screen scraping. Note also that this list contains some titles which do not meet the ATCL criteria for inclusion, for example because they were published after 1900, as well as one or two which are unaccountably missing from ATCL. 

The script `Scripts/merger.xsl` is used to combine the links provided by this file with the data already present in `atcl-tei.xml` using a command line like the following:
~~~~
saxon -s:atcl-tei-backup.xml -xsl:Scripts/merger.xsl
-o:atcl-tei.xml listFile=../Lists/vwwp-list.xml
listName="Victorian Women Writers Project" prefix=vwwp
~~~~

Running with the supplied test data and the current ATCL release, this finds 57 hits in 62 records. The XPath `count(//bibl[ref])` run against the output file returns 35, indicating that there are several (13 to be exact) titles for which VWWP provides multiple hits, each corresponding with a separately digitized volume. 

For example, the entry in the output atcl-tei.xml file for  Ouida's novel "Signa"  now reads as follows:
~~~~
<bibl xml:id="B2610" n="signa|ouida" ana="T2F3">
<author ref="F:51">Ouida, (pseud.) (1839-1908).</author>
<title>Signa: A Story</title>
<publisher>London: Chapman and Hall</publisher><date>1875</date>
<ref target="vwwp:VAB7155" type="transcr">Victorian Women Writers Project</ref>
<ref target="vwwp:VAB7156" type="transcr">Victorian Women Writers Project</ref>
<ref target="vwwp:VAB7157" type="transcr">Victorian Women Writers Project</ref>
</bibl>
~~~~
The prefix `vwwp:` is used to simplify the construction of a valid URI from which the transcript of the volume in question can be directly accessed. In this case each of the three volumes of the original work can be retrieved using an address such as 
`http://purl.dlib.indiana.edu/iudl/vwwp/encodedtext/VAB7155` (for the first volume)

## Other lists

Different digital archives provide their data and their metadata in different formats. So long as it is possible to convert the metadata into a TEI-conformant version, and provided that the cataloguing practices do not diverge too far from those of the ATCL, it remains possible to apply the same procedure.
 - first we download the metadata from the archive
 - next we convert it to a standard(ish) TEI format
 - then we run the merge process detailed above to add references to a new version of the atcl-tei.xml document
 
Here is a table listing the digital archives to which we have so far applied this process.

|prefix|source|convertor|records|hits|
|-|-|-|-|-|
|bl|MicrosoftBooks_FullIndex_27_09_2018.csv|blConv.xsl|62015|6062
Convertors for the files we have tested are included in the Scripts folder. these include the following:

 - `blConv.xsl` : operates on 
 - `htConv.xsl`
 - `gutConv.xsl`
 - `iaConv.xsl`
