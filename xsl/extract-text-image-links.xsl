<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:ge="http://www.tei-c.org/ns/geneticEditions" 
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jul 30, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> Moritz Wissenbach</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    
    <xsl:output indent="yes"></xsl:output>

    <xsl:template match="/">
        <svg:svg width="5000" height="5000">
            <svg:g><title>Text-Image-Links</title>
                <xsl:apply-templates select="node()|@*"/>
            </svg:g>                
        </svg:svg>
    </xsl:template>

    <!-- find all zones for a suface and flatten the structure (i.e. un-nest zones) -->
    
    <xsl:template match="tei:surface">
            <xsl:apply-templates select="descendant::tei:zone"/>
    </xsl:template>
    
    <!-- nested zones are already copied, omit them -->
    
    <xsl:template match="tei:zone[./ancestor::tei:zone]"/>
    
    <!-- make rect elements from rectangular zones -->
    
    <xsl:template match="tei:zone[@ulx and @uly and @lrx and @lry]">
        <svg:rect class="imageannotationLine imageannotationLinked" fill="#FFFF00" fill-opacity="0.2" stroke-width="1">
            <xsl:attribute name="x" select="@ulx"/>
            <xsl:attribute name="y" select="@uly"/>
            <xsl:attribute name="width" select="number(./@lrx) - number(@ulx)"/>
            <xsl:attribute name="height" select="number(@lry) - number(@uly)"/>
        </svg:rect>
        <xsl:apply-templates select=".//text()"/>
                
        
    </xsl:template>
        
    <xsl:template match="text()"/>
    
    <xsl:template match="tei:zone[@ulx and @uly and @lrx and @lry]//text()">
        <svg:text font-size="100">
            <xsl:attribute name="x" select="(./ancestor::tei:zone[@ulx]/@ulx)[last()]"/>
            <xsl:attribute name="y" select="number((./ancestor::tei:zone[@lry]/@lry)[last()])"/>            
            <xsl:copy/>
        </svg:text>
    </xsl:template>
    
</xsl:stylesheet>
