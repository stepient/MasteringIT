#Requires -Modules ActiveDirectory

Try
{
    $AuthorizedUsers = Get-Content "$PSScriptRoot\UserList.txt" -ErrorAction Stop
    $CurrentUsers=Get-ADGroupMember "Expenses Claimants"
    Foreach($User in $CurrentUsers)
    {
        If($User.name -notin $AuthorizedUsers)
        {
            Remove-ADGroupMember -Identity "Expenses Claimants" -Members $User.name -Confirm:$false
        }
    }
}
Catch [System.OutOfMemoryException]
{
    Restart-Computer localhost
}
Catch
{
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName

    "An error occurred:"
    $ErrorMessage
    $FailedItem
    #Send-MailMessage -From ExpensesBot@MyCompany.Com -To WinAdmin@MyCompany.Com -Subject "HR File Read Failed!" -SmtpServer EXCH01.AD.MyCompany.Com -Body "We failed to read file $FailedItem. The error message was $ErrorMessage"
}
Finally
{
    $Time=Get-Date
    "This script made a read attempt at $Time" | out-file $PSScriptRoot\ExpensesScript.log -append
}

