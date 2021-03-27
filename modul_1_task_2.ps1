$Email = Read-Host "Skriv in e-post för testkonto"
Connect-AzureAD
$userpassword = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$userpassword.Password = "Pa55w.rd1234"


$domainName = ((Get-AzureAdTenantDetail).VerifiedDomains)[0].Name

New-AzureADUser -DisplayName 'Marcus Rosenberg' -GivenName 'Marcus' -Surname 'Rosenberg' -PasswordProfile $userpassword -UserPrincipalName "MarcusR@$domainName" -AccountEnabled $true -MailNickName 'Marcus'
New-AzureADUser -DisplayName 'Viking Johannesson' -GivenName 'Viking' -Surname 'Johannesson' -PasswordProfile $userpassword -UserPrincipalName "VikingJ@$domainName" -OtherMails $Email -AccountEnabled $true -MailNickName 'Viking'


New-AzureADGroup -Description "AZ500Admins" -DisplayName "AZ500Admins" -MailEnabled $false -SecurityEnabled $true -MailNickName "AZ500Admins"

$ObjectGroup = Get-AzureADGroup -SearchString "AZ500Admins"

$ObjectIdUser1 = Get-AzureADUser -Filter "GivenName eq 'Marcus'"
$ObjectIdUser2 = Get-AzureADUser -Filter "GivenName eq 'Viking'"


Add-AzureADGroupMember -ObjectId $ObjectGroup.ObjectId -RefObjectId $ObjectIdUser1.ObjectId
Add-AzureADGroupMember -ObjectId $ObjectGroup.ObjectId -RefObjectId $ObjectIdUser2.ObjectId
