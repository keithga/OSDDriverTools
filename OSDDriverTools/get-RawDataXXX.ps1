function get-RawDataXXX {
    <#
    .SYNOPSIS
    Wrapper to get raw OEM data from XXX

    .DESCRIPTION
    Get the raw data from XXX. Not normalized.

    #>
    [CmdletBinding()]
    param(
        $URI = "XXX"
    )

    if ( $global:XXXRawData ) {
        $global:XXXRawData | Write-Output
        exit
    }

    $localFile = join-path $temp (split-path $URL -leaf)
    $IWRSettings = get-IWRSettings

    # remove if older than 1 day
    if ( test-path $localFile ) {
        if ( (get-item $LocalFile).LastWriteTime -lt (get-date).AddDays(-1) ) {
            remove-item $localFile
        }
    }

    if ( ! (test-path $LocalFile) ) {
        Invoke-WebRequest -UseBasicParsing @PSBoundParameters @IWRSettings -OutFile $localFile
    }

    $RawDataFile = $localFile

    $global:XXXRawData = ( get-content -Raw -Path $RawDataFile ) -as [xml]
    $global:XXXRawData | Write-Output
}

