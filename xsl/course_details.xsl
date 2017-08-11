<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:myfunct="http://cscie18.dce.harvard.edu/myfunct" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs myfunct" version="2.0">
    <xsl:import href="common.xsl"/>
    <xsl:output method="xhtml" encoding="UTF-8" doctype-system="about:legacy-compat"/>
    <xsl:variable name="pagetitle">Course Details</xsl:variable>
    <xsl:variable name="courseListPageName">course_groups</xsl:variable>
    <xsl:template match="courses">
        <link rel="stylesheet" property="stylesheet" type="text/css" href="css/course_groups.css"/>
        <div class="row">
            <div class="col-md-8 pull-left">
                <h3>
                    <xsl:text>Course Details</xsl:text>
                </h3>
            </div>
            <xsl:choose>
                <xsl:when test="count(course) &gt; 0">
                    <div class="col-md-4 hidden-md hidden-xs text-right">
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:text>course_details-pdf?</xsl:text>
                                <xsl:text>course_id=</xsl:text>
                                <xsl:value-of select="course/@course_id"/>
                                <xsl:text>&amp;</xsl:text>
                                <xsl:text>class_number=</xsl:text>
                                <xsl:value-of select="course/@class_number"/>
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
                                <xsl:text>course_details-pdf?</xsl:text>
                                <xsl:text>course_id=</xsl:text>
                                <xsl:value-of select="course/@course_id"/>
                                <xsl:text>&amp;</xsl:text>
                                <xsl:text>class_number=</xsl:text>
                                <xsl:value-of select="course/@class_number"/>
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
        <hr/>
        <div class="row">
            <div class="col-xs-12 col-md-12">
                <xsl:choose>
                    <xsl:when test="count(course) &gt; 0">
                        <xsl:apply-templates select="course"/>
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
        </div>
    </xsl:template>
    <xsl:template match="course">
        <table class="table">
            <colgroup>
                <col span="1" class="courseDetailsHeader"/>
                <col/>
            </colgroup>
            <tr>
                <td>
                    <xsl:text>Title</xsl:text>
                </td>
                <td>
                    <xsl:value-of select="catalog_info/title/text()"/>
                </td>
            </tr>
            <tr>
                <td>Short Title</td>
                <td>
                    <xsl:value-of select="catalog_info/title/@short_title"/>
                </td>
            </tr>
            <tr>
                <td>Year</td>
                <td>
                    <xsl:value-of select="@academic_year"/>
                </td>
            </tr>
            <tr>
                <td>Term</td>
                <td>
                    <xsl:value-of select="myfunct:term(@term_code)"/>
                </td>
            </tr>
            <tr>
                <td>Section</td>
                <td>
                    <xsl:value-of select="@section"/>
                </td>
            </tr>
            <tr>
                <td>Credits</td>
                <td>
                    <xsl:value-of select="catalog_info/credits/text()"/>
                </td>
            </tr>
            <tr>
                <td>Exam Date</td>
                <td>
                    <xsl:value-of select="catalog_info/exam_date/text()"/>
                </td>
            </tr>
            <tr>
                <td>School</td>
                <td>
                    <xsl:value-of select="@school_id"/>
                </td>
            </tr>
            <tr>
                <td>Department</td>
                <td>
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:value-of select="$courseListPageName"/>
                            <xsl:text>?department=</xsl:text>
                            <xsl:value-of select="catalog_info/department/@code"/>
                        </xsl:attribute>
                        <xsl:value-of select="catalog_info/department/text()"/>
                    </xsl:element>
                </td>
            </tr>
            <tr>
                <td>Course Group</td>
                <td>
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:value-of select="$courseListPageName"/>
                            <xsl:text>?group=</xsl:text>
                            <xsl:value-of select="catalog_info/course_group/@code"/>
                        </xsl:attribute>
                        <xsl:value-of select="catalog_info/course_group/text()"/>
                    </xsl:element>
                </td>
            </tr>
            <tr>
                <td>Course Type</td>
                <td>
                    <xsl:value-of select="catalog_info/course_type/text()"/>
                </td>
            </tr>
            <tr>
                <td>
                    <xsl:text>Description</xsl:text>
                </td>
                <td>
                    <xsl:value-of select="catalog_info/description/text()"/>
                </td>
            </tr>
            <tr>
                <td>
                    <xsl:text>Notes</xsl:text>
                </td>
                <td>
                    <xsl:value-of select="catalog_info/notes/text()"/>
                </td>
            </tr>
        </table>
        <table class="table">
            <tr>
                <th>Day of Week</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Location</th>
            </tr>
            <xsl:apply-templates select="catalog_info/meeting_schedule/meeting"/>
        </table>
        <table class="table">
            <tr>
                <th>Staff</th>
            </tr>
            <xsl:apply-templates select="staff/person"/>
        </table>
        <table class="table">
            <tr>
                <th>Course ID</th>
                <th>Class Number</th>
                <th>Department Code</th>
                <th>Course Group Code</th>
            </tr>
            <tr>
                <td>
                    <xsl:value-of select="@course_id"/>
                </td>
                <td>
                    <xsl:value-of select="@class_number"/>
                </td>
                <td>
                    <xsl:value-of select="catalog_info/department/@code"/>
                </td>
                <td>
                    <xsl:value-of select="catalog_info/course_group/@code"/>
                </td>
            </tr>
        </table>
    </xsl:template>
    <xsl:template match="meeting">
        <tr>
            <td>
                <xsl:value-of select="@days_of_week"/>
            </td>
            <td>
                <xsl:value-of select="myfunct:formatTime(@start_time)"/>
            </td>
            <td>
                <xsl:value-of select="myfunct:formatTime(@end_time)"/>
            </td>
            <td>
                <xsl:value-of select="@location"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="person">
        <tr>
            <td>
                <xsl:value-of select="display_name/text()"/>
            </td>
        </tr><!--
        <tr>
            <td>ID</td>
            <td>
                <xsl:value-of select="@id"/>
            </td>
        </tr>
        <tr>
            <td>Role</td>
            <td>
                <xsl:value-of select="@role"/>
            </td>
        </tr>
        <tr>
            <td>seniority_sort</td>
            <td>
                <xsl:value-of select="@seniority_sort"/>
            </td>
        </tr>
        -->
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
            <li>
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:text>#</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="onClick">
                        <xsl:text>history.go(-1);return true;</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Courses</xsl:text>
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