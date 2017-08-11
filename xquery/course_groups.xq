xquery version "3.0" encoding "UTF-8";

declare function local:minValueOfOne($value as xs:integer) 
{
    if ($value <= 0) then 1 else $value
};

(: Load global variables :)
declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);

(: Read parameters from URL or form on previous page :)
declare variable $post-data     := request:get-data();
declare variable $queryString   :=  request:get-query-string();
declare variable $departmentPar :=  request:get-parameter("department","");
declare variable $groupPar      :=  request:get-parameter("group","");
declare variable $termPar       :=  request:get-parameter("term","");
declare variable $yearPar       :=  request:get-parameter("year","");
declare variable $daysOfWeekPar :=  request:get-parameter("daysOfWeek","");
declare variable $timePar       :=  request:get-parameter("time","");
declare variable $staffPar      :=  request:get-parameter("staff","");
declare variable $staffIdPar    :=  request:get-parameter("staffId","");
declare variable $searchPar     :=  request:get-parameter("search","");
declare variable $start         :=  request:get-parameter("start", "1");

(: How many records are to be returned per page? :)
declare variable $records := 25;

(: Build Queries for each parameter. :)
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
let $daysOfWeekStr := if (contains(string-join($daysOfWeekPar,''),'Any')) then '' else string-join($daysOfWeekPar,' ')
let $daysOfWeekQuery := 
    if ($daysOfWeekStr != '') then 
        concat('[contains(catalog_info/meeting_schedule/meeting/lower-case(@days_of_week)',",",'lower-case(','"',$daysOfWeekStr,'"', "))]") else ()   
let $timeParColon := replace($timePar, '%3A', ':') 
let $timeParTime  := concat($timeParColon,':00')
let $timeQuery := 
    if ($timePar) then 
        concat('[catalog_info/meeting_schedule/meeting[@start_time', " = '", $timePar, ":00']]")
        else ()
let $staffQuery := 
    if ($staffPar) then 
        concat('[contains(staff/person/display_name/lower-case(text())',",",'lower-case(','"',$staffPar,'"', "))]") else ()                     
let $staffIdQuery := 
    if ($staffIdPar) then 
        concat('[staff/person[@id', " = '", $staffIdPar, "']]") else ()
let $searchQueryTitle := 
    if ($searchPar) then 
        concat('[contains(catalog_info/title/lower-case(text())',",",'lower-case(','"',$searchPar,'"', "))"," or ",
               'contains(catalog_info/description/lower-case(text())',",",'lower-case(','"',$searchPar,'"', "))]" ) else () 
let $searchQueryDescription := 
    if ($searchPar) then 
        concat('[contains(catalog_info/description/lower-case(text())',",",'lower-case(','"',$searchPar,'"', "))]") else () 

(: Build Composite Query String :)  
(: note the collection does not use the global variable because the query would sometimes fail with it. :)          
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
        $staffIdQuery,
        $searchQueryTitle)

(: Execute Query :)
let $queryResults := util:eval($query)

(: Calculate pagination parameters, Requires the input parameter of the starting page. :)
let $pages := ceiling(count($queryResults) div $records)
let $coursePages := local:minValueOfOne($pages)
let $page := $pages - ($pages - xs:integer($start))
let $firstRecord := ((xs:integer($start) * $records) - $records) + 1
let $lastRecord  := (xs:integer($start) * $records)
                    
(: Sort the query results by department, course group and course title. Limit results to 1 page :)        
let $sortedResults :=
    (
        for $queryCourse in $queryResults
        let $departmentName     := $queryCourse/catalog_info/department/text()
        let $courseGroupName    := $queryCourse/catalog_info/course_group/text()
        let $courseTitle        := $queryCourse/catalog_info/title
        group by $departmentName, $courseGroupName, $courseTitle
        order by $departmentName, $courseGroupName, $courseTitle
        return $queryCourse
    )[position() = $firstRecord to $lastRecord]

(: Get the name of the staff member since only the ID may have been a parameter. :)        
let $staffIdName := 
    if($staffIdPar) then
        distinct-values($queryResults/staff/person[@id = $staffIdPar]/display_name/text())
    else()

