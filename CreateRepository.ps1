﻿param($credential,$directory,$repository,$username)

<#Authenticate to user#>
Set-GitHubAuthentication -SessionOnly ` -Credential $credential
$auth = [System.Convert]::ToBase64String([char[]]$credential.GetNetworkCredential().Password)
$headers = @{Authorization="Basic $auth"}

<#Create github repo#>
$repo = New-GitHubRepository -RepositoryName $repository -Private
$reponame = $repo.full_name
Invoke-RestMethod -Headers $headers -Method PUT -Uri https://api.github.com/repos/$reponame/collaborators/dieter-ap 

<#create or check directory#>
if(!(Test-Path $directory))
{
    New-Item -ItemType Directory -Force -Path $directory
}

git init $directory
git add *
git commit -m "Initial commit"