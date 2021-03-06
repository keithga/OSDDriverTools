<#
.Synopsis
   Short description
.DESCRIPTION
   
   Doesn't really do much, just sets up the BIOS update toosl

.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>

[cmdletbinding()]
param(
    $Database = 'C:\DeploymentShare\Applications\Update BIOS Configuration',
    $Platforms = @('Dell','HP')
)

Start-Transcript

import-module $PsscriptRoot\..\OSDDriverTools -force

#region Dell

if ( 'Dell' -in $Platforms ) { 

    write-verbose "Process Dell"

    if ( -not ( test-path "${env:ProgramFiles(x86)}\Dell\Command Configure\X86_64\cctk.exe" ) ) {
        throw "missing Dell Bits, need to download locally"

        start 'https://downloads.dell.com/FOLDER04978295M/1/Dell-Command-Configure_2KRXV_WIN_4.1.0.478_A00.EXE'
                
    }

    robocopy /e /np /ndl "${env:ProgramFiles(x86)}\Dell\Command Configure\X86_64" $Database\Dell\Tools

}

#endregion

#region HP

if ( 'HP' -in $Platforms ) { 

    write-verbose "process HP"

    if ( -not ( test-path "${env:ProgramFiles(x86)}\hp\BIOS Configuration Utility\BiosConfigUtility64.exe" ) ) {
        throw "missing Dell Bits, need to download locally"

       start 'https://ftp.hp.com/pub/softpaq/sp88001-88500/sp88497.exe'
                
    }

    robocopy /e /np /ndl "${env:ProgramFiles(x86)}\hp\BIOS Configuration Utility" $Database\HP\Tools

}

#endregion 

Stop-Transcript