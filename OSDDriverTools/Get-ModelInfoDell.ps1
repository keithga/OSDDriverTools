function get-ModelInfoDell {
    <#
    .SYNOPSIS
    Get the Model list from dell 

    .DESCRIPTION
    Get the Model list from dell in KVP format

    #>
    [CmdletBinding()]
    param()

    $RawData = get-RawDataDell


    $result = @{}
    $RawData.DriverPackManifest.DriverPackage.SupportedSystems.Brand.Model |
        where-object { ! $result.containsKey( $_.SystemID ) } |
        ForEach-Object { 
            $result.add($_.SystemID,$_.Name) 
        }

    $Result | write-output

}
