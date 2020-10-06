<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:marcrel="http://id.loc.gov/vocabulary/relators/"
    xmlns:pgterms="http://www.gutenberg.org/2009/pgterms/"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:cc="http://web.resource.org/cc/"
    xmlns:dcam="http://purl.org/dc/dcam/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:t="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="#all"
    version="2.0">
    <xsl:output omit-xml-declaration="yes"/>
    
   <xsl:template match="/">
       <xsl:apply-templates select="//pgterms:ebook"/>
   </xsl:template>
    
    <xsl:template match="pgterms:ebook">
       <xsl:variable name="pgNum">
           <xsl:value-of select="substring-after(@rdf:about,'ebooks/')"/>
       </xsl:variable>
        <xsl:variable name="birth">
            <xsl:value-of select="dcterms:creator[1]/pgterms:agent[1]/pgterms:birthdate"/>
        </xsl:variable>
        <xsl:choose>
        <xsl:when test="marcrel:edt">
            <xsl:comment><xsl:value-of select='concat("Ignoring",$pgNum," : has marcrel:edt")'/> </xsl:comment>
        </xsl:when>
            <xsl:when test="$birth and not(matches(dcterms:creator[1]/pgterms:agent[1]/pgterms:birthdate, '18\d\d'))">
                <xsl:comment><xsl:value-of select='concat("Ignoring ",$pgNum," : has no 19th c date")'/> </xsl:comment>               
            </xsl:when>    
        
            <xsl:otherwise>
                <xsl:variable name="title">
                    <xsl:value-of select="//dcterms:title"/>                            
                </xsl:variable>
             <xsl:variable name="titleBit">
              <xsl:analyze-string regex='(^[^.,;:/]+)' select="replace($title,'(^Mrs?)\.','$1')">
               <xsl:matching-substring>
                <xsl:value-of select="regex-group(1)"/>
               </xsl:matching-substring>
              </xsl:analyze-string>
             </xsl:variable>
             
                <xsl:variable name="author">
                    <xsl:value-of select="dcterms:creator[1]/pgterms:agent/pgterms:name"/>
                </xsl:variable>
             
             <xsl:variable name="surname">
              <xsl:choose>
               <xsl:when test="contains($author, ',')">
                <xsl:value-of select="substring-before($author,',')"/>
               </xsl:when>
               <xsl:when test="contains($author, ' ')">
                <xsl:value-of select="tokenize($author,' ')[last()]"/>
               </xsl:when>                
               <xsl:otherwise><xsl:value-of select="$author"/></xsl:otherwise></xsl:choose>
             </xsl:variable>
            <xsl:variable name="theKey">                         
              <xsl:value-of select="concat(t:sanitize($titleBit),'|',t:sanitize($surname))"/>
             </xsl:variable>
             
               
           <bibl xml:id="{$pgNum}" n="{$theKey}">
            <title>
                <xsl:value-of select="//dcterms:title"/>              
            </title>
            
        <xsl:for-each select="dcterms:creator">
        
       <xsl:variable name="bdate">
           <xsl:value-of select="pgterms:agent[1]/pgterms:birthdate"/>           
       </xsl:variable>
        <xsl:variable name="obit">
            <xsl:value-of select="pgterms:agent[1]/pgterms:deathdate"/>           
        </xsl:variable>
            
            <xsl:choose>
                <xsl:when test="matches($bdate,'18\d\d') and matches($obit, '1[89]\d\d')">
                    <author>                      
                        <xsl:value-of select="concat(pgterms:agent/pgterms:name, '(', $bdate, '-', $obit, ')')"/>
                    </author>         
                </xsl:when>
                <xsl:otherwise>
                    <author>
                        <xsl:value-of select="pgterms:agent/pgterms:name"/>
                    </author>               
                 </xsl:otherwise>
            </xsl:choose>           
        </xsl:for-each></bibl>
        </xsl:otherwise></xsl:choose>
       <xsl:text>
</xsl:text>
   </xsl:template> 
    
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