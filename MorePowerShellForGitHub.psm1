function Get-AuthHeader{
<#
    .SYNOPSIS
    Gets the GitHub header to be used for authentication in other GitHub functions or custom functions.

    .DESCRIPTION
    Gets the GitHub header to be used for authentication in other GitHub functions or custom functions.
    Takes a existing credential previously made by the user and used in the authentication step.

    .PARAMETER Credential
    Specifies the credential to be used in the header

    .INPUTS
    None

    .OUTPUTS
    A header object to be used for authentication

    .EXAMPLE 
    $header = Get-AuthHeader 
#>   
    $auth = [System.Convert]::ToBase64String([char[]]$global:creds.GetNetworkCredential().Password)
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
    Add-GitHubCollaborator -Repository $repo -Collaborator "Kiandry-Pauwels"

    .EXAMPLE
    Add-GitHubCollaborator -Repository $repo -Collaborator $username

    .EXAMPLE
    New-GitHubRepository -RepositoryName MoreCode4Testing | Add-GitHubCollaborator -Collaborator "dieter-ap"
#>
    param (

    [Parameter(ValueFromPipeline=$true)]
    $Repository,
    $Collaborator
    )
    $headers = Get-AuthHeader
    $url = "https://api.github.com/repos"
    $repo = $Repository.full_name
    Invoke-RestMethod -Headers $headers -Method PUT -Uri $url/$repo/collaborators/$Collaborator
}

function Accept-RepositoryInvitations{
<#
    .SYNOPSIS
    Accepts all repository invitations with the given parameters.

    .DESCRIPTION
    Accepts all repository invitations with the given parameters.
    Takes a credential for authentication, a repository name, email domain and ownergroup.

    .PARAMETER RepositoryName
    Specifies the repository to accept invites from.
    This must be a String.

    .PARAMETER OwnerGroup
    Specifies the group found in the repository owner's bio.
    This must be a String.

    .PARAMETER MailDomains
    Specifies the maildomain the email of the repository owner must be in.
    This can be a String or a list of Strings.

    .INPUTS
    None

    .OUTPUTS
    None

    .EXAMPLE 
    Accept-RepositoryInvitations -OwnerGroup ("G_2SNB_D2","G_1SNB_D4") -RepositoryName "MorePowerShellForGitHub" -MailDomains "@student.ap.be"

#>
    param (

        $RepositoryName = "MorePowerShellForGitHub",
        $OwnerGroup = ("G_1SNB_D4","G_1SNB_D2"),
        $MailDomains = "@student.ap.be",
        $Owner = "KiandryPauwelsAP"
    )

    $headers = Get-AuthHeader
    $url = "https://api.github.com"    
    $inv = Invoke-RestMethod -Headers $headers -Method GET -Uri $url/repos/$Owner/$RepositoryName/invitations
    $invurls = $inv.url   
    $ownernames = ($inv.inviter).login
    $counter = 0

    foreach ($invurl in $invurls)
    {
        $ownername = $ownernames[$counter]
        $invownergroup = (Invoke-RestMethod -Headers $headers -Method Get -Uri $url/users/$ownername).Bio
        $owneremail = (Invoke-RestMethod -Headers $headers -Method Get -Uri $url/users/$ownername).email
        if ($owneremail.Contains($MailDomains) -and $OwnerGroup -contains $invownergroup)
        {
            Invoke-RestMethod -Headers $headers -Method PATCH -Uri $invurl
        }
        $counter = $counter + 1
    }
}

function Set-MoreGitHubAuthentication {
<#
    .SYNOPSIS
    Sets the GitHub authentication for the current Powershell session.

    .DESCRIPTION
    Sets the GitHub authentication for the current Powershell session.
    The given credentials get put into a global variable that is used for authentication to get headers in other functions.
    The authentication makes executing GitHubForPowerShell commands possible.

    .PARAMETER Credential
    Specifies the credential to be used for authentication. This must be a pscredential object.

    .INPUTS
    None

    .OUTPUTS
    A global credential variable and authentication for github commands.

    .EXAMPLE 
    Set-MoreGitHubAuthentication -Credential $creds 
#>
    param (
        $Credential
    )
    $global:creds = $Credential
    Set-GitHubAuthentication -SessionOnly ` -Credential $Credential
}