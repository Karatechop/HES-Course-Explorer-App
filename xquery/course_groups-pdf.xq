xquery version "1.0" encoding "UTF-8";

import module namespace xslfo="http://exist-db.org/xquery/xslfo";

declare function local:minValueOfOne($value as xs:integer) 
{
    if ($value <= 0) then 1 else $value
};


declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);

declare variable $queryString   := request:get-query-string();
declare variable $departmentPar :=  request:get-parameter("department","");
declare variable $groupPar      :=  request:get-parameter("group","");
declare variable $termPar       :=  request:get-parameter("term","");
declare variable $yearPar       :=  request:get-parameter("year","");
declare variable $daysOfWeekPar :=  request:get-parameter("daysOfWeek","");
declare variable $timePar       :=  request:get-parameter("time","");
declare variable $staffPar      :=  request:get-parameter("staff","");
declare variable $searchPar     :=  request:get-parameter("search","");
declare variable $start := request:get-parameter("start", "1");


declare variable $records := 25;

let $courseData :=
        
            let $departmentQuery := 
                if ($departmentPar) then 
                    concat('[catalog_info/department[@code', " = '", $departmentPar, "']]") else ()
            let $groupQuery := 
                if ($groupPar) then 
                    concat('[catalog_info/course_group[@code', " = '", $groupPar, "']]") else ()
            let $yearQuery := 
                if ($yearPar) then 
                    concat('[@academic_year', " = '", $yearPar, "']") else ()                       
            let $termQuery := 
                if ($termPar) then 
                    concat('[@term_code', " = '", $termPar, "']") else () 
            let $daysOfWeekQuery := 
                if ($daysOfWeekPar) then 
                    concat('[contains(catalog_info/meeting_schedule/meeting/lower-case(@days_of_week)',",",'lower-case(','"',$daysOfWeekPar,'"', "))]") else ()                    
            let $timeQuery := 
		if ($timePar) then 
		     concat('[catalog_info/meeting_schedule/meeting[@start_time', " = '", $timePar, ":00']]") else ()
            let $staffQuery := 
                if ($staffPar) then 
                    concat('[contains(staff/person/display_name/lower-case(text())',",",'lower-case(','"',$staffPar,'"', "))]") else () 
            let $searchQueryTitle := 
                if ($searchPar) then 
                    concat('[contains(catalog_info/title/lower-case(text())',",",'lower-case(','"',$searchPar,'"', "))"," or ",
                           'contains(catalog_info/description/lower-case(text())',",",'lower-case(','"',$searchPar,'"', "))]" ) else () 
            let $searchQueryDescription := 
                if ($searchPar) then 
                    concat('[contains(catalog_info/description/lower-case(text())',",",'lower-case(','"',$searchPar,'"', "))]") else () 
            
            let $query := concat
                ("collection('/db/apps/cscie18-xteam-finalproject/data')",
                    "/courses/course", 
                    $departmentQuery,
                    $groupQuery,
                    $yearQuery,
                    $termQuery,
                    $daysOfWeekQuery,
                    $timeQuery,
                    $staffQuery,
                    $searchQueryTitle)



            let $pages := ceiling(count($col/courses/course/catalog_info/department[@code = $departmentPar]) div $records)
            let $coursePages := local:minValueOfOne($pages)
            let $page := $pages - ($pages - xs:integer($start))
            let $firstRecord := ((xs:integer($start) * $records) - $records) + 1
            let $lastRecord  := (xs:integer($start) * $records)
                    
        let $queryResults := util:eval($query)
        
        return
        (
            <departments start="{$start}" pages="{$coursePages}" page="{$page}" 
                departmentQuery="{$departmentPar}"
                groupQuery="{$groupPar}"
                termQuery="{$termPar}"
                yearQuery="{$yearPar}"
                daysOfWeekQuery="{$daysOfWeekPar}"
                timeQuery="{$timePar}"
                staffQuery="{$staffPar}"
                searchQuery="{$searchPar}">
            {
                for $course in $queryResults
                let $department := $course/catalog_info/department
                let $departmentCode := $department/@code
                let $group      := $course/catalog_info/course_group
                let $groupCode    := $group/@code
        
                let $distinct_department := distinct-values($department/text())
                let $distinct_departmentCode := distinct-values($departmentCode)
                let $distinct_group := distinct-values($group/text())
        
                group by $distinct_department
                order by $distinct_department
    
                return  <department code="{$distinct_departmentCode}" name="{$distinct_department}"> 
                        {
                            for $gc in $group
                           
                            let $distinct_groupCode :=  distinct-values($gc/@code)
                            let $groupName := distinct-values($gc/text())
                             
                            group by $distinct_groupCode, $groupName
                            order by $groupName
                            
                            return 
                                    <course_group code="{$distinct_groupCode}" name="{$groupName}">
                                        {
                                            let $foo := $queryResults[catalog_info/department[@code = $distinct_departmentCode]]
                                            for $c in $foo
                                            where 
                                                $c/catalog_info/course_group/@code = $distinct_groupCode
                                                
                                            return 
                                                <course_title 
                                                    short_title="{$c/catalog_info/title/@short_title}"
                                                    course_id="{$c/@course_id}"
                                                    class_number="{$c/@class_number}"
                                                    term_code="{$c/@term_code}"
                                                    section="{$c/@section}"
                                                            days_of_week="{$c/catalog_info/meeting_schedule/meeting/@days_of_week}"
                                                            start_time="{$c/catalog_info/meeting_schedule/meeting/@start_time}"
                                                            end_time="{$c/catalog_info/meeting_schedule/meeting/@end_time}"
                                                    >
                                                        <title>{$c/catalog_info/title/text()}{
                                                        for $meeting in $c/catalog_info/meeting_schedule/meeting
                                                        let $courseStartTime    := $meeting/@start_time
                                                        let $courseEndTime      := $meeting/@end_time
                                                        let $coursedays_of_week := $meeting/@days_of_week
                                                        
                                                        return                                               
                                                            <meeting 
                                                                term_code   ="{$c/@term_code}" 
                                                                days_of_week="{$c/catalog_info/meeting_schedule/meeting/@days_of_week}" 
                                                                start_time  ="{$c/catalog_info/meeting_schedule/meeting/@start_time}" 
                                                                end_time    ="{$c/catalog_info/meeting_schedule/meeting/@end_time}" 
                                                                course_id   ="{$c/@course_id}"
                                                                class_number="{$c/@class_number}"/>}
                                                                </title>
                                                </course_title> 
                                        }
                                    </course_group>
                        }
                        </department>
            }
            </departments>
        )


let $xslt-document as document-node() := doc('../xsl/course_groups-fo.xsl')
let $xslfo-document as document-node() := transform:transform($courseData,$xslt-document,())

let $media-type as xs:string := "application/pdf"
return
    response:stream-binary(
        xslfo:render($xslfo-document, $media-type, ()),
        $media-type,
        "course_groups.pdf"
    )