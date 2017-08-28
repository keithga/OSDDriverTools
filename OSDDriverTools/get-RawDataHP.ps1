function get-RawDataHP {
    <#
    .SYNOPSIS
    Wrapper to get raw OEM data from HP

    .DESCRIPTION
    Get the raw data from HP. Not normalized.

    #>
    [CmdletBinding()]
    param(
        $URI = "https://ftp.hp.com/pub/caps-softpaq/cmit/HPClientDriverPackCatalog.cab"
    )

    if ( !$script:HPRawData ) {
        $script:HPRawData = get-rawXMLDataWithCache -URI $URI
    }
    $script:HPRawData | Write-Output

}

