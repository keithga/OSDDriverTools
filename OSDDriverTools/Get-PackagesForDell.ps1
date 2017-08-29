
function get-PackagesForDell {
    <#
    .SYNOPSIS
    Get the BIOS Package list from Dell

    .DESCRIPTION
    Get the BIOS Package list from Dell

    #>
    [CmdletBinding()]
    param()

    $RawData = get-RawDataDell2

    $ModelTable = get-ModelInfoDell

    $RawData.Manifest.SoftwareComponent |
        Where-Object { 
            ($_.category.value -eq 'BI') -and
            ( $True )
        } | 
        ForEach-Object {

            [pscustomobject] @{

                PackageID = $_.PackageID
                Name = $_.Name.Display.'#cdata-section'.trim().replace(',',' ')
                Description = 'Details: ' + $_.ImportantInfo.URL
                Tag = 'BIOS Dell'
                Date = $_.dateTime
                Version = $_.DellVersion

                URL = 'http://' + $RawData.Manifest.BaseLocation + '/' + $_.Path
                Size = $_.Size
                Hash = $_.HashMD5

                ExtractCommand = ''  # Nothing to extract for Dell BIOS commands
                ExecuteCommand = '.\' + (split-path -leaf $_.Path) + ' /s /l=%temp%\BIOSUpdate.log'
                Machines = $_.SupportedSystems.Brand.Model.SystemID | ForEach-Object { $ModelTable.Item($_) }

            }
        } | Write-Output


}
