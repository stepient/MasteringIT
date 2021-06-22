#Requires -Modules ActiveDirectory

$AuthorizedUsers=Get-Content "$PSScriptRoot\UserList.txt"
$CurrentUsers=Get-ADGroupMember "Expenses Claimants"
 
Foreach($User in $CurrentUsers)
{
    If($User.name -notin $AuthorizedUsers)
    {
        Remove-ADGroupMember -Identity "Expenses Claimants" -Members $User.name -Confirm:$false
    }
}