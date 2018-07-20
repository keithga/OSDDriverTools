<#
.Synopsis
   Update BIOS Firmware on Client

.DESCRIPTION
   Install the latest firmware image from the OEM
  
.EXAMPLE
   .\Update-Firmware.ps1 <Path to full OEM Firmware>

.NOTES
    Keith Garner Keith@DeploymentLive.com

#>

[cmdletbinding()]
param(
    $DatabasePath = 'C:\DeploymentShare\Applications\Update BIOS Firmware'
)

. $PSScriptRoot\Update-ClientBIOSCommon.ps1

#region Verificaion and Logging
###########################################################

Start-Transcript

write-host "Update Firmware, using path $DataBasePath for Make:[$LocalMake] Model (Canonical):[$LocalModel] (Friendly):[$LocalFriendly]"

if ( ! ( Test-Path $DatabasePath ) ) { 
    throw "Missing Local FirmwareCache"
}

if ( ! ( Test-Path $DatabasePath\$LocalMake ) ) { 
    throw "Missing Local FirmwareCache for Model $LocalMake"
}

if ( ! ( Test-Path $DatabasePath\$LocalMake.clixml ) ) { 
    throw "Missing Local FirmwareCache database for Model $LocalMake"
}

#endregion

#region find package and run...
###########################################################

$ValidPackages = Import-Clixml $DatabasePath\$LocalMake.clixml | 
    ? { $LocalModel -in $_.Machines } |
    sort date -Descending # go from newest to oldest


foreach ( $Package in $ValidPackages ) {
    Write-Verbose "Test Package: $($Package.Name)"

    $NetFile   = join-path $DatabasePath\$LocalMake ( split-path -Leaf $package.URL )
    $LocalFile = join-path $env:temp ( split-path -Leaf $package.URL )

    if ( test-path $NetFile ) {
        write-host "Found [$($Package.Name)] binary: $($NetFile)"

        copy-item $NetFile $localFile

        Push-Location $env:temp

        write-host "ready to invoke command: $($Package.ExecuteCommand)"

        Invoke-Expression ( $Package.ExecuteCommand + ' | out-null' )

        Pop-location

        break
    }
}

#endregion

### XXX TBD