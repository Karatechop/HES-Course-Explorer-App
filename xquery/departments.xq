xquery version "3.0" encoding "UTF-8";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);


<results>
  
    <departments>
        {
        for $course in $col/courses/course
        let $department := $course/catalog_info/department
        let $departmentCode := $department/@code
        let $group      := $course/catalog_info/course_group
        

        let $distinct_department := distinct-values($department/text())
        let $distinct_departmentCode := distinct-values($departmentCode)
        

        
        group by $distinct_department
        order by $distinct_department

        return  <department code="{$distinct_departmentCode}" name="{$distinct_department}"> 
                    {
                        for $gc in $group
                       
                        let $distinct_groupCode :=  distinct-values($gc/@code)
                        let $groupName := distinct-values($gc/text())
                         
                            group by $distinct_groupCode, $groupName
                            order by $groupName
                        return if(
                            $groupName != $distinct_department)
                            then (<group code="{$distinct_groupCode}">{$groupName}</group>)
                            else ()
                    }
                        
                </department>
        }
    </departments>
</results>         
  
    

    
   


