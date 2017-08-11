xquery version "1.0" encoding "UTF-8";

import module namespace xslfo="http://exist-db.org/xquery/xslfo";
import module namespace xteam2='http://cscie18.dce.harvard.edu/xteam/finalproject2' at 'courses_by_dept.xqm';

declare variable $department_par     :=  request:get-parameter("department","CHEM");

let $source-document := xteam2:all_courseList($department_par)

let $resource := replace(request:get-attribute('exist.resource'),'\.pdf','')
let $xslt-document as document-node() := doc('../xsl/main_page-fo.xsl')
let $xslfo-document as document-node() := transform:transform($source-document,$xslt-document,())

let $media-type as xs:string := "application/pdf"
return
    response:stream-binary(
        xslfo:render($xslfo-document, $media-type, ()),
        $media-type,
        "courses.pdf"
    )

