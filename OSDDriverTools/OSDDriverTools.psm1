
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
    [parameter(Position=0,Mandatory=$false)]
    [Switch] $Verbose = $false
)

if ($Verbose) { $VerbosePreference = 'Continue' }

Get-ChildItem -Path "$PSScriptRoot\*.ps1" -exclude '*.tests.ps1' | 
    ForEach-Object {
        Write-Verbose "Importing function $($_.FullName)"
        . $_.FullName | Out-Null
    }

Export-ModuleMember -Function * 

