
function get-DriversForLenovo {
    <#
    .SYNOPSIS
    Get the Driver list from Lenovo

    .DESCRIPTION
    Get the Driver list from Lenovo

    #>
    [CmdletBinding()]
    param()

    $RawData = get-RawDataLenovo
    Write-Progress -Activity "Get Lenovo Drivers" -PercentComplete 0

    $IWRSettings = get-IWRSettings 

    $DriverList = $RawData.products.product | 
        where-object OS -in 'Win10','Win732','Win764'

    $i = 0

    $DriverList | ForEach-Object {

        Write-Progress -Activity "Get Lenovo DriverModel $Model"  -PercentComplete ( $i++ / $DriverList.Count * 100 ) 


        $SCCMLink = $_.DriverPack | where-object ID -eq "SCCM" | foreach-object '#text'

        $DrvLinks = Invoke-WebRequest -UseBasicParsing -Uri $SCCMLink @IWRSettings | 
            select-object -ExpandProperty content | 
            Select-String -Pattern 'https://download.lenovo.com[^\"]*exe' -AllMatches | 
            foreach-object Matches | 
            Foreach-Object Value 

        foreach ( $DrvLink in $DrvLinks ) {

            [pscustomobject] @{

                PackageID = split-path -leaf $SccmLink

                Name = split-path -leaf $DrvLink.replace('.exe','')
                Description = "Info: " + $Drvlink.replace('.exe','.txt') # Cheat!
                Tag = 'Driver Lenovo'
                Date = $_.DriverPack | Where-Object Date -match '^\d{6}$' | foreach-object { ($_.Date.substring(0,4)+'/'+$_.Date.SubString(4,2)+'/01') }
                Version = ''

                URL = $DrvLink
                Size = '' #TBD
                Hash = '' #TBD
                OSVer = $DrvLink | ConvertTo-NormalizedOSVersion

                ExtractCommand = 'expand <TBD>'
                ExecuteCommand = '' # Nothing to execute, copy
                Machines = $_.QUeries.Types.Type
            }
        }

    }

    Write-Progress -Completed -Activity "Get Lenovo Drivers"

}
