$AuthorizedUsersTxt=Get-Content "$PSScriptRoot\UserList.txt"
$AuthorizedUsersCsv=Import-Csv "$PSScriptRoot\UserList.csv"
$AuthorizedUsersCsvWrongDelim=Import-Csv "$PSScriptRoot\UserListWrongDelim.csv"

$AuthorizedUsersCsv
$AuthorizedUsersCsvWrongDelim

$AuthorizedUsersCsv.username
$AuthorizedUsersCsvWrongDelim.username

$null -eq $AuthorizedUsersCsvWrongDelim.username
"tstepien" -in $AuthorizedUsersCsvWrongDelim.username

$AuthorizedUsersCsvWithDelim=Import-Csv "$PSScriptRoot\UserListWrongDelim.csv" -Delimiter ','


$CurrentUsers=Get-ADGroupMember "Expenses Claimants"
 
Foreach($User in $CurrentUsers)
{
    If($AuthorizedUsersTxt -notcontains $User)
    {
        Remove-ADGroupMember -Identity "Expenses Claimants" -User $User
    }
}