xquery version "3.0";

(: exist variables :)
declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:prefix external;
declare variable $exist:root external;

(: Other variables :)
declare variable $home-page-url := "index.html";
declare variable $collection_path := concat($exist:root, '/', $exist:controller, '/data/courses');

(: If trailing slash is missing, put it there and do a browser-redirect :)
if ($exist:path eq "") then
    <dispatch
        xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect
            url="{request:get-uri()}/"/>
    </dispatch>
    
(: If there is no resource specified, browser-redirect to home page.
 : change this from "test" :)
else
    if ($exist:resource eq "") then
        <dispatch
            xmlns="http://exist.sourceforge.net/NS/exist">
            <redirect
                url="{$home-page-url}"/>
        </dispatch>

else
    if ($exist:resource eq 'departments') then
            <dispatch
            xmlns="http://exist.sourceforge.net/NS/exist">
            <forward
                url="{$exist:controller}/xquery/departments.xq">
                <set-attribute
                    name="collection_path"
                    value="{$collection_path}"/>
                <set-attribute
                    name="exist.root"
                    value="{$exist:root}"/>
                <set-attribute
                    name="exist.path"
                    value="{$exist:path}"/>
                <set-attribute
                    name="exist.resource"
                    value="{$exist:resource}"/>
                <set-attribute
                    name="exist.controller"
                    value="{$exist:controller}"/>
                <set-attribute
                    name="exist.prefix"
                    value="{$exist:prefix}"/>
            </forward>
            <view>
                <forward
                    servlet="XSLTServlet">
                    <set-attribute
                        name="xslt.stylesheet"
                        value="{concat($exist:root, $exist:controller, "/xsl/departments.xsl")}"/>
                </forward>
            </view>
        </dispatch>

else
    if ($exist:resource eq 'form') then
            <dispatch
            xmlns="http://exist.sourceforge.net/NS/exist">
            <forward
                url="{$exist:controller}/xquery/form.xq">
                <set-attribute
                    name="collection_path"
                    value="{$collection_path}"/>
                <set-attribute
                    name="exist.root"
                    value="{$exist:root}"/>
                <set-attribute
                    name="exist.path"
                    value="{$exist:path}"/>
                <set-attribute
                    name="exist.resource"
                    value="{$exist:resource}"/>
                <set-attribute
                    name="exist.controller"
                    value="{$exist:controller}"/>
                <set-attribute
                    name="exist.prefix"
                    value="{$exist:prefix}"/>
            </forward>
            <view>
                <forward
                    servlet="XSLTServlet">
                    <set-attribute
                        name="xslt.stylesheet"
                        value="{concat($exist:root, $exist:controller, "/xsl/form.xsl")}"/>
                </forward>
            </view>
        </dispatch>

else
    if ($exist:resource eq 'staff') then
            <dispatch
            xmlns="http://exist.sourceforge.net/NS/exist">
            <forward
                url="{$exist:controller}/xquery/staff.xq">
                <set-attribute
                    name="collection_path"
                    value="{$collection_path}"/>
                <set-attribute
                    name="exist.root"
                    value="{$exist:root}"/>
                <set-attribute
                    name="exist.path"
                    value="{$exist:path}"/>
                <set-attribute
                    name="exist.resource"
                    value="{$exist:resource}"/>
                <set-attribute
                    name="exist.controller"
                    value="{$exist:controller}"/>
                <set-attribute
                    name="exist.prefix"
                    value="{$exist:prefix}"/>
            </forward>
            <view>
                <forward
                    servlet="XSLTServlet">
                    <set-attribute
                        name="xslt.stylesheet"
                        value="{concat($exist:root, $exist:controller, "/xsl/staff.xsl")}"/>
                </forward>
            </view>
        </dispatch>


