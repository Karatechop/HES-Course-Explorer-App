<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0"><!-- XSLT that should produce XSL-FO content from Course data for rendering to PDF-->
    <xsl:output method="xml"/>
    <xsl:attribute-set name="normal">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="conference-title">
        <xsl:attribute name="font-family">Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">18pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="padding">1em</xsl:attribute>
    </xsl:attribute-set>
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set><!-- fo:layout-master-set defines in its children the page layout: 
        the pagination and layout specifications
        - page-masters: have the role of describing the intended subdivisions 
        of a page and the geometry of these subdivisions 
        In this case there is only a simple-page-master which defines the 
        layout for all pages of the text
        --><!-- layout information -->
                <fo:simple-page-master master-name="simple" page-height="11in" page-width="8.5in" margin-top="1.0in" margin-bottom="1.0in" margin-left="1.25in" margin-right="1.25in">
                    <fo:region-body margin-top="0.25in"/>
                    <fo:region-before extent="0.5in"/>
                </fo:simple-page-master>
            </fo:layout-master-set><!-- end: defines page layout --><!-- start page-sequence
      here comes the text (contained in flow objects)
      the page-sequence can contain different fo:flows 
      the attribute value of master-name refers to the page layout
      which is to be used to layout the text contained in this
      page-sequence-->
            <fo:page-sequence master-reference="simple"><!-- fo:static-content for header -->
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block font-size="8pt" text-align="end"> Courses, Page
            <fo:page-number/>
                        <xsl:text> of </xsl:text>
                        <fo:page-number-citation ref-id="theEnd"/>
                    </fo:block>
                </fo:static-content><!-- start fo:flow
        each flow is targeted 
        at one (and only one) of the following:
        xsl-region-body (usually: normal text)
        xsl-region-before (usually: header)
        xsl-region-after  (usually: footer)
        xsl-region-start  (usually: left margin) 
        xsl-region-end    (usually: right margin)
        ['usually' applies here to languages with left-right and top-down 
        writing direction like English]
        in this case there is only one target: xsl-region-body
        -->
                <fo:flow flow-name="xsl-region-body">
                    <fo:block>
                        <fo:block xsl:use-attribute-sets="conference-title" background-color="rgb(164,16,52)"> 
                        Courses offered  by department:<xsl:value-of select="//courses/@department"/>
                        </fo:block><!-- generate table of contents -->
                        <fo:block>
                            <xsl:apply-templates select="/courses" mode="toc"/>
                            <xsl:text/>
                        </fo:block><!-- main content -->
                        <xsl:apply-templates select="/courses" mode="main"/>
                    </fo:block><!-- last block for "theEnd" id -->
                    <fo:block id="theEnd"/>
                </fo:flow><!-- closes the flow element-->
            </fo:page-sequence><!-- closes the page-sequence -->
        </fo:root>
    </xsl:template>
    <xsl:template match="courses" mode="main">
        <xsl:for-each select="/courses/course">
            <xsl:sort select="./@catalog_info_title"/>
            <xsl:sort select="./@class_number"/>
            <fo:block id="{generate-id()}" break-before="page" xsl:use-attribute-sets="conference-title">
                <xsl:value-of select="./@catalog_info_title"/>
            </fo:block>
            <fo:table>
                <fo:table-column column-width="1in"/>
                <fo:table-column column-width="5in"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                            Title
                          </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                                <xsl:value-of select="./@title"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                            Instructors:
                          </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                                <xsl:for-each select="./staff/person">
                                    <xsl:sort select="./@role"/>
                                    <xsl:sort select="./@seniority_sort"/>
                                    <fo:block linefeed-treatment="preserve">
                                        <xsl:value-of select="@name"/>
                                    </fo:block>
                                </xsl:for-each>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                            Year:
                          </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                                <xsl:value-of select="./@year"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                            Term:
                          </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                                <xsl:value-of select="./@term"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                            Class number:
                          </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                                <xsl:value-of select="./@class_number"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                            Credits:
                          </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                                <xsl:value-of select="./@credits"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                            Department:
                          </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                                <xsl:value-of select="./@department"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                            Meeting:
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                                <xsl:choose>
                                    <xsl:when test="@start ne ''">
                                            from: <xsl:value-of select="@start"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                            Start time not Specified
                                        </xsl:otherwise>
                                </xsl:choose> 
                                  --
                                    <xsl:choose>
                                    <xsl:when test="@end ne ''">
                                           to: <xsl:value-of select="@end"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                            End time not Specified
                                        </xsl:otherwise>
                                </xsl:choose>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                            Description:
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                                <xsl:value-of select="./description"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding="0.5em">
                            <fo:block/>
                        </fo:table-cell>
                        <fo:table-cell padding="0.5em">
                            <fo:block>
                                <xsl:value-of select="./notes"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="courses" mode="toc">
        <xsl:for-each select="/courses/course">
            <xsl:sort select="./@catalog_info_title"/>
            <xsl:sort select="./@class_number"/>
            <fo:block text-align-last="justify">
                <fo:basic-link>
                    <xsl:attribute name="internal-destination">
                        <xsl:value-of select="generate-id()"/>
                    </xsl:attribute>
                    <xsl:value-of select="./@catalog_info_title"/> (CN:
                     <xsl:value-of select="./@class_number"/>)
                </fo:basic-link>
                <fo:leader leader-pattern="dots"/>
                <fo:page-number-citation>
                    <xsl:attribute name="ref-id">
                        <xsl:value-of select="generate-id()"/>
                    </xsl:attribute>
                </fo:page-number-citation>
            </fo:block>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>