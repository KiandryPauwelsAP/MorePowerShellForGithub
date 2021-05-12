function Get-AuthHeader{   
    param (
        [Parameter(Mandatory=$true)]
        $Credential
    )
    $auth = [System.Convert]::ToBase64String([char[]]$Credential.GetNetworkCredential().Password)
    $headers = @{Authorization="Basic $auth"}
    return $headers
}

function Add-GitHubCollaborator{
    param (
    $Credential,
    $Repository,
    $Collaborator
    )
    $headers = Get-AuthHeader -Credential $Credential
    Write-Host $headers
    $url = "https://api.github.com/repos"
    $repo = $Repository.full_name
    Invoke-RestMethod -Headers $headers -Method PUT -Uri $url/$repo/collaborators/$Collaborator
}