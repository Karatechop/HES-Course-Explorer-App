xquery version "3.0" encoding "UTF-8";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);


<results>

    <departments>
        {
        for $course in $col/courses/course
        let $department := $course/catalog_info/department
        
        
        let $distinct_department := distinct-values($department/text())
        
        
        group by $distinct_department
        order by $distinct_department

        return  <department name="{$distinct_department}"> 
                    {
                <staff>
                    
                    {
                        
                    for $staff
                            in distinct-values($course/staff/person/@id)
                            let $staffnode := $course/staff/person[@id = $staff]
                            order by $staffnode[1]/display_name
                           
                            return
    
                            $staffnode[1]
                    
                        
                    }

                </staff>
                    }
                </department>
        }
    </departments>

</results>         
  
    

    
   


