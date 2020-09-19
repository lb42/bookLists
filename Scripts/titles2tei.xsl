<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
 xmlns:t="http://www.tei-c.org/ns/1.0" version="2.0">
 <xsl:param name="authorFile" select="document('../ATCL/authors.tei')"/>
 <xsl:template match="/">
  <listBibl>
   <xsl:apply-templates select="//t:table"/>
  </listBibl>
 </xsl:template>
 <xsl:template match="t:table">
  <xsl:for-each select="t:row[position() gt 1]">
   <xsl:variable name="title">
    <xsl:value-of select="t:cell[@n = '3']"/>
   </xsl:variable>
   <xsl:variable name="titleKey">
    <xsl:value-of select="concat(t:sanitize($title), '|')"/>
   </xsl:variable>
   <xsl:variable name="authId">
    <xsl:value-of select="t:cell[@n = '2']"/>
   </xsl:variable>
   <xsl:variable name="authSex">
    <xsl:value-of
     select="substring($authorFile//*:author[substring-after(@xml:id, ':') = $authId]/@xml:id, 1, 1)"
    />
   </xsl:variable>
   <xsl:variable name="authString">
    <xsl:value-of select="$authorFile//*:author[substring-after(@xml:id, ':') = $authId]/*:name[1]"
    />
   </xsl:variable>



   <xsl:variable name="pubDate">
    <xsl:value-of select="substring(t:cell[@n = '7'], 1, 4)"/>
   </xsl:variable>

   <xsl:variable name="balanceKey">
    <xsl:choose>
     <xsl:when test="$pubDate le '1859'">T1</xsl:when>
     <xsl:when test="$pubDate le '1879'">T2</xsl:when>
     <xsl:when test="$pubDate le '1899'">T3</xsl:when>
     <xsl:when test="$pubDate le '1920'">T4</xsl:when>
    </xsl:choose>
    <xsl:value-of select="$authSex"/>
    <xsl:value-of select="t:cell[@n = '4']"/>
    <!-- use vol count as surrogate for length-->
   </xsl:variable>

   <xsl:if test="string-length(t:cell[@n = '1']) gt 0">
    <bibl>
     <xsl:attribute name="xml:id">
      <xsl:value-of select="concat('B', t:cell[@n = '1'])"/>
     </xsl:attribute>
     <xsl:attribute name="n">
      <xsl:value-of
       select="concat(t:sanitize($title), '|', t:sanitize(substring-before($authString, ',')))"/>
     </xsl:attribute>
     <xsl:attribute name="ana">
      <xsl:value-of select="$balanceKey"/>
     </xsl:attribute>
     <author>
      <xsl:attribute name="ref">
       <xsl:value-of select="concat($authSex, ':', $authId)"/>
      </xsl:attribute>
      <xsl:value-of select="$authString"/>
     </author>
     <title>
      <xsl:value-of select="t:cell[@n = '3']"/>
     </title>
     <publisher>
      <xsl:value-of select="t:cell[@n = '5']"/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="t:cell[@n = '6']"/>
     </publisher>
     <date>
      <xsl:value-of select="substring(t:cell[@n = '7'], 1, 4)"/>
     </date>
     <!-- cell 4 contains number of volumes -->
    </bibl>
   </xsl:if>
  </xsl:for-each>
 </xsl:template>

 <xsl:function name="t:sanitize" as="xs:string">
  <xsl:param name="text"/>
  <xsl:variable name="alltext">
   <xsl:value-of select="($text)" separator=" "/>
  </xsl:variable>
  <xsl:variable name="result"
   select="
    lower-case(normalize-space(replace($alltext, '\W+', '')))"/>
  <xsl:value-of
   select="
    if (string-length($result) &gt; 42) then
     concat(substring($result, 1, 42), '...')
    else
     $result"
  />
 </xsl:function>

</xsl:stylesheet>
