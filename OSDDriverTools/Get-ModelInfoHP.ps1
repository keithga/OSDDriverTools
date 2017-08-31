
function get-ModelInfoHP {
    <#
    .SYNOPSIS
    Get the Model list from HP 

    .DESCRIPTION
    Get the Model list from HP in KVP format

    @{
        Key = (gwmi win32_baseboard).Product
        Value = (gwmi Win32_ComputerSystem).Model
    }

    #>
    [CmdletBinding()]
    param()

    $MatchString = '^(HP )(.*) ?(Notebook PC|Tablet|Tablet PC|Notebook PC Bundle|Base Model|Microtower PC|Workstation|Small Form Factor PC|Convertible Minitower PC|Ultra-slim PC|All-in-One PC|Ultrabook|Desktop Mini PC|Tower PC|Convertible PC)( \(ENERGY STAR\))?$'

    $RawData = get-RawDataHP

    $result = @{}
    foreach ( $Model in $RawData.NewDataSet.HPClientDriverPackCatalog.ProductOSDriverPackList.ProductOSDriverPack ) {
        $Model.SystemId -split ',' |
            where-object { ! $result.containsKey( $_ ) } |
            ForEach-Object {
                if ( $false ) {
                # $model.systemname -match $MatchString) { 
                    write-verbose " translate $($model.systemname) ==> $($Matches[2])"
                    $result.add($_,$($Matches[2]))
                }
                else {
                    $result.add($_,$model.systemname)
                }

            }
    }

    $Result | write-output

}
