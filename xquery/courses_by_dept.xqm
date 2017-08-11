xquery version "3.0" encoding "UTF-8";

module namespace xteam2 = "http://cscie18.dce.harvard.edu/xteam/finalproject2";

declare function xteam2:all_courseList($department as xs:string) as node() {
 
 let  $col_path := request:get-attribute('collection_path')
 let  $col := collection(concat($col_path,'/?select=*.xml'))
 
 
 
return
  <courses department="{$department}"  >
        {  
        for $course in $col/courses/course[catalog_info/department/@code eq $department]
        let $staffList :=$course/staff/person
        return  <course 
                year="{$course/@academic_year}" 
                term="{$course/@term_code}" 
                class_number="{$course/@class_number}"
                catalog_info_title="{$course/catalog_info/title/text()}"
                title="{$course/catalog_info/title/text()}"
                department="{$course/catalog_info/department/text()}"
                credits="{$course/catalog_info/credits/text()}"
                staff1="{$course/staff/person/display_name/text()}"
                meeting="{$course/catalog_info/meeting_schedule/meeting/@days_of_week }"
                start="{$course/catalog_info/meeting_schedule/meeting/@start_time }" 
                end="{$course/catalog_info/meeting_schedule/meeting/@end_time }"
                >
                <description>{$course/catalog_info/description/text()}</description>
                <notes>{$course/catalog_info/notes/text()}</notes>
                <staff>
               {for $person in $staffList
                 order by $person/@role,$person/@seniority_sort
                return <person role="{$person/@role}" 
                       seniority_sort="{$person/@seniority_sort}" 
                       name="{$person/display_name/text()}"/>
               } </staff> 
           </course>
    }
    </courses>
} ;
