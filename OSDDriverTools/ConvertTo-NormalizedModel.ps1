function ConvertTo-NormalizedModel {

    switch -Regex ( gwmi win32_computersystem | % Manufacturer) {
        'Dell' { 'Dell' } 
        'Lenovo' { 'Lenovo' }
        'HP|Hewlett|Packard|Compaq' { 'HP' }
        default { $_ }
    }

}