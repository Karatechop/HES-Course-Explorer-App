<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:myfunct="http://cscie18.dce.harvard.edu/myfunct" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs myfunct" version="2.0">
    <xsl:import href="common.xsl"/>
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:variable name="pagetitle">Courses</xsl:variable>
    <xsl:function name="myfunct:buildUrlPar">
        <xsl:text>department=</xsl:text>
        <xsl:value-of select="$departmentQuery"/>
        <xsl:text>&amp;</xsl:text>
        <xsl:text>group=</xsl:text>
        <xsl:value-of select="$groupQuery"/>
        <xsl:text>&amp;</xsl:text>
        <xsl:text>term=</xsl:text>
        <xsl:value-of select="$termQuery"/>
        <xsl:text>&amp;</xsl:text>
        <xsl:text>year=</xsl:text>
        <xsl:value-of select="$yearQuery"/>
        <xsl:text>&amp;</xsl:text>
        <xsl:text>daysOfWeek=</xsl:text>
        <xsl:value-of select="$daysOfWeekQuery"/>
        <xsl:text>&amp;</xsl:text>
        <xsl:text>time=</xsl:text>
        <xsl:value-of select="$timeQuery"/>
        <xsl:text>&amp;</xsl:text>
        <xsl:text>staff=</xsl:text>
        <xsl:value-of select="$staffQuery"/>
        <xsl:text>&amp;</xsl:text>
        <xsl:text>staffId=</xsl:text>
        <xsl:value-of select="$staffIdQuery"/>
        <xsl:text>&amp;</xsl:text>
        <xsl:text>search=</xsl:text>
        <xsl:value-of select="$searchQuery"/>
    </xsl:function>
    <xsl:function name="myfunct:buildUrl">
        <xsl:text>course_groups?</xsl:text>
        <xsl:value-of select="myfunct:buildUrlPar()"/>
        <xsl:text>&amp;</xsl:text>
        <xsl:text>start=</xsl:text>
    </xsl:function>
    <xsl:variable name="queryString" select="departments/@departmentQuery"/>
    <xsl:variable name="departmentQuery" select="departments/@departmentQuery"/>
    <xsl:variable name="groupQuery" select="departments/@groupQuery"/>
    <xsl:variable name="termQuery" select="departments/@termQuery"/>
    <xsl:variable name="yearQuery" select="departments/@yearQuery"/>
    <xsl:variable name="daysOfWeekQuery" select="departments/@daysOfWeekQuery"/>
    <xsl:variable name="timeQuery" select="departments/@timeQuery"/>
    <xsl:variable name="staffQuery" select="departments/@staffQuery"/>
    <xsl:variable name="staffIdQuery" select="departments/@staffIdQuery"/>
    <xsl:variable name="searchQuery" select="departments/@searchQuery"/>
    <xsl:template match="departments">
        <link rel="stylesheet" property="stylesheet" type="text/css" href="css/course_groups.css"/>
        <div class="row">
            <xsl:choose>
                <xsl:when test="count(department) &gt; 0">
                    <div class="col-md-8 pull-left">
                        <h2>
                            <xsl:text>Courses</xsl:text>
                        </h2>
                    </div>
                    <div class="col-md-4 hidden-md hidden-xs text-right">
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:text>course_groups-pdf?</xsl:text>
                                <xsl:value-of select="myfunct:buildUrlPar()"/>
                            </xsl:attribute>
                            <xsl:attribute name="class">
                                <xsl:text>btn btn-lg btn-success center</xsl:text>
                            </xsl:attribute>
                            <xsl:text>View as PDF</xsl:text>
                        </xsl:element>
                    </div>
                    <div class="col-md-4 visible-md visible-xs text-right">
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:text>course_groups-pdf?</xsl:text>
                                <xsl:value-of select="myfunct:buildUrlPar()"/>
                            </xsl:attribute>
                            <xsl:attribute name="class">
                                <xsl:text>btn btn-lg btn-success center</xsl:text>
                            </xsl:attribute>
                            <xsl:text>as PDF</xsl:text>
                        </xsl:element>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <div class="col-md-12">
                        <div class="alert alert-warning" role="alert">
                            <strong>No Results.</strong> - Please go back and try again.
                    </div>
                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="alert alert-success" role="alert">
                    <xsl:text>Department: </xsl:text>
                    <xsl:value-of select="@departmentQuery"/>
                    <xsl:text> / </xsl:text>
                    <xsl:text>Group: </xsl:text>
                    <xsl:value-of select="@groupQuery"/>
                    <xsl:text> / </xsl:text>
                    <xsl:text>Term: </xsl:text>
                    <xsl:value-of select="@termQuery"/>
                    <xsl:text> / </xsl:text>
                    <xsl:text>Year: </xsl:text>
                    <xsl:value-of select="@yearQuery"/>
                    <xsl:text> / </xsl:text>
                    <xsl:text>Days: </xsl:text>
                    <xsl:value-of select="@daysOfWeekQuery"/>
                    <xsl:text> / </xsl:text>
                    <xsl:text>Time: </xsl:text>
                    <xsl:value-of select="@timeQuery"/>
                    <xsl:text> / </xsl:text>
                    <xsl:text>Staff: </xsl:text>
                    <xsl:choose>
                        <xsl:when test="@staffQuery = ''">
                            <xsl:value-of select="@staffIdName"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@staffQuery"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text> / </xsl:text>
                    <xsl:text>Search: </xsl:text>
                    <xsl:value-of select="@searchQuery"/>
                </div>
                <xsl:apply-templates select="department"/>
            </div>
        </div>
        <div class="row">
            <xsl:call-template name="pageNav"/>
        </div>
    </xsl:template>
    <xsl:template match="department">
        <ul>
            <li class="departmentList">
                <div class="list-group-item active departmentHeader">
                    <xsl:text>Department: </xsl:text>
                    <xsl:value-of select="@name"/>
                </div>
                <xsl:if test="count(course_title) &gt; 0">
                    <xsl:apply-templates select="course_title"/>
                </xsl:if>
                <xsl:apply-templates select="course_group"/>
            </li>
        </ul>
    </xsl:template>
    <xsl:template match="course_group">
        <ul class="courseGroupList">
            <li>
                <br/>
                <div class="list-group-item departmentHeader">
                    <xsl:text>Course Group: </xsl:text>
                    <xsl:value-of select="@name"/>
                </div>
                <br/>
                <xsl:apply-templates select="course_title"/>
                <br/>
            </li>
        </ul>
    </xsl:template>
    <xsl:template match="course_title">
        <div class="panel panel-default">
            <div class="panel-heading">
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:text>course_details?course_id=</xsl:text>
                        <xsl:value-of select="@course_id"/>
                        <xsl:text>&amp;</xsl:text>
                        <xsl:text>class_number=</xsl:text>
                        <xsl:value-of select="@class_number"/>
                    </xsl:attribute>
                    <xsl:value-of select="title/text()"/>
                </xsl:element>
            </div>
            <div class="panel-body">
                <div class="col-xs-12">
                    <table class="table">
                        <xsl:choose>
                            <xsl:when test="count(meeting) = 0">
                                <thead>
                                    <tr>
                                        <th>Term:</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <xsl:value-of select="myfunct:term(@term_code)"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </xsl:when>
                            <xsl:otherwise>
                                <thead>
                                    <tr>
                                        <th>Term:</th>
                                        <th>Days:</th>
                                        <th>Time:</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:apply-templates select="meeting"/>
                                </tbody>
                            </xsl:otherwise>
                        </xsl:choose>
                    </table>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="meeting">
        <tr>
            <td>
                <xsl:value-of select="myfunct:term(@term_code)"/>
            </td>
            <td>
                <xsl:value-of select="@days_of_week"/>
            </td>
            <td>
                <xsl:value-of select="myfunct:formatTime(@start_time)"/>
                <xsl:text> - </xsl:text>
                <xsl:value-of select="myfunct:formatTime(@end_time)"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template name="pageNav">
        <div class="coursePages text-center">
            <xsl:variable name="pages" select="@pages"/>
            <xsl:variable name="page" select="@page"/>
            <ul class="pagination">
                <xsl:variable name="pageListRange">10</xsl:variable>
                <xsl:variable name="pageListBase">
                    <xsl:value-of select="(floor((number($page) - 1) div $pageListRange)*$pageListRange)"/>
                </xsl:variable>
                <xsl:variable name="pageListStart">
                    <xsl:value-of select="$pageListBase + 1"/>
                </xsl:variable>
                <xsl:variable name="pageListRangeLast">
                    <xsl:value-of select="$pageListBase + $pageListRange"/>
                </xsl:variable>
                <xsl:variable name="pageListLast">
                    <xsl:choose>
                        <xsl:when test="$pageListRangeLast &gt; number($pages)">
                            <xsl:value-of select="$pages"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$pageListRangeLast"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable><!-- Previous Button -->
                <xsl:element name="li">
                    <xsl:attribute name="class">
                        <xsl:choose>
                            <xsl:when test="$pageListStart &lt; ($pageListRange + 1)">
                                <xsl:text>disabled</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>enabled</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:value-of select="myfunct:buildUrl()"/>
                            <xsl:value-of select="$pageListStart - 1"/>
                        </xsl:attribute>
                        <xsl:text>«</xsl:text>
                    </xsl:element>
                </xsl:element><!-- Page Buttons -->
                <xsl:for-each select="$pageListStart to $pageListLast">
                    <xsl:variable name="curVal" select="."/>
                    <xsl:element name="li">
                        <xsl:attribute name="class">
                            <xsl:choose>
                                <xsl:when test="number($curVal) = number($page)">
                                    <xsl:text>active</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>inactive</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="myfunct:buildUrl()"/>
                                <xsl:value-of select="$curVal"/>
                            </xsl:attribute>
                            <xsl:value-of select="$curVal"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:for-each><!-- Next Button -->
                <xsl:element name="li">
                    <xsl:attribute name="class">
                        <xsl:choose>
                            <xsl:when test="$pageListLast = number($pages)">
                                <xsl:text>disabled</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>enabled</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:value-of select="myfunct:buildUrl()"/>
                            <xsl:value-of select="$pageListLast + 1"/>
                        </xsl:attribute>
                        <xsl:text>»</xsl:text>
                    </xsl:element>
                </xsl:element>
            </ul>
        </div>
    </xsl:template>
    <xsl:template name="breadcrumb">
        <ol class="breadcrumb">
            <li>
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:text>index.html</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Home</xsl:text>
                </xsl:element>
            </li>
            <li>
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:text>form</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Search</xsl:text>
                </xsl:element>
            </li>
            <li class="active">
                <xsl:value-of select="$pagetitle"/>
            </li>
        </ol>
    </xsl:template>
    <xsl:template match="text()"/>
    <xsl:function name="myfunct:term">
        <xsl:param name="rawTerm"/>
        <xsl:value-of select="concat(upper-case(substring($rawTerm, 1, 1)), lower-case(substring($rawTerm, 2)))"/>
    </xsl:function>
    <xsl:function name="myfunct:formatTime">
        <xsl:param name="time"/>
        <xsl:choose>
            <xsl:when test="(string($time) castable as xs:time)">
                <xsl:value-of select="format-time($time,'[h1]:[m01] [P]')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
</xsl:stylesheet>