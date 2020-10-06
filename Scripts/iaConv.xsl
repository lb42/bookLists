<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:h="http://www.w3.org/1999/xhtml" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="h t" version="2.0">
 <!-- <doc>
    <str name="creator">Price, Eleanor C. (Eleanor Catherine)</str>
    <str name="date">1983-01-01T00:00:00Z</str>
    <str name="identifier">foreignersnovel01pric</str>
    <str name="language">eng</str>
    <str name="publisher">London : Chatto &amp; Windus</str>
    <str name="title">The foreigners : a novel</str>
    <str name="volume">1</str>
  </doc>-->
 <xsl:template match="/">

  <listBibl n="IA19cennov" xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates select="//doc"/>
  </listBibl>
 </xsl:template>
 <xsl:template match="doc">
  <xsl:variable name="auth">
   <xsl:value-of select="str[@name = 'creator']"/>
  </xsl:variable>
  <xsl:variable name="authorBit">
   <xsl:value-of select="substring-before($auth, ',')"/>
  </xsl:variable>
  <xsl:variable name="titleId">
   <xsl:value-of select="str[@name = 'identifier']"/>
  </xsl:variable>
  <xsl:variable name="titleBit">
   <xsl:analyze-string regex="(^[^.,;:/]+)" select="replace(str[@name = 'title'],'(^Mrs?)\.','$1')">
    <xsl:matching-substring>
     <xsl:value-of select="regex-group(1)"/>
    </xsl:matching-substring>
   </xsl:analyze-string>
  </xsl:variable>

  <xsl:variable name="titleKey">

   <xsl:value-of select="concat(t:sanitize($titleBit), '|', t:sanitize($authorBit))"/>

  </xsl:variable>


  <bibl xmlns="http://www.tei-c.org/ns/1.0"
   xml:id="{$titleId}" n="{$titleKey}">
   <author>
      <xsl:value-of select="$auth"/>
   </author>
   <title>
    <xsl:value-of select="str[@name = 'title']"/>
   </title>
   <xsl:value-of select="str[@name = 'publisher']"/>
  </bibl>
 </xsl:template>

 <xsl:function name="t:sanitize" as="xs:string">
  <xsl:param name="text"/>

  <xsl:variable name="result" select="
    lower-case(normalize-space(replace($text, '\W+', '')))"/>

  <xsl:value-of select="
    if (string-length($result) &gt; 42) then
     concat(substring($result, 1, 42), '...')
    else
     $result"/>
 </xsl:function>
</xsl:stylesheet>
