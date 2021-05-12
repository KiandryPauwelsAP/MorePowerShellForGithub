function Get-AuthHeader{   
    param (
        $Credential
    )
    $auth = [System.Convert]::ToBase64String([char[]]$Credential.GetNetworkCredential().Password)
    $headers = @{Authorization="Basic $auth"}
    Invoke-RestMethod -Headers $headers https://api.github.com/user
}