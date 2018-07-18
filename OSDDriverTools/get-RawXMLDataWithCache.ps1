function get-RawXMLDataWithCache {
    <#
    .SYNOPSIS
    Wrapper to get raw XMLData

    .DESCRIPTION
    Will cache the data locally, will re-download if cache is older than 24hrs

    #>
    [CmdletBinding()]
    param(
        $URI,
        $ForceFileExtract
    )

    $IWRSettings = get-IWRSettings
    $localFile = join-path (get-CachePath) (split-path $URI -leaf)

    # remove if older than 1 day
    if ( test-path $localFile ) {
        if ( (get-item $LocalFile).LastWriteTime -lt (get-date).AddDays(-1) ) {
            write-verbose "Remove $LocalFile and download again."
            remove-item $localFile -ErrorAction SilentlyContinue | out-null
        }
    }

    # Download
    if ( ! (test-path $LocalFile) ) {
        write-verbose "download File $URI"
        try {
            Invoke-WebRequest -UseBasicParsing -URI $URI @IWRSettings -OutFile $localFile
        }
        catch {
            Write-Warning "Broken HP Servers... Try Http instead..."
            Invoke-WebRequest -UseBasicParsing -URI $URI.replace('https://','http://') @IWRSettings -OutFile $localFile
        }
    }

    if ( -not ( test-path $localFile ) ) { throw "missing $LocalFile" }


    # Expand if necessary
    if ( $LocalFile.trim().EndsWith(".xml") ) {
        $RawDataFile = $localFile
    }
    elseif ( $ForceFileExtract ) { 
        $RawDataFile = join-path (get-CachePath) $ForceFileExtract
        expand $localFile -F:$ForceFileExtract (get-CachePath)
    }
    elseif ( $LocalFile.trim().EndsWith(".cab") ) {
        $RawDataFile = "$($LocalFile).xml"

        write-verbose "Expand $LocalFile to $RawDataFile"
        expand.exe $LocalFile $RawDataFile | out-string -Width 200 | write-verbose
    }
    else {
        throw "Unknown data type $LocalFile"
    }

    # Return content (fix for Lenovo)
    ( get-content -Raw -Path $RawDataFile ) -as [xml]  | Write-Output
}