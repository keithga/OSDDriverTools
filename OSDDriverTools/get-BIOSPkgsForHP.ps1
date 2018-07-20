
function get-BIOSPkgsForHP {
    <#
    .SYNOPSIS
    Get the BIOS Package list from HP

    .DESCRIPTION
    Get the BIOS Package list from HP

    #>
    [CmdletBinding()]
    param()

    $RawData2 = get-RawDataHP2

    $ModelTable = get-ModelInfoHP


    $rawdata2.SystemsManagementCatalog.SoftwareDistributionPackage | 
        Where-Object {
            ($_.Properties.PRoductName -eq 'Firmware') -and 
            ($_.LocalizedProperties.Title -notmatch '(ME)') -and 
            ($true )
        } |
        Foreach-Object {

            [pscustomobject] @{

                PackageID = $_.UpdateSpecificData.KBArticleID
                Name = $_.LocalizedProperties.Title
                Description = 'Details: ' + $_.Properties.MoreInfoUrl
                Tag = 'BIOS HP'
                Date = [datetime]$_.Properties.CreationDate
                Version = $_.LocalizedProperties.Title | ? { $_ -match '\[([0-9A-Z\.]*)\]' } | % { $matches[1] }

                URL =  $_.InstallableItem.OriginFile.OriginUri
                Size = $_.InstallableItem.OriginFile.Size
                Hash = [System.BitConverter]::ToString([system.convert]::FromBase64String($_.InstallableItem.OriginFile.Digest)).replace('-','')  # SHA1 :^p

                ExtractCommand = ''  # Nothing to extract for HP BIOS commands
                ExecuteCommand = '.\' + $_.InstallableItem.CommandLineInstallerData.PRogram + ' ' + $_.InstallableItem.CommandLineInstallerData.Arguments
                Machines = ( $_.InstallableItem.ApplicabilityRules.IsInstalled.innerxml | select-string -AllMatches -Pattern "product LIKE '%([0-9A-F]{4})%'" | % Matches | % { $_.Groups[1].Value } ) # -join ' ' 
                MachinesFriendly = ( $_.InstallableItem.ApplicabilityRules.IsInstalled.innerxml | select-string -AllMatches -Pattern "product LIKE '%([0-9A-F]{4})%'" | % Matches | % { $_.Groups[1].Value } ) | ForEach-Object { $ModelTable.Item($_) }
            }
        } | Write-Output

}
