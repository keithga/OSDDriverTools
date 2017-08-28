function get-RawDataLenovo {
    <#
    .SYNOPSIS
    Wrapper to get raw OEM data from Lenovo

    .DESCRIPTION
    Get the raw data from Lenovo. Not normalized.

    #>
    [CmdletBinding()]
    param(
        $URI = "https://download.lenovo.com/cdrt/td/catalog.xml"
    )

    if ( !$script:LenovoRawData ) {
        $script:LenovoRawData = get-rawXMLDataWithCache -URI $URI
    }
    $script:LenovoRawData | Write-Output
}

