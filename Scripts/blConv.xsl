<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0" 
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="#all"
 version="2.0">
 
<xsl:template match="/">
 <listBibl xmlns="http://www.tei-c.org/ns/1.0">
  <xsl:apply-templates select="TEI/text/body/table/row[matches(cell[@n='14'],'1[89]\d\d')]"/>
 </listBibl>
</xsl:template>
 
 <xsl:template match="row">
  <xsl:variable name="titleStr">
   <xsl:value-of select="replace(cell[@n='5'],'(^Mrs?)\.','$1')"/>
  </xsl:variable>
  
  <xsl:variable name="titleBit">
   <xsl:analyze-string regex='(^[^.,;:/]+)' select="$titleStr">
    <xsl:matching-substring>
     <xsl:value-of select="regex-group(1)"/>
    </xsl:matching-substring>
   </xsl:analyze-string>
  </xsl:variable>
  
  
  <bibl  xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:attribute name="n">
    <xsl:value-of select="concat(t:sanitize($titleBit),'|', t:sanitize(substring-before(cell[@n='11'],',')))"/>
   </xsl:attribute>
   <author><xsl:value-of select="cell[@n='11']"/></author>
   <title>  <xsl:value-of select="$titleStr"/> </title>
   <edition><xsl:value-of select="cell[@n='13']"/></edition>
   <publisher><xsl:value-of select="cell[@n='14']"/></publisher>
   <idno><xsl:value-of select="cell[@n='3']"/></idno>
  </bibl><xsl:text>
  </xsl:text>
 </xsl:template>
 
 <xsl:function name="t:sanitize" as="xs:string">
  <xsl:param name="text"/>
 <!-- <xsl:variable name="alltext">
   <xsl:value-of select="($text)" separator=" "/>
  </xsl:variable>-->
  <xsl:variable name="result"
   select="
   lower-case(normalize-space(replace($text, '\W+', '')))"/>
  <xsl:value-of
   select="
   if (string-length($result) &gt; 42) then
   concat(substring($result, 1, 42), '...')
   else
   $result"
  />
 </xsl:function>
 
</xsl:stylesheet>