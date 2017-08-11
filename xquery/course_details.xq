xquery version "3.0";

declare variable $col := collection('/db/apps/cscie18-xteam-finalproject/data');

declare variable $course_id_par     :=  request:get-parameter("course_id","");
declare variable $class_number_par  :=  request:get-parameter("class_number","");

let $courses := $col/courses/course[@course_id = $course_id_par]
let $class := $courses[@class_number = $class_number_par]

return <courses>{$class}</courses>