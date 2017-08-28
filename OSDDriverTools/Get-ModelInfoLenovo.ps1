function get-ModelInfoLenovo {
    <#
    .SYNOPSIS
    Get the Model list from Lenovo 

    .DESCRIPTION
    Get the Model list from Lenovo in KVP format

    #>
    [CmdletBinding()]
    param()

    $RawData = get-RawDataLenovo


    $result = @{}
    foreach ( $Model in $RawData.Products.Product.queries ) {
        $Model.Types.Type |
            where-object { ! $result.containsKey( $_ ) } |
            ForEach-Object {
                $result.add($_,$model.Version)
            }
    }

    $Result | write-output

}
