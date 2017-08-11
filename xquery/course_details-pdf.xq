xquery version "3.0";

import module namespace xslfo="http://exist-db.org/xquery/xslfo";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection('/db/apps/cscie18-xteam-finalproject/data');

declare variable $queryString       := request:get-query-string();
declare variable $course_id_par     :=  request:get-parameter("course_id","108680");
declare variable $class_number_par  :=  request:get-parameter("class_number","11071");

(: 
for $course in $col/courses/course
where $course[@course_id = "107332"]
 :)
 
let $courses := $col/courses/course[@course_id = $course_id_par]
let $class := $courses[@class_number = $class_number_par]
    
let $courseData := <courses>{$class}</courses>

let $xslt-document as document-node() := doc('../xsl/course_details-fo.xsl')
let $xslfo-document as document-node() := transform:transform($courseData,$xslt-document,())

let $media-type as xs:string := "application/pdf"
return
    response:stream-binary(
        xslfo:render($xslfo-document, $media-type, ()),
        $media-type,
        "course_details.pdf"
    )