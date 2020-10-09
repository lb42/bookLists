<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns="http://www.tei-c.org/ns/1.0"
 xmlns:t="http://www.tei-c.org/ns/1.0" version="2.0">

 <xsl:output exclude-result-prefixes="#all" omit-xml-declaration="yes"/>

 <!-- Special case merge for GB lists 
      we have two: one made by actually asking Google via the API and the other from ATCL 
  In either case, we copy the existing atcl-tei.xml file, supplied as input, adding in ref elements
  which are associated in the document($listFile) with a bibl with the same xml:id value
 -->

<!-- defaults may be overriden by command line parameters -->
  <xsl:param name="listFile">../Lists/gb-list.xml</xsl:param>
 <xsl:param name="listName">Vol </xsl:param>
 <xsl:param name="prefix">GB</xsl:param>

 <xsl:param name="hitContext" select="document($listFile)"/>

 <xsl:key name="bassettKeys" match="$hitContext//*:bibl" use="normalize-space(@xml:id)"/>

 <xsl:template match="/">
  <xsl:message>
   <xsl:value-of select="
     concat('Merging links for ', $prefix, ' from ', $listFile)"/>
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
    <!--   <xsl:message>Anything for <xsl:value-of select="$myKey"/>?
</xsl:message>-->
    <!--   <xsl:if test="key('bassettKeys', 'B14', $hitContext)">
        <xsl:message>Found B14 in the keys</xsl:message>
       </xsl:if>-->
       <xsl:copy select=".">
        <xsl:copy-of select="@*"/>
        <xsl:copy-of select="*"/>
        <!-- check to see if there any records with the same key in the hitFile -->
        <xsl:for-each select="key('bassettKeys', $myKey, $hitContext)">
        <xsl:variable name="myRef">        
            <xsl:value-of select="@xml:id"/>
      </xsl:variable>    
  <!--       <xsl:message>Found <xsl:value-of select="$myRef"/>!
 -->        <!--</xsl:message>-->
        
         <xsl:for-each select="*:ref">
         <ref>         
          <xsl:attribute name="target">
           <xsl:value-of select="concat($prefix, ':',substring-after(@target,'id='))"/>
          </xsl:attribute>
          <xsl:attribute name="type">
          <xsl:text>pages</xsl:text>
         </xsl:attribute>
          <xsl:value-of select="."/>
         </ref>
        </xsl:for-each></xsl:for-each>
       </xsl:copy>
       <xsl:text>
 </xsl:text>
      </xsl:for-each>
      <xsl:message>Found <xsl:value-of select="count(key('bassettKeys', //*:bibl/@xml:id, $hitContext))"
       /> hits in <xsl:value-of select="count(document($listFile)//*:bibl)"/> records </xsl:message>
     </listBibl>
    </body>
   </text>
  </TEI>
 </xsl:template>
</xsl:stylesheet>
