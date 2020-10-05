<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
     xpath-default-namespace="http://www.tei-c.org/ns/1.0"
     xmlns:t="http://www.tei-c.org/ns/1.0"
       
     
    version="2.0">
 <xsl:output media-type="text" omit-xml-declaration="yes"></xsl:output>
    <xsl:template match="/">
        <xsl:text>Decade, All,A-dig, (C % B), "Male", M-dig, (F % C), "Female", F-dig, (%)
</xsl:text>
        <xsl:text>- ,</xsl:text><xsl:value-of select="count(/TEI/text/body/listBibl/bibl)"/>
     <xsl:text>,</xsl:text>
     <xsl:value-of select="count(/TEI/text/body/listBibl/bibl[ref])"/>
     <xsl:text>,</xsl:text>
     <xsl:value-of select="format-number(count(TEI/text/body/listBibl/bibl[ref]) 
      div count(TEI/text/body/listBibl/bibl) , '#%')"/>
     <xsl:text>,</xsl:text> 
     
     <xsl:value-of select="count(/TEI/text/body/listBibl/bibl[starts-with(author/@ref,'M')])"/>
        <xsl:text>,</xsl:text> 
     <xsl:value-of select="count(/TEI/text/body/listBibl/bibl[ref][starts-with(author/@ref,'M')])"/>
     <xsl:text>,</xsl:text> 
      
     <xsl:value-of select="format-number(count(TEI/text/body/listBibl/bibl[ref][starts-with(author/@ref,'M')]) 
      div count(TEI/text/body/listBibl/bibl[starts-with(author/@ref,'M')]) , '#%')"/>
     <xsl:text>,</xsl:text> 
     <xsl:value-of select="count(/TEI/text/body/listBibl/bibl[starts-with(author/@ref,'F')])"/>
     <xsl:text>,</xsl:text> 
     <xsl:value-of select="count(/TEI/text/body/listBibl/bibl[ref][starts-with(author/@ref,'F')])"/>
     <xsl:text>,</xsl:text> 
     <xsl:value-of select="format-number(count(TEI/text/body/listBibl/bibl[ref][starts-with(author/@ref,'F')]) 
      div count(TEI/text/body/listBibl/bibl[starts-with(author/@ref,'F')]) , '#%')"/>
      <xsl:text>     
</xsl:text>
     <xsl:call-template name="doRow">
      <xsl:with-param name="upto" select="1840"/>
     </xsl:call-template>
     
     <xsl:call-template name="doRow">
      <xsl:with-param name="upto" select="1850"/>
     </xsl:call-template>
     
     <xsl:call-template name="doRow">
      <xsl:with-param name="upto" select="1860"/>

     </xsl:call-template>
     <xsl:call-template name="doRow">
      <xsl:with-param name="upto" select="1870"/>

     </xsl:call-template>
     <xsl:call-template name="doRow">
      <xsl:with-param name="upto" select="1880"/>

     </xsl:call-template>
     <xsl:call-template name="doRow">
      <xsl:with-param name="upto" select="1890"/>
     </xsl:call-template>
     <xsl:call-template name="doRow">
      <xsl:with-param name="upto" select="1900"/>
     </xsl:call-template>
     
    </xsl:template>
 
 <xsl:template name="doRow">
  <xsl:param name="upto"/>

  <xsl:value-of select="concat($upto - 10,'s')"/> <xsl:text>,</xsl:text>
  <xsl:value-of select="count(TEI/text/body/listBibl/bibl[date &lt; $upto and date &gt; ($upto -11)])"/>
  <xsl:text>,</xsl:text>
  <xsl:value-of select="count(TEI/text/body/listBibl/bibl[ref][date &lt; $upto and date &gt; ($upto -11)])"/>
  <xsl:text>,</xsl:text>
  <xsl:value-of select="format-number(count(TEI/text/body/listBibl/bibl[ref][date &lt; $upto and date &gt; ($upto -11)]) 
   div count(TEI/text/body/listBibl/bibl[date &lt; $upto and date &gt; ($upto -10)]) , '#%')"
   /> <xsl:text>,</xsl:text>
  <xsl:value-of select="count(TEI/text/body/listBibl/bibl[starts-with(author/@ref,'M')][date &lt; $upto and date &gt; ($upto -11)])"/>
  <xsl:text>,</xsl:text> 
  <xsl:value-of select="count(TEI/text/body/listBibl/bibl[starts-with(author/@ref,'M')][ref][date &lt; $upto and date &gt; ($upto -11)])"/>
  <xsl:text>,</xsl:text> 
  <xsl:value-of select="format-number(count(TEI/text/body/listBibl/bibl[starts-with(author/@ref,'M')][ref][date &lt; $upto and date &gt; ($upto -10)]) 
   div count(TEI/text/body/listBibl/bibl[starts-with(author/@ref,'M')][date &lt; $upto and date &gt; ($upto -11)]) , '#%')"
  /> <xsl:text>,</xsl:text>
  <xsl:value-of select="count(TEI/text/body/listBibl/bibl[starts-with(author/@ref,'F')][date &lt; $upto and date &gt; ($upto -11)])"/>
  <xsl:text>,</xsl:text> 
  <xsl:value-of select="count(TEI/text/body/listBibl/bibl[starts-with(author/@ref,'F')][ref][date &lt; $upto and date &gt; ($upto -11)])"/>
  <xsl:text>,</xsl:text>
  <xsl:value-of select="format-number(count(TEI/text/body/listBibl/bibl[starts-with(author/@ref,'F')][ref][date &lt; $upto and date &gt; ($upto -11)]) 
   div count(TEI/text/body/listBibl/bibl[starts-with(author/@ref,'F')][date &lt; $upto and date &gt; ($upto -11)]) , '#%')"
  /> <xsl:text>
  </xsl:text> 
 </xsl:template>
 
 
    <xsl:function name="t:d">
        <xsl:param name="year"/>
        <xsl:choose>
            <xsl:when test="$year lt '1845'">1</xsl:when>
            <xsl:when test="$year lt '1855'">2</xsl:when>
            <xsl:when test="$year lt '1865'">3</xsl:when> 
            <xsl:when test="$year lt '1875'">4</xsl:when> 
            <xsl:when test="$year lt '1885'">5</xsl:when> 
            <xsl:when test="$year lt '1895'">6</xsl:when>
            <xsl:otherwise>7</xsl:otherwise>
        </xsl:choose>
    </xsl:function>
</xsl:stylesheet>
