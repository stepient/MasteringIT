$AuthorizedUsers=Get-Content "$PSScriptRoot\UserList.txt"
$CurrentUsers=Get-ADGroupMember "Expenses Claimants"
 
Foreach($User in $CurrentUsers)
{
    If($AuthorizedUsers -notcontains $User)
    {
        Remove-ADGroupMember -Identity "Expenses Claimants" -User $User
    }
}