else
    if ($exist:resource eq 'main_page') then
            <dispatch
            xmlns="http://exist.sourceforge.net/NS/exist">
            <forward
                url="{$exist:controller}/xquery/main_page.xq">
                <set-attribute
                    name="collection_path"
                    value="{$collection_path}"/>
                <set-attribute
                    name="exist.root"
                    value="{$exist:root}"/>
                <set-attribute
                    name="exist.path"
                    value="{$exist:path}"/>
                <set-attribute
                    name="exist.resource"
                    value="{$exist:resource}"/>
                <set-attribute
                    name="exist.controller"
                    value="{$exist:controller}"/>
                <set-attribute
                    name="exist.prefix"
                    value="{$exist:prefix}"/>
            </forward>
            <view>
                <forward
                    servlet="XSLTServlet">
                    <set-attribute
                        name="xslt.stylesheet"
                        value="{concat($exist:root, $exist:controller, "/xsl/main_page.xsl")}"/>
                </forward>
            </view>
        </dispatch>

        (: test page :)
else
    if (matches($exist:resource, 'all_courses.pdf')) then
        <dispatch
            xmlns="http://exist.sourceforge.net/NS/exist">
            <forward
                url="{$exist:controller}/xquery/main_page-pdf.xq">
                <set-attribute
                    name="exist.resource"
                    value="{$exist:resource}"/>
            </forward>
        </dispatch>

else
    if ($exist:resource eq 'course_groups') then
            <dispatch
            xmlns="http://exist.sourceforge.net/NS/exist">
            <forward
                url="{$exist:controller}/xquery/course_groups.xq">
                <set-attribute
                    name="collection_path"
                    value="{$collection_path}"/>
                <set-attribute
                    name="exist.root"
                    value="{$exist:root}"/>
                <set-attribute
                    name="exist.path"
                    value="{$exist:path}"/>
                <set-attribute
                    name="exist.resource"
                    value="{$exist:resource}"/>
                <set-attribute
                    name="exist.controller"
                    value="{$exist:controller}"/>
                <set-attribute
                    name="exist.prefix"
                    value="{$exist:prefix}"/>
            </forward>
            <view>
                <forward
                    servlet="XSLTServlet">
                    <set-attribute
                        name="xslt.stylesheet"
                        value="{concat($exist:root, $exist:controller, "/xsl/course_groups.xsl")}"/>
                </forward>
            </view>
        </dispatch>      

else
    if ($exist:resource eq 'course_groups-pdf') then
            <dispatch
                xmlns="http://exist.sourceforge.net/NS/exist">
                <forward
                    url="{$exist:controller}/xquery/course_groups-pdf.xq">
                    <set-attribute
                        name="exist.resource"
                        value="{$exist:resource}"/>
                </forward>
            </dispatch>

else
    if ($exist:resource eq 'course_details') then
            <dispatch
            xmlns="http://exist.sourceforge.net/NS/exist">
            <forward
                url="{$exist:controller}/xquery/course_details.xq">
                <set-attribute
                    name="collection_path"
                    value="{$collection_path}"/>
                <set-attribute
                    name="exist.root"
                    value="{$exist:root}"/>
                <set-attribute
                    name="exist.path"
                    value="{$exist:path}"/>
                <set-attribute
                    name="exist.resource"
                    value="{$exist:resource}"/>
                <set-attribute
                    name="exist.controller"
                    value="{$exist:controller}"/>
                <set-attribute
                    name="exist.prefix"
                    value="{$exist:prefix}"/>
            </forward>
            <view>
                <forward
                    servlet="XSLTServlet">
                    <set-attribute
                        name="xslt.stylesheet"
                        value="{concat($exist:root, $exist:controller, "/xsl/course_details.xsl")}"/>
                </forward>
            </view>
        </dispatch> 

else
 if ($exist:resource eq 'course_details-pdf') then
            <dispatch
                xmlns="http://exist.sourceforge.net/NS/exist">
                <forward
                    url="{$exist:controller}/xquery/course_details-pdf.xq">
                    <set-attribute
                        name="exist.resource"
                        value="{$exist:resource}"/>
                </forward>
            </dispatch>
            
(: everything is passed through :)
else
    <dispatch
        xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control
            cache="yes"/>
    </dispatch>
