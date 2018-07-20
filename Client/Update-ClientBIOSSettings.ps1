<#
.Synopsis
   Update BIOS Settings on Client

.DESCRIPTION
   Install OEM Firmware Settings per OEM Model
  
.EXAMPLE
   .\Update-ClientBIOSSettings.ps1 <Path to OEM Settings>

.NOTES
    Keith Garner Keith@DeploymentLive.com

#>

[cmdletbinding()]
param( $DatabasePath )
. $PSScriptRoot\Update-ClientBIOSCommon.ps1

#region Verificaion and Logging
###########################################################

Start-Transcript

write-host "Update Firmware, using path $DataBasePath for Make:[$LocalMake] Model (Canonical):[$LocalModel] (Friendly):[$LocalFriendly]"

if ( ! ( Test-Path $DatabasePath ) ) { 
    throw "Missing Local SettingsCache"
}

if ( ! ( Test-Path $DatabasePath\$LocalMake ) ) { 
    throw "Missing Local FirmwareCache for Model $LocalMake"
}

if ( ! ( Test-Path $DatabasePath\$LocalMake\$($LocalModel).ini ) ) { 
    throw "Missing Local FirmwareCache database for Model $LocalMake"
}

#endregion

#region find package and run...
###########################################################

switch ( $LocalMake ) {
    'Dell' { 
        write-host "Ready to run Dell CCTK on file ..\$LocalMake\$($LocalModel).ini"
        & $DatabasePath\$LocalMake\Tools\cctk.exe -I "$DatabasePath\$LocalMake\$($LocalModel).ini" 
    }
    'HP' {
        write-host "Ready to run HP BIOSCOnfigUtility64 on file ..\$LocalMake\$($LocalModel).ini"
        & $DatabasePath\$LocalMake\Tools\BiosConfigUtility64.exe /set:"$DatabasePath\$LocalMake\$($LocalModel).ini" 
    }
    default { throw 'Not Found' }
}

#endregion
