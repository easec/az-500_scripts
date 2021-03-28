
Connect-AzAccount
$Email = Read-Host "Skriv in e-post för testkonto"

$userpassword = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$userpassword.Password = "Pa55w.rd1234"


$domainName = ((Get-AzureAdTenantDetail).VerifiedDomains)[0].Name
  
New-AzADUser -DisplayName 'Marcus Rosenberg' -GivenName 'Marcus' -Surname 'Rosenberg' -PasswordProfile $userpassword -UserPrincipalName "MarcusR@$domainName" -AccountEnabled $true -MailNickName 'Marcus'
New-AzADUser -DisplayName 'Viking Johannesson' -GivenName 'Viking' -Surname 'Johannesson' -PasswordProfile $userpassword -UserPrincipalName "VikingJ@$domainName" -OtherMails $Email -AccountEnabled $true -MailNickName 'Viking'


New-AzADGroup -Description "AZ500Admins" -DisplayName "AZ500Admins" -MailEnabled $false -SecurityEnabled $true -MailNickName "AZ500Admins"

$ObjectGroup = Get-AzureADGroup -SearchString "AZ500Admins"

$ObjectIdUser1 = Get-AzADUser -Filter "GivenName eq 'Marcus'"
$ObjectIdUser2 = Get-AzADUser -Filter "GivenName eq 'Viking'"


Add-AzADGroupMember -ObjectId $ObjectGroup.ObjectId -RefObjectId $ObjectIdUser1.ObjectId
Add-AzADGroupMember -ObjectId $ObjectGroup.ObjectId -RefObjectId $ObjectIdUser2.ObjectId
