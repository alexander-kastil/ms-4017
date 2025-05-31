<#
.SYNOPSIS
    This script Configures Copilot for Microsoft 365 in Bing, Edge, and Windows.

.DESCRIPTION
    This script Configures Copilot for Microsoft 365 in Bing, Edge, and Windows. 

.EXAMPLE
    PS C:\> .\ConfigureM365Copilot.ps1 -enable $true
    when not passing -enable parameter to the script, the script will return current Microsoft 365 Copilot status in Bing, Edge, and Windows.
    This script installs necessary modules, connects to Azure services, and Configures Copilot for Microsoft 365 in Bing, Edge, and Windows for tenant.
#>
param (
    [ValidateSet($null, $true, $false)]
    [object] $enable
)

$uri = "https://business.bing.com/api/v3/admin/m365copilot/toggle"
$resourceUri = "https://copilot.microsoft.com"

<#
.DESCRIPTION
Helper function to print HTTP error messages
#>
function Write-Http-Error {
    Param(
        [Parameter(Mandatory)]
        [object] $exception
    )


    $statusCode = $exception.Exception.Response.StatusCode.value__
    $statusDescription =$exception.Exception.Response.StatusDescription

    Write-Host "StatusCode: $statusCode"
    Write-Host "StatusDescription: $statusDescription"
    Write-Host "[ERROR] $exception" -ForegroundColor Red
}

<#
.DESCRIPTION
Installs the Az and Az.Accounts modules if they are not already present on the system. 
#>
function Install-Modules {
    try {
        if (-not (Get-Module -ListAvailable -Name Az.Accounts)) {
            install-module -name Az.Accounts -AllowClobber -Force
            Write-Host "AzAccounts module installed." -ForegroundColor Green
        }
    }
    catch {
        $message = $_
        Write-Error "[ERROR] Unable to install required module. Error: $message" -ForegroundColor Red
        exit
    }
}

<#
.DESCRIPTION
Connects to Azure services and retrieves an access token for authenticated operations.
#>
function Get-AccessToken {
    try {
        Write-Host "Please sign in as a Search or Global Administrator."
        $azconnect = Connect-AzAccount
        Write-Host "Connected tenant: $($azconnect.Context.Tenant) with Account: $($azconnect.context.Account.Id)" -ForegroundColor Green
    }
    catch {
        Write-Error $_
        Write-Error "[ERROR] Unable to connect to Entra ID. Please re-run the script or contact support"
        exit
    }

    try {
        $token = Get-AzAccessToken -ResourceUrl $resourceUri
    }
    catch {
        Write-Error $_
        Write-Error "[ERROR] Unable to obtain access token. Please re-run the script or contact support"
        exit
    }

    return $token
}

<#
.DESCRIPTION
Retrieves and displays the current Copilot for Microsoft 365 status in Bing, Edge, and Windows.

.PARAMETER accessToken
The access token for authorization.

.OUTPUTS
Boolean
  $true - Copilot for Microsoft 365 in Bing, Edge, and Windows enabled for the tenant.
  $false - Copilot for Microsoft 365 in Bing, Edge, and Windows enabled for the tenant.

.EXAMPLE
$isCopilotEnabled = Get-M365Copilot-Status -accessToken 'your_access_token'
#>
function Get-M365Copilot-Status {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [string] $accessToken
    )

    Write-Host "Fetching Copilot for Microsoft 365 status in Bing, Edge, and Windows..."

    try {
        $headers = @{
            "Authorization" = "Bearer $accessToken"
        }

        $response = Invoke-RestMethod -Uri $uri -Method 'GET' -Headers $headers
        if ($null -eq $response -or $null -eq $response.IsEnabled)
        {
            Write-Error "Failed to read Copilot for Microsoft 365 status in Bing, Edge, and Windows. Please re-run the script or contact support."
            exit
        }
 
        if ($response.IsEnabled)
        {
            $msg = "enabled"
        }
        else
        {
            $msg = "disabled"
        }

        Write-Host "Copilot for Microsoft 365 in Bing, Edge, and Windows is $msg for tenant." -ForegroundColor Green
        return $response.IsEnabled
     }
    catch {
        Write-Http-Error -exception $_
        Write-Error "Error while trying to read Copilot for Microsoft 365 status in Bing, Edge, and Windows. Please re-run the script or contact support."
        exit
    }
}

