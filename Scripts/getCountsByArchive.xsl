<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
     xpath-default-namespace="http://www.tei-c.org/ns/1.0"
     xmlns:t="http://www.tei-c.org/ns/1.0"
       
     
    version="2.0">
 <xsl:output media-type="text" omit-xml-declaration="yes"></xsl:output>
    <xsl:template match="/">
        <xsl:text>Archive,  A-dig,  M-dig, F-dig, U-dig , %M-dig, %F-dig
</xsl:text>
        <xsl:text>All ,</xsl:text>
     <xsl:value-of select="count(/TEI/text/body/listBibl/bibl[ref])"/>
     <xsl:text>,</xsl:text> 
     <xsl:value-of select="count(/TEI/text/body/listBibl/bibl[ref][starts-with(author/@ref,'M')])"/>
     <xsl:text>,</xsl:text> 
     <xsl:value-of select="count(/TEI/text/body/listBibl/bibl[ref][starts-with(author/@ref,'F')])"/>
     <xsl:text>,</xsl:text> 
     <xsl:value-of select="count(/TEI/text/body/listBibl/bibl[ref][starts-with(author/@ref,'U')])"/>
     <xsl:text>,</xsl:text> 
     <xsl:value-of select="format-number(count(TEI/text/body/listBibl/bibl[ref][starts-with(author/@ref,'M')]) 
      div count(TEI/text/body/listBibl/bibl[ref]) , '#%')"/>
     <xsl:text>,</xsl:text> 
     <xsl:value-of select="format-number(count(TEI/text/body/listBibl/bibl[ref][starts-with(author/@ref,'F')]) 
      div count(TEI/text/body/listBibl/bibl[ref]) , '#%')"/>
     
      <xsl:text>     
</xsl:text>
     <xsl:call-template name="doRow">
      <xsl:with-param name="label">ht</xsl:with-param>
     </xsl:call-template>
     
     <xsl:call-template name="doRow">
      <xsl:with-param name="label">ia</xsl:with-param>
     </xsl:call-template>
     
     <xsl:call-template name="doRow">
      <xsl:with-param name="label" >GB</xsl:with-param>

     </xsl:call-template>
     <xsl:call-template name="doRow">
      <xsl:with-param name="label">ark</xsl:with-param>

     </xsl:call-template>
     <xsl:call-template name="doRow">
      <xsl:with-param name="label">gut</xsl:with-param>

     </xsl:call-template>
     
    </xsl:template>
 
 <xsl:template name="doRow">
  <xsl:param name="label"/>

  <xsl:value-of select="$label"/> <xsl:text>,</xsl:text>
 
  <xsl:value-of select="count(/TEI/text/body/listBibl/bibl[ref[starts-with(@target,$label)]])"/>
  <xsl:text>,</xsl:text> 
  <xsl:value-of select="count(/TEI/text/body/listBibl/bibl[ref[starts-with(@target,$label)]][starts-with(author/@ref,'M')])"/>
  <xsl:text>,</xsl:text> 
  <xsl:value-of select="count(/TEI/text/body/listBibl/bibl[ref[starts-with(@target,$label)]][starts-with(author/@ref,'F')])"/>
  <xsl:text>,</xsl:text> 
  <xsl:value-of select="count(/TEI/text/body/listBibl/bibl[ref[starts-with(@target,$label)]][starts-with(author/@ref,'U')])"/>
  <xsl:text>,</xsl:text> 
  <xsl:value-of select="format-number(count(TEI/text/body/listBibl/bibl[ref[starts-with(@target,$label)]][starts-with(author/@ref,'M')]) 
   div count(TEI/text/body/listBibl/bibl[ref[starts-with(@target,$label)]]) , '#%')"/>
  <xsl:text>,</xsl:text> 
  <xsl:value-of select="format-number(count(TEI/text/body/listBibl/bibl[ref[starts-with(@target,$label)]][starts-with(author/@ref,'F')]) 
   div count(TEI/text/body/listBibl/bibl[ref[starts-with(@target,$label)]]) , '#%')"/>
  
  <xsl:text>     
</xsl:text>
  
 
 </xsl:template>
 
 
    
</xsl:stylesheet>
