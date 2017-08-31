
import-module -force C:\Users\Keith\source\repos\OSDDriverTools\OSDDriverTools -verbose 

get-CachePath | remove-item -force -recurse
get-cachepath | get-childitem -recurse

get-modelinfodell
get-modelinfohp
get-modelinfolenovo

