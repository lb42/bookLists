<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:t="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs"
 version="2.0">
 
 <xsl:template match="/">
  <xsl:for-each select="//t:ref">
  <xsl:value-of select="parent::t:bibl/@xml:id"/><xsl:text>,</xsl:text>
  <xsl:value-of select="t:expand(@target)"/><xsl:text>,</xsl:text>
  <xsl:value-of select="t:qq(.)"/><xsl:text>
  </xsl:text>
  </xsl:for-each>
 </xsl:template>

 
 <xsl:function name="t:expand">
  <xsl:param name="url"/>
  <xsl:variable name="prefix">
  <xsl:choose>
   <xsl:when test="starts-with($url,'http:')">http:</xsl:when>
   <xsl:when test="starts-with($url,'https:')">https:</xsl:when>
   
   <xsl:when test="starts-with($url,'bl:')">http://access.bl.uk/item/viewer/</xsl:when>
   <xsl:when test="starts-with($url,'ark:')">http://access.bl.uk/item/viewer/ark:</xsl:when>
   
   <xsl:when test="starts-with($url,'gut:')">http://www.gutenberg.org/ebooks/</xsl:when>
   <xsl:when test="starts-with($url,'vw:')">http://purl.dlib.indiana.edu/iudl/vwwp/encodedtext/</xsl:when>
   <xsl:when test="starts-with($url,'gb:')">https://books.google.co.uk/books?id=</xsl:when>
   <xsl:when test="starts-with($url,'GB:')">https://books.google.co.uk/books?id=</xsl:when>
   
   <xsl:when test="starts-with($url,'ia:')">https://archive.org/details/</xsl:when>
   <xsl:when test="starts-with($url,'ht:')">https://babel.hathitrust.org/cgi/pt?id=</xsl:when>   
  </xsl:choose>
  </xsl:variable>
  <xsl:value-of select="concat($prefix,substring-after($url,':'))"/>
 </xsl:function>
 
 <xsl:function name="t:qq">
  <xsl:param name="str"/>
  <xsl:text>"</xsl:text><xsl:value-of select="$str"/><xsl:text>"</xsl:text>
 </xsl:function>
</xsl:stylesheet>