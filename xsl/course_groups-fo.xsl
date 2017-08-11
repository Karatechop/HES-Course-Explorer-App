<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:functx="http:/functx.com/" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="all-pages" page-height="11in" page-width="8.5in" margin-top="1.0in" margin-bottom="1.0in" margin-left="1.0in" margin-right="1.0in">
                    <fo:region-body margin-top="0.25in"/>
                    <fo:region-before extent="0.5in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="all-pages">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block font-size="8pt" text-align="end" xsl:use-attribute-sets="normal">
                        <xsl:text>Courses</xsl:text>
                        <xsl:text>, Page </xsl:text>
                        <fo:page-number/>
                        <xsl:text> of </xsl:text>
                        <fo:page-number-citation ref-id="EndOfDoc"/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block>
                        <fo:block xsl:use-attribute-sets="doctitle">COURSES</fo:block>
                        <fo:block>
                            <xsl:apply-templates select="departments/department/course_group/course_title" mode="toc">
                                <xsl:sort select="." data-type="text"/>
                                <xsl:sort select="./@short_title"/>
                            </xsl:apply-templates>
                        </fo:block>
                        <fo:block>
                            <xsl:apply-templates select="departments/department/course_group/course_title" mode="main">
                                <xsl:sort select="." data-type="text"/>
                                <xsl:sort select="./@short_title"/>
                            </xsl:apply-templates>
                        </fo:block>
                    </fo:block>
                    <fo:block id="EndOfDoc"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <xsl:template match="course_title" mode="toc">
        <fo:block text-align-last="justify" xsl:use-attribute-sets="small">
            <fo:basic-link internal-destination="{generate-id()}">
                <xsl:value-of select="@short_title"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="."/>
                <fo:leader leader-pattern="dots"/>
                <fo:page-number-citation>
                    <xsl:attribute name="ref-id">
                        <xsl:value-of select="generate-id()"/>
                    </xsl:attribute>
                </fo:page-number-citation>
            </fo:basic-link>
        </fo:block>
    </xsl:template>
    <xsl:template match="course_title" mode="main">
        <xsl:for-each select=".">
            <fo:block space-before="1.0in" id="{generate-id()}" keep-together.within-page="always">
                <fo:block xsl:use-attribute-sets="coursetitle">
                    <xsl:value-of select="@short_title"/>
                    <fo:leader leader-pattern="space"/>
                    <xsl:value-of select="."/>
                </fo:block>
                <fo:block xsl:use-attribute-sets="normal">
                    <fo:table>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>
                                        <xsl:text>TERM: </xsl:text>
                                        <xsl:value-of select="upper-case(@term_code)"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block>
                                        <xsl:text>CLASS NUMBER: </xsl:text>
                                        <xsl:value-of select="@class_number"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block>
                                        <xsl:text>COURSE ID: </xsl:text>
                                        <xsl:value-of select="@course_id"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
                <fo:block>
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
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
                <xsl:apply-templates select="title/meeting" mode="meeting_times"/>
            </fo:block>
        </xsl:for-each>
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
                            <xsl:value-of select="@start_time"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="@end_time"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:attribute-set name="normal">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="small">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="doctitle">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">18pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="padding">1em</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="coursetitle">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>