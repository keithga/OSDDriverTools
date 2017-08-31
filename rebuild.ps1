
<#

.SYNOPSIS 
OSDDriverTools - Main Build Scripts

.DESCRIPTION
Hydration Environment for OSDDriverTools Powershell Common Modules
Build environment

.NOTES
Copyright Keith Garner (KeithGa@DeploymentLive.com), All rights reserved.

.LINK
https://github.com/keithga/OSDDriverTools

#>

[cmdletbinding()]
param(
)

$ModuleCommon = @{
    Author = "Keith Garner (KeithGa@DeploymentLive.com)"
    CompanyName  = "https://github.com/keithga/OSDDriverTools" 
    Copyright = "Copyright Keith Garner (KeithGa@DeploymentLive.com), all Rights Reserved."
    ModuleVersion = ("1.1." + (get-date -Format "yyMM.dd"))
    PowershellVersion = "2.0"
    Description = "OSD Drivers Powershell Library"
    GUID = [GUID]"{cca54e24-ff59-4ec6-aa8a-0e2b24e5ce9b}"
}

Foreach ( $libPath in get-childitem -path $PSScriptRoot -Directory )
{
    Write-Verbose "if not exist $($libPath.FullName)\*.psm1, then create"

@"

<#
.SYNOPSIS 
OSDDriverTools PowerShell Library

.DESCRIPTION
OSDDriverTools for PowerShell Module Library

.NOTES
Copyright Keith Garner (KeithGa@DeploymentLive.com), All rights reserved.

.LINK
https://github.com/keithga/OSDDriverTools

#>

[CmdletBinding()]
param(
    [parameter(Position=0,Mandatory=`$false)]
    [Switch] `$Verbose = `$false
)

if (`$Verbose) { `$VerbosePreference = 'Continue' }

Get-ChildItem -Path "`$PSScriptRoot\*.ps1" -exclude '*.tests.ps1' | 
    ForEach-Object {
        Write-Verbose "Importing function `$(`$_.FullName)"
        . `$_.FullName | Out-Null
    }

Export-ModuleMember -Function * 

"@ | Out-File -Encoding ascii -FilePath "$($LibPath.FullName)\$($LibPath.Name).psm1"


    $ManifestName = "$($LibPath.FullName)\$($LibPath.Name).psd1"
    New-ModuleManifest @Modulecommon -path $ManifestName -ModuleToProcess "$($LibPath.Name).psm1" -FileList $FileList -ModuleList $FileList

}

