Install-Module -Name PowerShellForGithub
Install-Module -Name PowerShellForGithub
Install-Module -Name PowerShellForGithub
Install-Module -Name PowerShellForGithub
cls
Read-Host -AsSecureString -Prompt 'token' | ConvertFrom-SecureString | Tee-Object .\secret.txt | ConvertTo-SecureString | Set-Variable ss_token
$creds = New-Object pscredential 'user', $ss_token
$creds
Set-GitHubAuthentication -SessionOnly ` -Credential $creds
$sstoken
$ss_token
cat .\secret.txt
Set-GitHubAuthentication -SessionOnly ` -Credential $creds
cd 'C:\Users\Kiandry Pauwels\Documents\MorePowerShellForGithub\'
Delete-GitHubRepository -RepositoryName MorePowerShellForGithub
Delete-GitHubRepository -RepositoryName MorePowerShellForGithub -OwnerName KiandryPauwelsAP
$repo=New-GitHubRepository -RepositoryName MorePowerShellForGithub
git remote add origin $repo.ssh_url
git remove
git --help
git restore
git remote add
git remote add origin
$repo.ssh_utl
$repo.ssh_url
push -u origin main
git push -u origin main
git commit -m "First PowershellForGithub commands"
git push -u origin main
Get-History
Get-History | Set-Content .\snippets.ps1
Get-Content .\snippets.ps1
git add .\snippets.ps1
git commit -m "Added extra repo commands"
git push -u origin main
Get-GitHubConfiguration
cls
Get-Help Invoke-RestMethod
'{"login": "med12", "group": "students"}' | ConvertFrom-Json
Get-GitHubUser -Current
$headershashmap='{"login": "KiandryPauwelsAP", "group":"students"}'
$headershashmap
$headershashmap | ConvertFrom-Json
Invoke-RestMethod -Headers $headers https://api.github.com
Invoke-RestMethod -Headers $headers https://api.github.com/KiandryPauwelsAP
Invoke-RestMethod -Headers $headers https://api.github.com/user
$auth = [System.Consolenvert]::ToBase64String([char[]]$creds.GetNetworkCredentail().Password)
$auth = [System.Convert]::ToBase64String([char[]]$creds.GetNetworkCredentail().Password)
$auth = [System.Convert]::ToBase64String([char[]]$creds.GetNetworkCredential().Password)
$auth
$headers = @{Authorization="Basic $auth"}
$headers
Invoke-RestMethod -Headers $headers https://api.github.com/user
$api = 'https://api.github.com'
Invoke-RestMethod -Headers $headers https://api.github.com/user 
Invoke-RestMethod -Headers $headers $api/user
Invoke-RestMethod -Headers $headers -Method Patch $api/user -Body @{company = "AP Hogeschool - Antwerpen"}
Invoke-RestMethod -Headers $headers -Method Patch $api/user -Body @{"company" = "AP Hogeschool - Antwerpen"}
Invoke-RestMethod -Headers $headers -Method Patch $api/user -Body @{"company" = "AP Hogeschool - Antwerpen"}
$body = @{"company"="AP Hogeschool - Antwerpen"}
$body
Invoke-RestMethod -Headers $headers -Method Patch $api/user -Body $body
$body | ConvertFrom-Json
$body | ConvertFrom-Json
$body | ConvertTo-Json
$jsonbody = ($body | ConvertTo-Json)
$jsonbody
Invoke-RestMethod -Headers $headers -Method Patch $api/user -Body $jsonbody
