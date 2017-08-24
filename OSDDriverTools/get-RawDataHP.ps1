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

    if ( $global:HPRawData ) {
        $global:HPRawData | Write-Output
        exit
    }

    $localFile = join-path $env:temp (split-path $URI -leaf)
    $RawDataFile = "$($LocalFile).xml"
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

    write-verbose "Expand $LocalFile to $RawDataFile"
    expand.exe $LocalFile $RawDataFile | out-string -Width 200 | write-verbose

    $global:HPRawData = ( get-content -Raw -Path $RawDataFile ) -as [xml]
    $global:HPRawData | Write-Output
}

