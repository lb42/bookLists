# bookLists data

This folder should contain files listing the contents of a digital archive to be examined for entries which can be merged into `atcl-tei.xml` because they have matching magic key values.

## An example

A small example file, `vwwp-list.xml`, is provided, derived from the Victorian Women Writer's Project at Indiana University. Note that this list contains some titles which do not meet the ATCL criteria for inclusion, for example because they are verse rather than novels, or because they were published after 1900. 

The script `Scripts/merger.xsl` is used to combine the links provided by this file with the data already present in `atcl-tei.xml` using a command line like the following:
~~~~
mv atcl-tei.xml atcl-tei-backup.xml
saxon -s:atcl-tei-backup.xml -xsl:Scripts/merger.xsl
-o:atcl-tei.xml listFile=../Lists/vwwp-list.xml
listName="Victorian Women Writers Project" prefix=vwwp
~~~~

Running with the supplied test data and the current ATCL release, this should find 57 hits in 73 records. The `<bibl>` in the output atcl-tei.xml file will contain a `<ref>` element for each hit, in the following format:
~~~~
<ref target="vwwp:VAB7184" type="transcr">
Victorian Women Writers Project</ref>
~~~~

A TEI `<prefixDef>` element is provided in the TEI header for atcl-tei.xml, in the following format:
~~~~
 <prefixDef ident="vwwp"
  matchPattern="(VAB[0-9]*)" replacementPattern="http://purl.dlib.indiana.edu/iudl/vwwp/encodedtext/$1">
    <p> Private URIs using the <code>vwwp</code> prefix can be expanded to form URIs which retrieve the relevant TEI XML file from the Victorian Women Writers Project </p>
  </prefixDef>
~~~~   
For example, the title cited above can be retrieved in XML directly from the address: `http://purl.dlib.indiana.edu/iudl/vwwp/encodedtext/VAB7184`

## Other lists

Different digital archives provide their data and their metadata in different formats. So long as it is possible to convert the metadata into a TEI-conformant version, and provided that the cataloguing practices do not diverge too far from those of the ATCL, it remains possible to apply the same procedure.
 - first we download the metadata from the archive
 - next we convert it to a standard(ish) TEI format
 - then we run the merge process detailed above to add references to a new version of the atcl-tei.xml document
 
Here is a table listing the digital archives to which we have so far applied this process.

|prefix|source|convertor|records|hits|
|-|-|-|-|-|
|bl|MicrosoftBooks_FullIndex_27_09_2018.csv|blConv.xsl|62015
Convertors for the files we have tested are included in the Scripts folder. these include the following:

 - `blConv.xsl` : operates on 
 - `htConv.xsl`
 - `gutConv.xsl`
 - `iaConv.xsl`
