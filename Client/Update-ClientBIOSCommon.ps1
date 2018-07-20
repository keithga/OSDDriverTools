<#
.Synopsis
   Common library for BIOS running on Clients

.DESCRIPTION
   Library
  
.NOTES
    Keith Garner Keith@DeploymentLive.com

#>

#region Get Make And Model for local machine

    switch -Regex ( gwmi win32_computersystem | % Manufacturer) {
        'Dell' { 
            $LocalMake = 'Dell'
            $LocalModel = (gwmi Win32_ComputerSystem).SystemSKUNumber
            $LocalFriendly = (gwmi Win32_ComputerSystem).Model
        }
        'Lenovo' {
            $LocalMake = 'Lenovo'
            $LocalModel = (gwmi Win32_baseboard).product.SubString(0,4)
            $LocalFriendly = (gwmi Win32_ComputerSystemProduct).Version
        }
        'HP|Hewlett|Packard|Compaq' {
            $LocalMake = 'HP'
            $LocalModel = (gwmi win32_baseboard).Product
            $LocalFriendly = (gwmi Win32_ComputerSystem).Model
        }
        default { throw "unknown type, not dell,HP or Lenovo" }
    }

    write-verbose "Update Firmware, using path $DataBasePath for Make:[$LocalMake] Model (Canonical):[$LocalModel] (Friendly):[$LocalFriendly]"


#endregion

