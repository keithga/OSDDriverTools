function get-IWRSettings {
    <#
    .SYNOPSIS
    Get settings for Invoke-WebRequest

    .DESCRIPTION
    Hook used in environments where Web requests must go through proxys

    To generate, use:

    @{
        Proxy = "123.45.67.89"
        ProxyUseDefaultCredentials = $true
            # or 
        ProxyCredential = Get-Credential -Message 'Proxy Credentials' -UserName 'Outbound@MyDomain.com'
    } | Export-Clixml $profile\..\IWRSettings.xml


    #>
    [CmdletBinding()]
    param()

    [Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

    if ( test-path "$Profile\..\IWRSettings.xml") {
        Import-Clixml "$Profile\..\IWRSettings.xml" | Write-Output
    }
    else {
        @{ } | Write-Output
    }

}

