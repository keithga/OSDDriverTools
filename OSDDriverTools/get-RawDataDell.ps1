function get-RawDataDell {
    <#
    .SYNOPSIS
    Wrapper to get raw OEM data from Dell

    .DESCRIPTION
    Get the raw data from Dell. Not normalized.

    #>
    [CmdletBinding()]
    param(
        $URI = "https://downloads.dell.com/catalog/DriverPackCatalog.cab"
    )

    if ( !$script:DellRawData ) {
        $script:DellRawData = get-rawXMLDataWithCache -URI $URI
    }
    $script:DellRawData | Write-Output

}

