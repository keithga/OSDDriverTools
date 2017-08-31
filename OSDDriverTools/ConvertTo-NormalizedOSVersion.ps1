finds
function ConvertTo-NormalizedOSVersion {
    <#

    Each OEM has their own way of writting the OS version.  Windows 7, Win 7, Win7, W7, x86, x32, 32-bit

    this function will normalize the output into a single format style:

        Win7.x64
        Win8.x64
        Win10.x64.1703
        Win10.x64.1607
        Win7.x86
        Win8.x86
        Win10.x86
        Win10.x64

    #>

    [cmdletbinding()]
    param ( 
       [parameter(Mandatory=$true, ValueFromPipeline=$true)]
       [string[]] $OSVer
    )

    process {
        foreach ( $os in $OSver ) {

            switch -regex ( $os )
            {

                '_w8164' { 'Win81.x64' | write-output; break}   # Lenovo silliness
                '_wb64' { 'Win10.x64' | write-output; break}   # Lenovo silliness
                '_wb32' { 'Win10.x86' | write-output; break}   # Lenovo silliness
                'winpe10x.x64' { 'Win10.x64' | write-output; break} 
                'winpe10x.x86' { 'Win10.x86' | write-output; break} 

                '(Vista|XP|WinPE)'               { throw "Type $OSVer is unsupported"; break }

                'W(in(dows)?)?.*(?<OS>7|8|8\.1|10)[^0-9]*(?<arch>64|32|86)[^0-9]*(?<Ver>1507|1511|1607|1703|1709|1803|1809)?' { 
                    $matches | out-string | Write-verbose
                    'Win' + $matches.OS + '.x' + $matches.Arch + '.' + $Matches.Ver | 
                    ForEach-Object { $_.Replace('x32','x86').replace('Win8.1','Win81').trim('.') } |
                    Write-output
                    Break
                }

                default                          { throw "unknown type $OSver"; Break }
            }
        }
    }
}
