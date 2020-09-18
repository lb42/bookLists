<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:t="http://www.tei-c.org/ns/1.0"

    version="2.0">

    <xsl:template match="/">
        <listBibl><xsl:apply-templates select="//t:table"/></listBibl>
    </xsl:template>
<!-- expects rows in the form 
        "author_id","first_name","middle_name","last_name","alt_name","birth_year","death_year","gender"
        -->
    
 <xsl:template match="t:table">
     <xsl:for-each select="t:row[position() gt 1]">
         <xsl:variable name="addNameStr">
             <xsl:value-of  select="t:cell[@n='5']"/>                             
         </xsl:variable>
<!--<xsl:message><xsl:value-of select="$addNameStr"/>
</xsl:message>
   -->  <author>
         <xsl:attribute name="xml:id">
             <xsl:value-of select="substring(t:cell[@n='8'],1,1)"/>
             <xsl:text>:</xsl:text><xsl:value-of select="t:cell[@n='1']"/>
         </xsl:attribute>
<name>
    <xsl:apply-templates select="t:cell[@n='4']"/>  
    <xsl:text>, </xsl:text>
    <xsl:apply-templates select="t:cell[@n='2']"/>           
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="t:cell[@n='3']"/> 
    <xsl:if test="starts-with($addNameStr,'(pseudonym)')">
        <xsl:text> (pseud.)</xsl:text>
    </xsl:if>
    <xsl:text> (</xsl:text>
    <xsl:apply-templates select="t:cell[@n='6']"/>              
    <xsl:text>-</xsl:text>
    <xsl:apply-templates select="t:cell[@n='7']"/>              
    <xsl:text>).</xsl:text> 
</name>
         <xsl:if test="string-length($addNameStr) gt 4 and
             not($addNameStr = '(pseudonym)')">
         <name type="addname">
             <xsl:choose>
                 <xsl:when test="starts-with($addNameStr,'(')">
                     <xsl:value-of select="substring-after(
                         $addNameStr,';')"/>
                 </xsl:when>
                 <xsl:otherwise>
                    <xsl:value-of select="$addNameStr"/> 
                 </xsl:otherwise>
             </xsl:choose>
             
         </name>
         
     </xsl:if></author>
 </xsl:for-each>   </xsl:template>


    <xsl:template match="t:cell">
        <xsl:choose>
            <xsl:when test=".='NULL'"></xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>