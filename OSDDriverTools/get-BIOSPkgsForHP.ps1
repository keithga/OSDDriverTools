
function get-BIOSPkgsForHP {
    <#
    .SYNOPSIS
    Get the BIOS Package list from HP

    .DESCRIPTION
    Get the BIOS Package list from HP

    #>
    [CmdletBinding()]
    param()

    $RawData = get-RawDataHP

    $ModelTable = get-ModelInfoHP

    # TBD...

}
