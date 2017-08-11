<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:functx="http:/functx.com/" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="all-pages" page-height="11in" page-width="8.5in" margin-top="0.5in" margin-bottom="1.0in" margin-left="1.0in" margin-right="1.0in">
                    <fo:region-body margin-top="0.25in"/>
                    <fo:region-before extent="0.5in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="all-pages">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block>
                        <fo:block xsl:use-attribute-sets="doctitle">COURSE DETAILS</fo:block>
                        <xsl:apply-templates select="/courses" mode="main"/>
                        <fo:block/>
                        <fo:block space-before="0.5in" xsl:use-attribute-sets="normal">
                            <fo:block font-weight="bold">
                                <fo:table>
                                    <fo:table-body>
                                        <fo:table-row>
                                            <fo:table-cell>
                                                <fo:block>
                                                    <xsl:text>Day</xsl:text>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block>
                                                    <xsl:text>Start Time</xsl:text>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block>
                                                    <xsl:text>End Time</xsl:text>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block>
                                                    <xsl:text>Location</xsl:text>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </fo:table-body>
                                </fo:table>
                            </fo:block>
                            <xsl:apply-templates select="/courses/course/catalog_info/meeting_schedule/meeting" mode="meeting_times"/>
                        </fo:block>
                        <fo:block>
                            <fo:block space-before="0.5in" xsl:use-attribute-sets="normal" font-weight="bold">STAFF</fo:block>
                            <xsl:apply-templates select="/courses/course/staff/person" mode="staff"/>
                        </fo:block>
                        <fo:block space-before="0.5in">
                            <xsl:apply-templates select="/courses/course" mode="course_details"/>
                        </fo:block>
                    </fo:block>
                    <fo:block id="EndOfDoc"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template><!--MAIN CODE-->
    <xsl:template match="courses" mode="main">
        <fo:block space-before="0.5in" keep-together.within-page="always">
            <fo:block xsl:use-attribute-sets="coursetitle">
                <xsl:value-of select="course/catalog_info/title/text()"/>
            </fo:block>
            <fo:block xsl:use-attribute-sets="small">
                <xsl:text>Short Title: </xsl:text>
                <xsl:value-of select="course/catalog_info/title//@short_title"/>
                <fo:leader leader-pattern="space"/>
                <xsl:text>Term: </xsl:text>
                <xsl:value-of select="course/upper-case(@term_code)"/>
                <xsl:value-of select="course/@academic_year"/>
            </fo:block>
            <fo:block xsl:use-attribute-sets="small">
                <xsl:text>Section: </xsl:text>
                <xsl:value-of select="course/@section"/>
                <fo:leader leader-pattern="space"/>
                <fo:leader leader-pattern="space"/>
                <xsl:text>Credits: </xsl:text>
                <xsl:value-of select="course/catalog_info/credits/text()"/>
                <fo:leader leader-pattern="space"/>
                <fo:leader leader-pattern="space"/>
                <xsl:text>School: </xsl:text>
                <xsl:value-of select="course/upper-case(@school_id)"/>
            </fo:block>
            <fo:block xsl:use-attribute-sets="normal">
                <fo:inline font-weight="bold">
                    <xsl:text>Department: </xsl:text>
                </fo:inline>
                <xsl:value-of select="course/catalog_info/department/text()"/>
            </fo:block>
            <fo:block xsl:use-attribute-sets="normal">
                <fo:inline font-weight="bold">
                    <xsl:text>Course Type: </xsl:text>
                </fo:inline>
                <xsl:value-of select="course/catalog_info/course_type/text()"/>
            </fo:block>
            <fo:block space-before="0.1in" xsl:use-attribute-sets="coursedesc">
                <xsl:value-of select="course/catalog_info/description/text()"/>
            </fo:block>
        </fo:block>
    </xsl:template>
    <xsl:template match="meeting" mode="meeting_times">
        <fo:table xsl:use-attribute-sets="normal">
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="@days_of_week"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="format-time(@start_time, '[H01]:[m01] [P]')"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="format-time(@end_time, '[H01]:[m01] [P]')"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="@location"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template match="person" mode="staff">
        <xsl:for-each select=".">
            <fo:block xsl:use-attribute-sets="normal">
                <xsl:value-of select="display_name/text()"/>
            </fo:block>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="course" mode="course_details">
        <fo:table xsl:use-attribute-sets="small">
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block font-weight="bold">
                            <xsl:text>Course Id: </xsl:text>
                            <xsl:value-of select="@course_id"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block font-weight="bold">
                            <xsl:text>Class Number: </xsl:text>
                            <xsl:value-of select="@class_number"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:text>Department Code: </xsl:text>
                            <xsl:value-of select="catalog_info/department/@code"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:text>Course Group Code: </xsl:text>
                            <xsl:value-of select="catalog_info/course_group/@code"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:attribute-set name="normal">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="small">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="doctitle">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">16pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="padding">1em</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="coursetitle">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-size">14pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="coursedesc">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>