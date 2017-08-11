#### Harvard Extension School December 2015
# CSCIE 18 Web development using XML Final Project


## Team
Team name: xTeam

Team members: 
* Frank Krazer
* Gwong Long
* Otto Luna
* Dimitri Olchanyi
* Boris Rugel

## Introduction
The website developed by the xTeam allows users to easily and efficiently search the
catalog of courses offered by the Harvard University Faculty of Arts & Sciences (FAS).
This report presents an overview of how the website was developed, including
information on the website’s browse and search features, its structure and design, as
well as the various XML technologies employed by its developers. In addition to a
fullyfeatured
HTML platform, the site also includes content in Mobile and PDF formats.
The Bootstrap framework was used to create a common layout and design for each
page and was also employed to achieve a mobileready
responsive design.
The application was built using eXistdb, an opensource,
native XML database.
To deploy the application:
* Clone this repository
* Take the **cscie18xteamfinalproject0.1.
xar** file located in the Build directory and
upload to eXistdb using the Package Manager
* Go to http://localhost:8080/exist/apps/cscie18xteamfinalproject/index.html to
access the website’s landing page.
* If the home page (or any other page) takes a long time to load (more than 30
seconds), make a small modification to the.xconf file located in the Data directory
(for example, add a line of empty space) and save it. After this modification,
indexing will be reapplied to the collection of XML source files and all pages
should load significantly faster.

## Project description
You can find a comprehensive project description in [here](../master/CSCIE-18FinalProjectxTeam%20Report.pdf).