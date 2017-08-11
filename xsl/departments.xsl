<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:import href="common.xsl"/>
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:variable name="pagetitle">Departments</xsl:variable>
    <xsl:variable name="courseListingPage">course_groups</xsl:variable>
    <xsl:template match="departments">
        <div class="row">
            <div class="col-md-8 col-xs-12 text-center">
                <h3>Select a department or a department course group</h3>
                <p>or use menu to switch between search modes</p>
            </div>
            <div class="col-md-4 col-xs-12">
                <a href="#" class="btn btn-lg btn-success pull-right hidden-xs" data-toggle="dropdown" aria-expanded="false">
                    Export courses<br/> by department
                        <span class="caret"/>
                </a>
                <a href="#" class="btn btn-lg btn-success center visible-xs" data-toggle="dropdown" aria-expanded="false">
                    Export courses by department
                        <span class="caret"/>
                </a>
                <ul class="dropdown-menu">
                    <xsl:apply-templates select="department" mode="exportAsPdf"/>
                </ul>
            </div>
        </div>
        <hr/>
        <div class="row">
            <xsl:apply-templates select="department" mode="main"/>
        </div>
    </xsl:template>
    <xsl:template match="department" mode="main">
        <div class="col-sm-12">
            <div class="list-group">
                <a href="{concat('./', $courseListingPage,'?department=',encode-for-uri(@code))}" class="list-group-item active">
                    <xsl:choose>
                        <xsl:when test="@name ne ''">
                            <xsl:value-of select="@name"/>
                        </xsl:when>
                        <xsl:otherwise>
                        NO DEPARTMENT / <i>courses not related to a specific department</i>
                        </xsl:otherwise>
                    </xsl:choose>
                </a>
                <xsl:apply-templates select="group"/>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="group">
        <a href="{concat('./', $courseListingPage,'?group=',encode-for-uri(@code))}" class="list-group-item">
            <xsl:value-of select="text()"/>
        </a>
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
    <xsl:template match="department" mode="exportAsPdf">
        <li>
            <a href="{concat('./', 'all_courses.pdf','?department=',encode-for-uri(@code))}">
                <xsl:value-of select="@name"/>
            </a>
        </li>
    </xsl:template>
</xsl:stylesheet>