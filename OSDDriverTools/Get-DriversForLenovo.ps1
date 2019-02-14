
function get-DriversForLenovo {
    <#
    .SYNOPSIS
    Get the Driver list from Lenovo

    .DESCRIPTION
    Get the Driver list from Lenovo

    .NOTES
    There is still an issue with the lenovo manifest Where the Global XML file can have two entries like the M700 and M800 point to the same EXE file. 
    Only a half dozen double entries, so skip for now.

    #>
    [CmdletBinding()]
    param()

    $RawData = get-RawDataLenovo
    Write-Progress -Activity "Get Lenovo Drivers" -PercentComplete 0

    $ModelTable = get-ModelInfoLenovo

    $IWRSettings = get-IWRSettings 

    $DriverList = $RawData.products.product | 
        where-object OS -in 'Win10','Win732','Win764'

    $FoundIDs = @{}

    $ie = New-Object -com InternetExplorer.Application

    foreach ( $Driver in $DriverList ) {

        Write-Progress -Activity "Get Lenovo DriverModel $($DRiver.Model)"  -PercentComplete ( $i++ / $DriverList.Count * 100 ) 

        $SCCMLink = $Driver.DriverPack | where-object ID -eq "SCCM" | foreach-object '#text'

        write-verbose $SCCMLink

        if ( $FoundIDs.ContainsKey($SCCMLink) ) { write-verbose "Dupe $SccmLink" ; continue }
        $FoundIDs.add($SCCMLink,"")
        $Driver | out-string | Write-Verbose

        #region SPECIAL Lenovo parsing

        try {
	        $ie.navigate($SCCMLink)
	        while ($ie.ReadyState -ne 4) {
		        start-sleep -m 100
	        }
	        $ie.Document.parentWindow.execScript("var JSIEVariable = new XMLSerializer().serializeToString(document);", "javascript")
	        $obj = $ie.Document.parentWindow.GetType().InvokeMember("JSIEVariable", 4096, $null, $ie.Document.parentWindow, $null)
	        $html = $obj.ToString()
        }
        catch {
	        Write-Error "Error: $($Driver.Exception.Message)"
        }
        
        $DrvLinks = $HTML | Select-String '(?<Link>http[s]?://download.lenovo.com[^\"]*exe).*SHA-256:(?<SHA256>[0-9A-Fa-f]{64})' -AllMatches | % Matches 

        #endregion

        foreach ( $DrvKink in $DrvLinks ) {

            $DrvLink = $DrvKink | % Groups | ? Name -eq 'LINK' | % VALUE 

            [pscustomobject] @{

                PackageID = split-path -leaf $SccmLink

                Name = split-path -leaf $DrvLink.replace('.exe','')
                Description = "Info: " + $Drvlink.replace('.exe','.txt') # Cheat!
                Tag = 'Driver Lenovo'
                Date = $Driver.DriverPack | Where-Object Date -match '^\d{6}$' | foreach-object { ($_.Date.substring(0,4)+'/'+$_.Date.SubString(4,2)+'/01') }
                Version = $Driver.DriverPack | Where-Object Date -match '^\d{6}$' | % Date

                URL = $DrvLink
                Size = 0 # No driver size on the page :^(
                Hash = $DrvKink | % Groups | ? Name -eq 'SHA256' | % VALUE
                OSVer = $Driver.OS | ConvertTo-NormalizedOSVersion
                # OSVer = $DrvLink | ConvertTo-NormalizedOSVersion

                ExtractCommand = 'expand <TBD>'
                ExecuteCommand = '' # Nothing to execute, copy
                Machines = $Driver.QUeries.Types.Type
                FriendlyMachines = $Driver.QUeries.Types.Type | ForEach-Object { $ModelTable.Item($_) }

            }
        }
        
    }

    $ie.Quit()

    Write-Progress -Completed -Activity "Get Lenovo Drivers"

}
