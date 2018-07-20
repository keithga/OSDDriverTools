<#

Import a BIOS Configuration Tool, if generated from an external source.

#>

[cmdletbinding()]
param(
    [string] $DatabasePath,
    [string[]] $Path
)

#region Verificaion and Logging
###########################################################

if ( ! ( Test-Path $DatabasePath ) ) { 
    throw "Missing Local SettingsCache"
}

if ( ! ( Test-Path $DatabasePath\Dell ) ) { 
    throw "Missing Local FirmwareCache for Dell"
}

if ( ! ( Test-Path $DatabasePath\HP ) ) { 
    throw "Missing Local FirmwareCache for HP"
}

#endregion

#region find package and run...
###########################################################


foreach ( $file in $Path ) { 

    $Content = type $file -Raw

    if ( $content | Select-String -pattern 'BIOSConfig 1.0' ) {

        Write-host "this is a HP machine"

        $SystemID = $content | select-string -pattern '(?smi)System Board ID[^\t]+\t([0-9A-F]*)' | % { $_.matches.Groups[-1].value }

        Write-Host "found: $SystemID"
        Copy-Item $file "$DatabasePath\HP\$($SystemID).ini" 

    }
    elseif ( $content | Select-String -pattern '^\[cctk\]' ) {
        Write-host "this is a Dell machine"

        $SystemID = $content | Select-String -Pattern 'SysID=([0-9A-F]{4})' | % { $_.matches.Groups[-1].value }

        Write-Host "found: $SystemID"
        Copy-Item $file "$DatabasePath\dell\$($SystemID).ini" 

    }
    else {
        throw "bad type"
    }

}


#endregion