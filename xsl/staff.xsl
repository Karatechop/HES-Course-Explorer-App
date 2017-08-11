<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:import href="common.xsl"/>
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:variable name="pagetitle">Staff</xsl:variable>
    <xsl:variable name="courseListingPage">course_groups</xsl:variable>
    <xsl:template match="departments">
        <div class="row">
            <div class="col-md-12">
                <div class="page-header text-center">
                    <h3>Explore faculty staff members by departments</h3>
                    <p>or use menu to switch between search modes</p>
                </div>
                <xsl:apply-templates select="department" mode="staff"/>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="department" mode="staff">
        <div class="btn-toolbar col-md-6">
            <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                <xsl:choose>
                    <xsl:when test="@name ne ''">
                        <xsl:value-of select="@name"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <i>No specific department</i>
                    </xsl:otherwise>
                </xsl:choose>
                <span class="caret"/>
            </a>
            <ul class="dropdown-menu">
                <xsl:apply-templates select="staff/person"/>
            </ul>
        </div>
    </xsl:template>
    <xsl:template match="staff/person">
        <li>
            <a href="{concat('./', $courseListingPage,'?staff=',encode-for-uri(display_name))}">
                <xsl:value-of select="display_name"/>
            </a>
        </li>
    </xsl:template>
    <xsl:template name="breadcrumb">
        <ol class="breadcrumb">
            <li>
                <a href="index.html">Home</a>
            </li>
            <li class="active">
                <xsl:value-of select="$pagetitle"/>
            </li>
        </ol>
    </xsl:template>
</xsl:stylesheet>