<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns="http://www.tei-c.org/ns/1.0"
 xmlns:t="http://www.tei-c.org/ns/1.0" version="2.0">

 <xsl:output exclude-result-prefixes="#all" omit-xml-declaration="yes"/>

 <!-- Special case merge for Bod lists 
      We copy the existing atcl-tei.xml file, supplied as input, adding in ref elements supplied
      from the document($listFile) as usual; the difference is that the matching key value has
      to be calculated again from the entries there.
      Protest if no match is found since this should not happen
      
 -->

<!-- defaults may be overriden by command line parameters -->
  <xsl:param name="listFile">../Lists/bod-list.xml</xsl:param>
 <xsl:param name="listName">Bod </xsl:param>
 <xsl:param name="prefix"></xsl:param>

 <xsl:param name="hitContext" select="document($listFile)"/>

 <xsl:key name="bassettKeys" match="$hitContext//*:bibl" use="t:make_key(title,author)"/>

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
        <xsl:value-of select="@n"/>
       </xsl:variable>
    <!--   <xsl:message>Anything for <xsl:value-of select="$myKey"/>?
</xsl:message>-->
    <xsl:if test="not(key('bassettKeys', @myKey, $hitContext))">
        <xsl:message>Couldn't find <xsl:value-of select="@myKey"/> in the keys</xsl:message>
       </xsl:if>
       <xsl:copy select=".">
        <xsl:copy-of select="@*"/>
        <xsl:copy-of select="*"/>
        <!-- check to see if there any records with the same key in the hitFile -->
        <xsl:for-each select="key('bassettKeys', $myKey, $hitContext)">
        <xsl:variable name="myRef">        
            <xsl:value-of select="@xml:id"/>
      </xsl:variable>          
         <xsl:for-each select="*:ref">
         <ref>         
          <xsl:attribute name="target">
           <xsl:value-of select="@target"/>
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
 
 <xsl:function name="t:make_key" as="xs:string">
  <xsl:param name="title"/>
  <xsl:param name="author"/>
  
  <xsl:variable name="titleBit">
   <xsl:analyze-string regex='(^[^.,;:/]+)' select="replace($title,'(^Mrs?)\.','$1')">
    <xsl:matching-substring>
     <xsl:value-of select="regex-group(1)"/>
    </xsl:matching-substring>
   </xsl:analyze-string>
  </xsl:variable>
  
  <xsl:variable name="str"><xsl:value-of
   select="concat($titleBit, '|', substring-before($author, ','))"/>  
  </xsl:variable>
  
  <xsl:variable name="result"
   select="
   lower-case(normalize-space(replace($str, '\W+', '')))"/>
  <xsl:value-of
   select="
   if (string-length($result) &gt; 42) then
   concat(substring($result, 1, 42), '...')
   else
   $result"
  />
 </xsl:function>
          
 
 
</xsl:stylesheet>
