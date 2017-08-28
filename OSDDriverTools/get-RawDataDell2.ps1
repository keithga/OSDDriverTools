function get-RawDataDell2 {
    <#
    .SYNOPSIS
    Wrapper to get raw OEM data from Dell

    .DESCRIPTION
    Get the raw data from Dell. Not normalized.

    #>
    [CmdletBinding()]
    param(
        $URI = "http://downloads.dell.com/catalog/CatalogPC.cab"
    )

    if ( !$script:DellRawData2 ) {
        $script:DellRawData2 = get-rawXMLDataWithCache -URI $URI
    }
    $script:DellRawData2 | Write-Output

}

