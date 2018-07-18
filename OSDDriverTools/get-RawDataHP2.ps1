function get-RawDataHP2 {
    <#
    .SYNOPSIS
    Wrapper to get raw OEM data from HP

    .DESCRIPTION
    Get the raw data from HP. Not normalized.

    #>
    [CmdletBinding()]
    param(
        $URI = "http://ftp.hp.com/pub/softlib/software/sms_catalog/HpCatalogForSms.latest.cab"
    )

    if ( !$script:HPRawData2 ) {
        $script:HPRawData2 = get-rawXMLDataWithCache -URI $URI -ForceFileExtract 'HpCatalogForSms.xml'
    }
    $script:HPRawData2 | Write-Output

}

