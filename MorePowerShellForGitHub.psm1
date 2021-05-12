function Get-AuthHeader{
<#
    .SYNOPSIS
    Gets the GitHub header to be used for authentication in other GitHub functions or custom functions.

    .DESCRIPTION
    Gets the GitHub header to be used for authentication in other GitHub functions or custom functions.
    Takes a existing credential previously made by the user

    .PARAMETER Credential
    Specifies the credentail to be used in the header

    .INPUTS
    None

    .OUTPUTS
    A header object to be used for authentication

    .EXAMPLE 
    $header = Get-AuthHeader -Credential $creds
#>   
    param (
        [Parameter(Mandatory=$true)]
        $Credential
    )
    $auth = [System.Convert]::ToBase64String([char[]]$Credential.GetNetworkCredential().Password)
    $headers = @{Authorization="Basic $auth"}
    return $headers
}

function Add-GitHubCollaborator{
<#
    .SYNOPSIS
    Sends a collaboration invite to a github user for a repository.

    .DESCRIPTION
    Sends a collaboration invite to a github user for a repository.
    Takes a credential for authentication, a repository object and a collaborator username.

    .PARAMETER Credential
    Specifies the credentail to be used in the header.

    .PARAMETER Repository
    Specifies the repository to send an invite for.
    This must be a Repository object gotten from Get-GitHubRepository.

    .PARAMETER Collaborator
    Specifies the username of the collaborator who will receive the invite.

    .INPUTS
    None

    .OUTPUTS
    A collaboration invite to the specified user.

    .EXAMPLE 
    Add-GitHubCollaborator -Credential $creds -Repository $repo -Collaborator "Kiandry-Pauwels"

    .EXAMPLE
    Add-GitHubCollaborator -Credential $creds -Repository $repo -Collaborator $username
#>
    param (
    $Credential,
    $Repository,
    $Collaborator
    )
    $headers = Get-AuthHeader -Credential $Credential
    $url = "https://api.github.com/repos"
    $repo = $Repository.full_name
    Invoke-RestMethod -Headers $headers -Method PUT -Uri $url/$repo/collaborators/$Collaborator
}

function Accept-RepositoryInvitations{
    param (
    $RepositoryName,
    $OwnerGroup,
    $MailDomains
    )

}