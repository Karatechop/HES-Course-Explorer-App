<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:import href="common.xsl"/>
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:variable name="pagetitle">Form</xsl:variable>
    <xsl:variable name="courseListingPage">course_groups</xsl:variable>
    <xsl:template match="departments">
        <div class="row">
            <div class="col-md-12">
                <form class="form-horizontal" action="./course_groups" method="post" name="course_search_form" id="course_search_form" accept-charset="utf-8">
                    <fieldset>
                        <div class="page-header">
                            <h3>Submit search form</h3>
                            <p>or use menu to change search mode</p>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="term">Term</label>
                            <div class="col-md-4">
                                <select id="term" name="term" class="form-control">
                                    <option value="">Any</option>
                                    <option value="spring">Spring</option>
                                    <option value="fall">Fall</option>
                                </select>
                                <p class="help-block">Select term</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right" for="department">Department</label>
                            <div class="col-md-4">
                                <input id="department" name="department" type="search" placeholder="Any department" class="form-control input-md"/>
                                <p class="help-block">Start typing and select one of the suggested options</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right">Weekdays</label>
                            <div class="col-md-5">
                                <label class="checkbox-inline" for="daysOfWeek-0">
                                    <input type="checkbox" name="daysOfWeek" id="daysOfWeek-0" value="Any"/>
                                              Any
                                            </label>
                                <label class="checkbox-inline" for="daysOfWeek-1">
                                    <input type="checkbox" name="daysOfWeek" id="daysOfWeek-1" value="Monday"/>
                                              Mon
                                            </label>
                                <label class="checkbox-inline" for="daysOfWeek-2">
                                    <input type="checkbox" name="daysOfWeek" id="daysOfWeek-2" value="Tuesday"/>
                                              Tue
                                            </label>
                                <label class="checkbox-inline" for="daysOfWeek-3">
                                    <input type="checkbox" name="daysOfWeek" id="daysOfWeek-3" value="Wednesday"/>
                                              Wed
                                            </label>
                                <label class="checkbox-inline" for="daysOfWeek-4">
                                    <input type="checkbox" name="daysOfWeek" id="daysOfWeek-4" value="Thursday"/>
                                              Thu
                                            </label>
                                <label class="checkbox-inline" for="daysOfWeek-5">
                                    <input type="checkbox" name="daysOfWeek" id="daysOfWeek-5" value="Friday"/>
                                              Fri
                                            </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right" for="time">Time</label>
                            <div class="col-md-4">
                                <input id="time" name="time" type="text" placeholder="00:00" class="form-control input-md"/>
                                <p class="help-block">Course start time in HH:MM format</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right" for="staff">Staff</label>
                            <div class="col-md-4">
                                <input id="staff" name="staff" type="text" placeholder="John Doe" class="form-control input-md"/>
                                <p class="help-block">Start typing and select one of the suggested options</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label text-right" for="search">General search</label>
                            <div class="col-md-4">
                                <input id="search" name="search" type="text" placeholder="Custom search" class="form-control input-md"/>
                                <p class="help-block">Use this field for your custom search</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-offset-4 col-md-4">
                                <div class="btn-toolbar">
                                    <input type="submit" class="btn btn-primary" value="Submit"/>
                                    <input type="reset" class="btn btn-default" value="Reset"/>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="autoComplete_departmentList">
        <script>
                var autoComplete_departmentList = [ 
               <xsl:for-each select="*"> 
                 {value:'<xsl:value-of select="@value"/>',label:'<xsl:value-of select="@label"/>'},
                </xsl:for-each>
               {value:"",label:""}];
        </script>
    </xsl:template>
    <xsl:template match="autoComplete_staffList">
        <script>
                var autoComplete_staffList = [ 
               <xsl:for-each select="*"> 
                 "<xsl:value-of select="@label"/>",
                </xsl:for-each>
                ''];
        </script>
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