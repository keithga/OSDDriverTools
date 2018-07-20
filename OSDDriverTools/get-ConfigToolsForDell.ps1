function Get-ConfigToolsForDell.ps1 {
    [cmdletbinding()]
    param( 
        $URI = 'https://downloads.dell.com/FOLDER04978295M/1/Dell-Command-Configure_2KRXV_WIN_4.1.0.478_A00.EXE'
    )

    $IWRSettings = get-IWRSettings
    $localFile = join-path (get-CachePath) (split-path $URI -leaf)

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


    
    # No-Op - use native calls?

}