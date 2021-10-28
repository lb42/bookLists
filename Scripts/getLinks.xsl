<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 <xsl:output omit-xml-declaration="yes"/>
 <xsl:template match="/">
<xsl:for-each select="//t:TEI">
   <doc xml:id="{@xml:id}">
     <title><xsl:value-of select="//t:titleStmt/t:title"/></title>
     <xsl:for-each select="//t:div[@type='titlepage']">  
    <titlePage>
      <xsl:apply-templates select="t:p"/>
    </titlePage>
     </xsl:for-each>
   </doc>
   <xsl:message><xsl:value-of select="@xml:lang"/>
     <xsl:text> repo has </xsl:text>
     <xsl:value-of select="count(//t:div[@type='titlepage'])"/>
     <xsl:text> titlepages
     </xsl:text></xsl:message>

</xsl:for-each>
 </xsl:template>
  
 <xsl:template match="t:p">
  <p>  
   <xsl:value-of select="normalize-space(.)"/>
  </p>
 </xsl:template>
 
</xsl:stylesheet>
