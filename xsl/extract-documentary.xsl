<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:ge="http://www.tei-c.org/ns/geneticEditions" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jul 30, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> Moritz Wissenbach</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    
    <!-- exclude text -->

    <xsl:template match="/tei:TEI/tei:text"/>

    <!-- rename source doc to legacy name -->

    <xsl:template match="tei:sourceDoc">
        <ge:document>
            <xsl:apply-templates select="node()|@*"/>
        </ge:document>
    </xsl:template>

    <!-- find all zones for a suface and flatten the structure (i.e. un-nest zones) -->

    <xsl:template match="tei:surface">
        <xsl:copy>
            <xsl:apply-templates select="descendant::tei:zone"/>
        </xsl:copy>
    </xsl:template>

    <!-- nested zones are already copied, omit them -->

    <xsl:template match="tei:zone[./ancestor::tei:zone]"/>

    <!-- rename zones to lines (faustedition can only position lines) -->
    
    <xsl:template match="tei:zone">
        <ge:line>
            <xsl:apply-templates select="node()|@*"/>
        </ge:line>
    </xsl:template>
    
    <!-- remove line tags -->
    
    <xsl:template match="tei:line">
        <xsl:apply-templates select="node()|@*"/>
    </xsl:template>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
