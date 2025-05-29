# Connect to SharePoint Online
$SPOSiteUrl = "https://integrationsonline-admin.sharepoint.com/"
Connect-SPOService -Url $SPOSiteUrl

# Get the restricted search mode for the tenant
$restrictedSearchMode = Get-SPOTenant | Select-Object -ExpandProperty RestrictedSearchMode

Write-Output "Restricted Search Mode: $restrictedSearchMode"

Set-SPOTenantRestrictedSearchMode -Mode Enabled  

Add-SPOTenantRestrictedSearchAllowedList -SitesList @("[https://integrationsonline.sharepoint.com/sites/learning](https://integrationsonline.sharepoint.com/sites/learning)", "[https://integrationsonline.sharepoint.com/sites/office](https://integrationsonline.sharepoint.com/sites/office)")