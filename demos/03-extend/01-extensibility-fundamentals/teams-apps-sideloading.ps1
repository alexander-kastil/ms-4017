Install-Module -Name PowerShellGet -Force -AllowClobber
Install-Module -Name MicrosoftTeams -Force -AllowClobber
Import-Module MicrosoftTeams
Connect-MicrosoftTeams
Get-CsTeamsAppSetupPolicy
 Set-CsTeamsAppSetupPolicy -Identity Global -AllowUserPinning $true -AllowSideLoading $true