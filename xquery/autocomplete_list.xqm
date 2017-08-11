xquery version "3.0" encoding "UTF-8";

module namespace xteam = "http://cscie18.dce.harvard.edu/xteam/finalproject";

declare function xteam:autocomplete_departmentList() as node() {
 
 let  $col_path := request:get-attribute('collection_path')
 let  $col := collection(concat($col_path,'/?select=*.xml'))

return
  <autoComplete_departmentList>
        {
        for $course in $col/courses/course
        let $department := $course/catalog_info/department
        let $departmentCode := $department/@code

        let $distinct_department := distinct-values($department/text())
        let $distinct_departmentCode := distinct-values($departmentCode)
        
        group by $distinct_department
        order by $distinct_department

        return  <department value="{$distinct_departmentCode}" label="{$distinct_department}"/> 
    }
    </autoComplete_departmentList>
} ;

declare function xteam:autocomplete_staffList() as node() {
 
 let  $col_path := request:get-attribute('collection_path')
 let  $col := collection(concat($col_path,'/?select=*.xml'))
 
return
    <autoComplete_staffList>
        {
            for $staff in  $col/courses/course/staff/person/display_name
            let $staffName := distinct-values($staff/text())
            group by $staffName
            order by $staffName
            return    <staff value="{$staffName}" label="{$staffName}" />
        }
    </autoComplete_staffList>
} ;