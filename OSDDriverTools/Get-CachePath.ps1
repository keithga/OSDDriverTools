function get-CachePath {
    <#
    .SYNOPSIS
    Where to place local files.

    .DESCRIPTION
    Hook used in environments local files should be cached elsewhere.
    set the global variable $OSDDriverToolsTemp to where you want the files located.
        
    #>
    [CmdletBinding()]
    param()

    if ( $OSDDriverToolsTemp ) {
        $result = $OSDDriverToolsTemp 
    }
    else {
        $result = "$env:temp\OSDDriverTools"
    }

    if ( -not ( test-path $result ) ) { 
        new-item -ItemType Directory -path $result -ErrorAction SilentlyContinue | out-null
    }

    $result | write-output

}

