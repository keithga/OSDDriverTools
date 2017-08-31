
function get-BIOSPkgsForLenovo {
    <#
    .SYNOPSIS
    Get the BIOS Package list from Lenovo

    .DESCRIPTION
    Get the BIOS Package list from Lenovo

    #>
    [CmdletBinding()]
    param()

    $ModelTable = get-ModelInfoLenovo

    $results = @{}
    $i = 0

    Write-Progress -Activity "Get Lenovo BIOS" -PercentComplete 0

    $ModelTable.Keys |
        ForEach-Object {

            $Model = $_
            Write-Progress -Activity "Get Lenovo BIOS Model $Model"  -PercentComplete ( $i++ / $ModelTable.Count * 100 ) 
            get-RawXMLDataWithCache "https://download.lenovo.com/catalog/$($_)_win10.xml" | 
                foreach-object {

                    $_.Packages.Package | 
                    Where-Object Category -match "BIOS" |
                    Where-object location -notmatch 'mobilesjp' |
                    Select-Object -last 1 |
                    ForEach-Object {

                        #Enumeate through all the models, but only include the package once.
                        $URI = $_.location 
                        write-verbose $_.Location 
                        if ( $_.location -in $results.keys ) {
                            $results.item($_.location).Machines += $Model 
                        }
                        else {

                            $BinaryParent = $_.Location.replace((split-path -leaf $_.Location),'')
                            get-RawXMLDataWithCache $_.Location | 
                            ForEach-Object {

                                $results.Add( $URI, 
                                    [pscustomobject] @{

                                        PackageID = $_.Package.id
                                        Name = $_.Package.Title.Desc.'#text'.trim()
                                        Description = $_.Package.Files.Readme.File.Name | select-object -first 1 | foreach-object { "Notes: " + $BinaryParent + $_ }                                
                                        Tag = 'BIOS Lenovo'
                                        Date = $_.Package.ReleaseDate
                                        Version = $_.Package.version

                                        URL = $_.Package.Files.Installer.File.Name | select-object -first 1 | foreach-object { $BinaryParent + $_ }

                                        Size = $_.Package.Files.Installer.File.Size | select-object -first 1
                                        Hash = $_.Package.Files.Installer.File.CRC | select-object -first 1

                                        ExtractCommand = $_.Package.ExtractCommand
                                        ExecuteCommand = $_.Package.Install.CmdLine.'#text'.trim()
                                        Machines = @($Model)

                                    }
                                )
                            }

                        }
                            
                    }
                }                
        }

    $results.values | Write-Output

    Write-Progress -Completed -Activity "Get Lenovo BIOS"
}

