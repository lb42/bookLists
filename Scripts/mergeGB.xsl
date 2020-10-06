<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns="http://www.tei-c.org/ns/1.0"
 xmlns:t="http://www.tei-c.org/ns/1.0" version="2.0">

 <xsl:output exclude-result-prefixes="#all" omit-xml-declaration="yes"/>

 <!-- Process the input file (a TEI version of the Bassett dump) 
        output a new version which includes links for $hitName from the file $listFile -->

<!-- defaults overriden by command line parameters -->
  <xsl:param name="listFile">../GB/gb-list.xml</xsl:param>
 <xsl:param name="listName">Google Books</xsl:param>
 <xsl:param name="prefix">gb</xsl:param>

 <xsl:param name="hitContext" select="document($listFile)"/>

 <xsl:key name="bassettKeys" match="$hitContext//t:bibl" use="normalise-space(@xml:id)"/>

 <xsl:template match="/">
  <xsl:message>
   <xsl:value-of select="
     concat('Merging links for ', $listName, ' from ', $listFile)"/>
  </xsl:message>

  <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:xi="http://www.w3.org/2001/XInclude">
 <!--  <xi:include href="defaultHdr.xml"/>
-->
   <text>
    <body>
     <listBibl xmlns="http://www.tei-c.org/ns/1.0">

      <!-- copy each bibl from ATCL -->
      <xsl:for-each select="//t:bibl">
       <xsl:variable name="myKey">
        <xsl:value-of select="@xml:id"/>
       </xsl:variable>
       
       <xsl:copy select=".">
        <xsl:copy-of select="@*"/>
        <xsl:copy-of select="*"/>
        <!-- check to see if there any records with the same key in the hitFile -->
        <xsl:for-each select="key('bassettKeys', $myKey, $hitContext)">
        <xsl:variable name="myRef">
          <xsl:choose>
            <xsl:value-of select=", @xml:id)"/>
          </xsl:choose>
      </xsl:variable>    
         <ref>
          <xsl:attribute name="target">
           <xsl:value-of select="concat($prefix, ':',substring-after(ref/@target,'id='))"/>
          </xsl:attribute>
          <xsl:attribute name="type">
          <xsl:text>pages</xsl:text>
         </xsl:attribute>
          <xsl:value-of select="$listName"/>
         </ref>
        </xsl:for-each>
       </xsl:copy>
       <xsl:text>
 </xsl:text>
      </xsl:for-each>
      <xsl:message>Found <xsl:value-of select="count(key('bassettKeys', //t:bibl/@xml:id, $hitContext))"
       /> hits in <xsl:value-of select="count(document($listFile)//t:bibl)"/> records </xsl:message>
     </listBibl>
    </body>
   </text>
  </TEI>
 </xsl:template>
</xsl:stylesheet>
