<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cscie18="http://cscie18.dce.harvard.edu" exclude-result-prefixes="xs cscie18" version="2.0">
    <xsl:variable name="sitetitle_long">Harvard University Faculty of Arts &amp; Sciences Course Catalog</xsl:variable>
    <xsl:variable name="sitetitle_short">HU FAS Catalog</xsl:variable>
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="utf-8"/>
                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <xsl:comment>The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags</xsl:comment>
                <title>
                    <xsl:value-of select="$sitetitle_long"/>
                </title>
                <xsl:comment>Bootstrap</xsl:comment>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"/>
                <link rel="stylesheet" href=".//css/jQuery.css"/>
                <xsl:comment>HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries</xsl:comment>
                <xsl:comment>WARNING: Respond.js doesn't work if you view the page via file://</xsl:comment>
                <xsl:comment>[if lt IE 9]&gt;
      &lt;script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"&gt;&lt;/script&gt;
      &lt;script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"&gt;&lt;/script&gt;
    &lt;![endif]</xsl:comment>
            </head>
            <body>
                <div id="top" class="container-fluid">
                    <div class="row">
                        <div class="center-block col-md-8" style="float: none;"><!--navbar -->
                            <nav class="navbar navbar-default navbar-static-top">
                                <div class="container col-md-12">
                                    <div class="navbar-header">
                                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                                            <span class="sr-only">Toggle navigation</span>
                                            <span class="icon-bar"/>
                                            <span class="icon-bar"/>
                                            <span class="icon-bar"/>
                                        </button>
                                        <a class="navbar-brand hidden-md hidden-xs" href="http://www.fas.harvard.edu/">
                                            <xsl:value-of select="$sitetitle_long"/>
                                        </a>
                                        <a class="navbar-brand visible-md visible-xs" href="http://www.fas.harvard.edu/">
                                            <xsl:value-of select="$sitetitle_short"/>
                                        </a>
                                    </div>
                                    <div id="navbar" class="navbar-collapse collapse">
                                        <ul class="nav navbar-nav navbar-right">
                                            <li class="visible-md visible-xs">
                                                <a href="./departments">Explore departments</a>
                                            </li>
                                            <li class="visible-md visible-xs">
                                                <a href="./form">Advanced search form</a>
                                            </li>
                                            <li class="visible-md visible-xs">
                                                <a href="./staff">Explore faculty staff</a>
                                            </li>
                                            <li class="visible-md visible-xs">
                                                <a href="index.html">Home</a>
                                            </li>
                                            <li class="dropdown hidden-md hidden-xs active">
                                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Select search mode <span class="caret"/>
                                                </a>
                                                <ul class="dropdown-menu">
                                                    <li>
                                                        <a href="./departments">Explore departments</a>
                                                    </li>
                                                    <li>
                                                        <a href="./form">Advanced search form</a>
                                                    </li>
                                                    <li>
                                                        <a href="./staff">Explore faculty staff</a>
                                                    </li>
                                                    <li>
                                                        <a href="index.html">Home</a>
                                                    </li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div><!--/.nav-collapse -->
                                </div>
                            </nav>
                            <div class="hidden-xs">
                                <xsl:call-template name="breadcrumb"/>
                            </div>
                            <xsl:apply-templates/>
                            <ol class="breadcrumb pull-right">
                                <li class="pull-right">
                                    <a href="#top">Back to top</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </div><!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js">
                    <xsl:text/>
                </script><!-- Include all compiled plugins (below), or include individual files as needed -->
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js">
                    <xsl:text/>
                </script><!-- jQuery UI tabs -->
                <script src="//code.jquery.com/jquery-1.10.2.js">
                    <xsl:text/>
                </script><!-- Include all compiled plugins (below), or include individual files as needed -->
                <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js">
                    <xsl:text/>
                </script>
                <script>
                    <xsl:text> 
                    $(function() {
                        
                        $( "#department" ).autocomplete({
                         source: autoComplete_departmentList
                        });
                        
                        $( "#staff" ).autocomplete({
                         source: autoComplete_staffList
                        }); 
                        
                        
                        });
                   
                  </xsl:text>
                </script>
            </body>
        </html>
    </xsl:template>
    <xsl:template name="breadcrumb">
        <ol class="breadcrumb">
            <li class="active">
                <xsl:value-of select="$pagetitle"/>
            </li>
        </ol>
    </xsl:template>
</xsl:stylesheet>