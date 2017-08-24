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

    if ( $global:LenovoRawData ) {
        $global:LenovoRawData | Write-Output
        exit
    }

    $localFile = join-path $env:temp (split-path $URI -leaf)
    $RawDataFile = $localFile
    $IWRSettings = get-IWRSettings

    # remove if older than 1 day
    if ( test-path $localFile ) {
        if ( (get-item $LocalFile).LastWriteTime -lt (get-date).AddDays(-1) ) {
            write-verbose "Clean and download from scratch"
            remove-item $localFile,$RawDataFile -ErrorAction SilentlyContinue | out-null
        }
    }

    if ( ! (test-path $LocalFile) ) {
        write-verbose "download File $URI"
        Invoke-WebRequest -UseBasicParsing -URI $URI @IWRSettings -OutFile $localFile
    }

    $global:LenovoRawData = ( get-content -Raw -Path $RawDataFile ) -as [xml]
    $global:LenovoRawData | Write-Output
}