(: Ouput some XML - starting with departments node. :)        
return
(
<departments 
    totalResults    ="{count($queryResults)}" 
    count           ="{count($sortedResults)}" start="{$start}" 
    pages           ="{$coursePages}" page="{$page}" 
    departmentQuery ="{$departmentPar}"
    groupQuery      ="{$groupPar}"
    termQuery       ="{$termPar}"
    yearQuery       ="{$yearPar}"
    daysOfWeekQuery ="{$daysOfWeekPar}"
    timeQuery       ="{$timePar}"
    staffQuery      ="{$staffPar}"
    staffIdQuery    ="{$staffIdPar}"
    staffIdName     ="{$staffIdName}"
    searchQuery     ="{$searchPar}">
    {
        for $course in $sortedResults
        let $department     := $course/catalog_info/department
        let $departmentCode := $department/@code
        let $group          := $course/catalog_info/course_group
        let $groupCode      := $group/@code

        let $distinct_department        := distinct-values($department/text())
        let $distinct_departmentCode    := distinct-values($departmentCode)
        let $distinct_group             := distinct-values($group/text())
        
        group by $distinct_department
        order by $distinct_department
        
        (: Ouput department collection :)
        return  <department 
                    code="{$distinct_departmentCode}" 
                    name="{$distinct_department}"> 
            {
            for $gc in $group
           
            let $distinct_groupCode :=  distinct-values($gc/@code)
            let $groupName := distinct-values($gc/text())
            
            group by $distinct_groupCode, $groupName
            order by $groupName
                            
            (: Get the course information :)
            return 
                (
                (: Course collection is variablized at this point and inserted under the course group or department if the course group is not titled or has the same name as the departmet. :)
                let $courseList := 
                    (
                    let $groupedCourses := 
                        $sortedResults[catalog_info/department[@code = $distinct_departmentCode]]
                    for $groupedCourse in $groupedCourses
                    let $groupedCourseTitle         := $groupedCourse/catalog_info/title/text()
                    let $groupedCourseCode          := $groupedCourse/catalog_info/course_group/@code
                    let $groupedCourseShortTitle    := $groupedCourse/catalog_info/title/@short_title
                    let $groupedCourseId            := $groupedCourse/@course_id
                    let $groupedCourseClass         := $groupedCourse/@class_number
                    let $groupedCourseTermCode      := $groupedCourse/@term_code
                    let $groupedCourse_days_of_week := $groupedCourse/catalog_info/meeting_schedule/meeting/@days_of_week
                    let $groupedCourse_start_time   := $groupedCourse/catalog_info/meeting_schedule/meeting/@start_time                                            
                    
                    where $groupedCourseCode = $distinct_groupCode
                    order by $groupedCourseTitle
                    (: Output individual courses data. :)
                    return 
                        <course_title 
                            short_title ="{$groupedCourseShortTitle}"
                            course_id   ="{$groupedCourseId}"
                            class_number="{$groupedCourseClass}"
                            term_code   ="{$groupedCourseTermCode}"
                            days_of_week="{$groupedCourse_days_of_week}"
                            start_time  ="{$groupedCourse_start_time}">
                            
                            <title>{$groupedCourseTitle}</title>
                            {
                            for $meeting in $groupedCourse/catalog_info/meeting_schedule/meeting
                            let $courseStartTime    := $meeting/@start_time
                            let $courseEndTime      := $meeting/@end_time
                            let $coursedays_of_week := $meeting/@days_of_week
                            return                                               
                                <meeting 
                                    term_code   ="{$groupedCourseTermCode}" 
                                    days_of_week="{$coursedays_of_week}" 
                                    start_time  ="{$courseStartTime}" 
                                    end_time    ="{$courseEndTime}" 
                                    course_id   ="{$groupedCourseId}"
                                    class_number="{$groupedCourseClass}"/>
                            }    
                        </course_title> 
                    )
                (: Returns the course group with a collection of courses unless the group name is empty or the same as the department :)
                return 
                    if (empty($groupName) or $groupName eq $distinct_department) then
                        (
                            $courseList
                        )    
                    else
                        (
                            <course_group code="{$distinct_groupCode}" name="{$groupName}">
                                {
                                    $courseList
                                }
                            </course_group>
                        )
                )
        }
        </department>
    }
    </departments>
)

