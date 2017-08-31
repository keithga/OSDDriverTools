
function get-ModelInfoDell {
    <#
    .SYNOPSIS
    Get the Model list from dell 

    .DESCRIPTION
    Get the Model list from dell in KVP format

    @{
        Key = (gwmi Win32_ComputerSystem).SystemSKUNumber
        Value = (gwmi Win32_ComputerSystem).Model
    }

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
