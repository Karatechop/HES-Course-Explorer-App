xquery version "3.0" encoding "UTF-8";

import module namespace xteam='http://cscie18.dce.harvard.edu/xteam/finalproject' at 'autocomplete_list.xqm';

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);

<results>
    {xteam:autocomplete_departmentList()}
    {xteam:autocomplete_staffList()}
    <departments></departments>
</results>         
  
    

    
   


