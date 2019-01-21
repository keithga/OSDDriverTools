function get-DriversForHP {
    <#
    .SYNOPSIS
    Get the Driver list from HP

    .DESCRIPTION
    Get the Driver list from HP

    #>
    [CmdletBinding()]
    param()

    $RawData = get-RawDataHP

    $ModelTable = get-ModelInfoHP

    $results = @{}

    $rawdata.NewDataSet.HPClientDriverPackCatalog.ProductOSDriverPackList.ProductOSDriverPack | 
        ForEach-Object {

            if ( $_.SoftPaqId -in $results.keys ) {
                if ( $_.SystemID -notin $results.item($_.SoftPaqId).Machines ) {
                    $results.item($_.SoftPaqId).Machines += $_.SystemID
                }
            }
            else {

                $SoftPaq = $rawdata.newdataset.HPClientDriverPackCatalog.softpaqlist.softpaq | 
                    where ID -eq $_.SoftPaqId | 
                    select-object -First 1

                $results.Add( $_.SoftPaqID, 
                    [pscustomobject] @{

                        PackageID = $_.SoftPaqId
                        Name = $SoftPaq.Name
                        Description = 'Details: ' + $SoftPaq.ReleaseNotesUrl
                        Tag = 'Driver HP'
                        Date = $SoftPaq.DateReleased
                        Version = $SoftPaq.Version

                        URL = $SoftPaq.url
                        Size = $SoftPaq.size
                        Hash = $SoftPaq.MD5
                        OSVer = $_.OSName | ConvertTo-NormalizedOSVersion

                        ExtractCommand = 'expand <TBD>'
                        ExecuteCommand = '' # Nothing to execute, copy
                        Machines = @($_.SystemID -split ',')
                        FriendlyMachines = @($_.SystemID -split ',' | ForEach-Object { $ModelTable.Item($_) })

                    }
                )

            }

        }

    $results.values | Write-Output

}
