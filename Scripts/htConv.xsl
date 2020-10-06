<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:t="http://www.tei-c.org/ns/1.0"
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
       exclude-result-prefixes="#all"
     version="2.0">
    
    <xsl:template match="/">
          <xsl:apply-templates select="t:listBibl"/>
    </xsl:template>
 
 <xsl:template match="t:listBibl">
  <listBibl xmlns="http://www.tei-c.org/ns/1.0">
       <xsl:for-each select="t:bibl">
        <xsl:variable name="titleBit">
         <xsl:analyze-string regex='(^[^.,;:/]+)' select="replace(t:title,'(^Mrs?)\.','$1')">
         <xsl:matching-substring>
        <xsl:value-of select="regex-group(1)"/>
         </xsl:matching-substring>
        </xsl:analyze-string>
        </xsl:variable>
        
        <xsl:variable name="surname">
            <xsl:choose>
             <xsl:when test="contains(t:author, ',')">
              <xsl:value-of select="substring-before(t:author,',')"/>
             </xsl:when>
             <xsl:when test="contains(t:author, ' ')">
              <xsl:value-of select="tokenize(t:author,' ')[last()]"/>
             </xsl:when>                
             <xsl:otherwise><xsl:value-of select="t:author"/></xsl:otherwise></xsl:choose>
           </xsl:variable>
           
           <xsl:variable name="theKey">             
        
            <xsl:value-of select="concat(t:sanitize($titleBit),'|',t:sanitize($surname))"/>
     
           </xsl:variable>
          
       <xsl:copy select=".">
           <xsl:copy select="@*"/>
           <xsl:attribute name="n">
               <xsl:value-of select="$theKey"/>
           </xsl:attribute>
           <xsl:copy-of select="*"></xsl:copy-of>
       </xsl:copy><xsl:text>
</xsl:text>       
       </xsl:for-each>
       </listBibl>
    </xsl:template>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>pare back a string to contain only alphanumerics and some punctuation</desc>
    </doc>
 <xsl:function name="t:sanitize" as="xs:string">
  <xsl:param name="text"/>
  
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
