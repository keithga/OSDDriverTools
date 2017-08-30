
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

    $DriverList = $RawData.products.product | 
        where-object OS -in 'Win10','Win732','Win764'

    $i = 0

    $DriverList | ForEach-Object {

        Write-Progress -Activity "Get Lenovo DriverModel $Model"  -PercentComplete ( $i++ / $DriverList.Count * 100 ) 


        $SCCMLink = $_.DriverPack | where-object ID -eq "SCCM" | foreach-object '#text'

        $DrvLinks = Invoke-WebRequest -UseBasicParsing -Uri $SCCMLink | 
            select-object -ExpandProperty content | 
            Select-String -Pattern 'https://download.lenovo.com[^\"]*exe' -AllMatches | 
            foreach-object Matches | 
            Foreach-Object Value 

        foreach ( $DrvLink in $DrvLinks ) {

            $OSVer = 'ddd'
                if ( $DrvLink -like '*_W1064_*' ) { $OSVer = 'Win1064' }
                if ( $DrvLink -like '*_W1032_*' ) { $OSVer = 'Win1064' }
                if ( $DrvLink -like '*_W764_*' -or $DrvLink -like '*_W7_64_*' )  { $OSVer = 'Win1064' }
                if ( $DrvLink -like '*_W732_*' -or $DrvLink -like '*_W7_32_*' )  { $OSVer = 'Win1064' }

            [pscustomobject] @{

                PackageID = split-path -leaf $SccmLink

                Name = split-path -leaf $DrvLink.replace('.exe','')
                Description = "Info: " + $Drvlink.replace('.exe','.txt')
                Tag = 'Driver Lenovo'
                Date = $_.DriverPack | Where-Object Date -match '^\d{6}$' | foreach-object { ($_.Date.substring(0,4)+'/'+$_.Date.SubString(4,2)+'/01') }
                Version = ''

                URL = $DrvLink

                Size = '' #TBD
                Hash = '' #TBD

                OSVer = $OSVer

                ExtractCommand = 'expand <TBD>'
                ExecuteCommand = '' # Nothing to execute, copy
                Machines = $_.QUeries.Types.Type
            }
        }

    }

    Write-Progress -Completed -Activity "Get Lenovo Drivers"

}
