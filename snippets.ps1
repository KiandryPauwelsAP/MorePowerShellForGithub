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
