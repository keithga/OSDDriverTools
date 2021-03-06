<#
.Synopsis
   Short description
.DESCRIPTION
   
   Downloads server compoents. 
   UI is out-gridview, deal with it. use the search feature :^)

.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>

[cmdletbinding()]
param(
    $Database = 'C:\DeploymentShare\Applications\Update BIOS Firmware',
    $Platforms = @('Dell','HP')
)

Start-Transcript

import-module $PsscriptRoot\..\OSDDriverTools -force

if ( -not ( test-path $Database ) ) { 
    throw "Missing Database path $Database"
}

$DisplayList = "PackageID,Name,Date,Version,Machines,MachinesFriendly,URL,HASH" -split ','

#region Dell

if ( 'Dell' -in $Platforms ) { 

    new-item -ItemType Directory -Path $Database\Dell -Force -ErrorAction SilentlyContinue | Out-Null

    $DellPackages = get-BIOSPkgsForDell 
    $DellPackages | Export-Clixml -Path $Database\Dell.clixml

    $DellDownloads = $DellPackages | Select -property $DisplayList |  Out-GridView -OutputMode Multiple -Title "Select Systems (multiple)"

    $DellDownloads | % { Start-BitsTransfer -Source $_.URL -Destination $Database\Dell }

    Foreach ( $DellDOwnload in $DellDownloads ) {
        $localFIle = (join-path $Database\Dell ( split-path -leaf $DellDOwnload.URL ) ) 
        write-verbose "verify $LocalFile for $($DellDOwnload.Name)"
        if ( -not ( Test-path $localFIle) ) { throw "MIssing $LocalFile" }
        if ( get-filehash -Algorithm MD5 $LocalFile | ? Hash -ne $DellDOwnload.hash ) { throw "Bad Hash on $LocalFIle" } 

    }   

}

#endregion 

#region HP

if ( 'HP' -in $Platforms ) { 

    new-item -ItemType Directory -Path $Database\HP -Force -ErrorAction SilentlyContinue | Out-Null

    $HPPackages = get-BIOSPkgsForHP 
    $HPPackages | Export-Clixml -Path $Database\HP.clixml

    $HPDownloads = $HPPackages | Select -property $DisplayList | Out-GridView -OutputMode Multiple -Title "Select Systems (multiple)"

    $HPDownloads | % { Start-BitsTransfer -Source $_.URL -Destination $Database\HP }

    Foreach ( $HPDownload in $HPDownloads ) {
        $localFIle = (join-path $Database\HP ( split-path -leaf $HPDOwnload.URL ) ) 
        write-verbose "verify $LocalFile for $($HPDOwnload.Name)"
        if ( -not ( Test-path $localFIle) ) { throw "MIssing $LocalFile" }
        if ( get-filehash -Algorithm SHA1 $LocalFile | ? Hash -ne $HPDOwnload.hash ) { throw "Bad Hash on $LocalFIle" } 

    }   

}

#endregion 

#region Lenovo

if ( 'Lenovo' -in $Platforms ) { 

    # Beat it kid...

}

#endregion 


Stop-Transcript