<#
.DESCRIPTION
Set Copilot for Microsoft 365 in Bing, Edge, and Windows for tenant.

.PARAMETER enable
true - enable Copilot for Microsoft 365 in Bing, Edge, and Windows for tenant.
false - disable Copilot for Microsoft 365 in Bing, Edge, and Windows for tenant.

.PARAMETER accessToken
The access token for authorization.

.EXAMPLE
Set-M365Copilot-Status -enable $true -accessToken 'your_access_token'
#>
function Set-M365Copilot-Status {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [boolean] $enable,

        [Parameter(Mandatory)]
        [string] $accessToken
    )

    try {
         $isCopilotEnabled = Get-M365Copilot-Status -accessToken $accessToken

        if ($isCopilotEnabled -and $enable)
        {
            Write-Host "Copilot for Microsoft 365 in Bing, Edge, and Windows is already enabled, no need to enable it again." -ForegroundColor Yellow
            exit
        }
        elseif (!$isCopilotEnabled -and !$enable) 
        {
            Write-Host "Copilot for Microsoft 365 in Bing, Edge, and Windows is already disabled, no need to disable it again." -ForegroundColor Yellow
            exit
        }

        $headers = @{
            "Authorization" = "Bearer $accessToken"
        }

        $body = @{
            "Enable" = $enable
        } | ConvertTo-Json

        Write-Host "Setting Copilot for Microsoft 365 in Bing, Edge, and Windows for tenant enable: $enable ..."
        $response = Invoke-RestMethod -Uri $uri -Method "POST" -Headers $headers -Body $body -ContentType 'application/json'
    
        return $response
    }
    catch {
        Write-Http-Error -exception $_
        Write-Error "Error while trying to set Copilot for Microsoft 365 setting in Bing, Edge, and Windows. Please re-run the script or contact support."
        exit
    }
}

<#
.DESCRIPTION
Enable Copilot for Microsoft 365 in Bing, Edge, and Windows for tenant.

.PARAMETER accessToken
The access token for authorization.

.EXAMPLE
Enable-M365Copilot -accessToken 'your_access_token'
#>
function Enable-M365Copilot {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [string] $accessToken
    )

    try {
        $response = Set-M365Copilot-Status -enable $true -accessToken $accessToken

        Write-Host "Copilot for Microsoft 365 in Bing, Edge, and Windows is enabled for tenant." -ForegroundColor Green
    }
    catch {
        Write-Http-Error -exception $_
        Write-Error "Error while trying to enable Copilot for Microsoft 365 in Bing, Edge, and Windows for tenant. Please re-run the script or contact support."
        exit
    }
}

<#
.DESCRIPTION
Disable Copilot for Microsoft 365 in Bing, Edge, and Windows for tenant.

.PARAMETER accessToken
The access token for authorization.

.EXAMPLE
Disable-M365Copilot -accessToken 'your_access_token'
#>
function Disable-M365Copilot {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [string] $accessToken
    )

    try {
        $response = Set-M365Copilot-Status -enable $false -accessToken $accessToken
 
        Write-Host "Copilot for Microsoft 365 in Bing, Edge, and Windows is disabled for tenant." -ForegroundColor Green
    }
    catch {
        Write-Http-Error -exception $_
        Write-Error "Error while trying to disable Copilot for Microsoft 365 in Bing, Edge, and Windows for tenant. Please re-run the script or contact support."
        exit
    }
}

try {
    Write-Host "============================================"
    Write-Host "Configure Copilot for Microsoft 365 in Bing, Edge, and Windows" -ForegroundColor Green
    Write-Host "============================================`n"
    Write-Host "Setting up..."
    Write-Host
    
    # Attempt to install modules and connect to the account
    Install-Modules
    $token = Get-AccessToken

    if ($enable -eq $true)
    {
        Write-Host "Enabling Copilot for Microsoft 365 in Bing, Edge, and Windows..."
        $res = Enable-M365Copilot $token.Token
    }
    elseif ($enable -eq $false)
    {
        Write-Host "Disabling Copilot for Microsoft 365 in Bing, Edge, and Windows..."
        $res = Disable-M365Copilot $token.Token
    }
    else
    {
        Write-Host "Getting Copilot for Microsoft 365 status in Bing, Edge, and Windows..."
        $res = Get-M365Copilot-Status $token.Token
    }
}
catch {
    Write-Error "[ERROR] An error occurred: $_"
    exit
}