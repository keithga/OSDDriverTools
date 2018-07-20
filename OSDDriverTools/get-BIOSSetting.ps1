function get-BIOSSetting {
    [cmdletbinding()]
    param ( $Name )

    switch ( ConvertTo-NormalizedModel ) {
        'Dell'   { Get-biossettingDell @PSBoundParameters } 
        'Lenovo' { Get-biossettingDell @PSBoundParameters }
        'HP'     { Get-biossettingDell @PSBoundParameters }
        default { throw "unknown computer Type: $_" }
    }
}
