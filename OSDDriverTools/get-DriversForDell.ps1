
function get-DriversForDell {
    <#
    .SYNOPSIS
    Get the BIOS Package list from Dell

    .DESCRIPTION
    Get the BIOS Package list from Dell

    #>
    [CmdletBinding()]
    param()

    $RawData = get-RawDataDell

    $ModelTable = get-ModelInfoDell

    $RawData.DriverPackManifest.DriverPackage |
        Where-Object { 
            ($_.type -eq 'win') -and
            ( ( ($_.SupportedOperatingSystems.OperatingSystem.OSCode) -contains 'Windows7') -or ( ($_.SupportedOperatingSystems.OperatingSystem.OSCode) -contains 'Windows10')) -and
            ( $True )
        } | 
        ForEach-Object {
            $arch = $_.SupportedOperatingSystems.OPeratingSystem | 
                select-object -first 1 |
                %{ $_.OSCode.Replace('Windows','W') + $_.osArch }

            [pscustomobject] @{

                PackageID = $_.ReleaseID
                Name = $_.Name.Display.'#cdata-section'.trim()
                Description = 'Details: ' + $_.ImportantInfo.URL
                Tag = 'BIOS Driver'
                Date = $_.dateTime
                Version = $_.DellVersion

                URL = 'http://' + $RawData.DriverPackManifest.BaseLocation + '/' + $_.Path
                Size = $_.Size
                Hash = $_.HashMD5

                ExtractCommand = 'expand <TBD>'
                ExecuteCommand = '' # Nothing to execute, copy
                Machines = $_.SupportedSystems.Brand.Model.SystemID # | ForEach-Object { $ModelTable.Item($_) }

            }
        } | Write-Output

}


