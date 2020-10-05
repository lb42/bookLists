<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:output omit-xml-declaration="yes"/>
 <xsl:template match="/">
<xsl:text>
ATCL_id,Archive,id,Type
</xsl:text> 
  <xsl:for-each select="//*:bibl/*:ref">
   <xsl:value-of select="parent::*:bibl/@xml:id"/>
   <xsl:text>,</xsl:text>
  <xsl:value-of select="substring-before(@target,':')"/>
   <xsl:text>,</xsl:text>
   <xsl:value-of select="substring-after(@target,':')"/>
   <xsl:text>,</xsl:text>
   <xsl:value-of select="@type"/>
   <xsl:text>
   </xsl:text>   
  </xsl:for-each>
 </xsl:template>
  
 
</xsl:stylesheet>