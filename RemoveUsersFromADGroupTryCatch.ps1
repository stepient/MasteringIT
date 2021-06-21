Try
{
    $AuthorizedUsers = Get-Content \\ FileServer\HRShare\UserList.txt -ErrorAction Stop
}
Catch [System.OutOfMemoryException]
{
    Restart-Computer localhost
}
Catch
{
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName
    Send-MailMessage -From ExpensesBot@MyCompany.Com -To WinAdmin@MyCompany.Com -Subject "HR File Read Failed!" -SmtpServer EXCH01.AD.MyCompany.Com -Body "We failed to read file $FailedItem. The error message was $ErrorMessage"
    Break
}
Finally
{
    $Time=Get-Date
    "This script made a read attempt at $Time" | out-file c:\logs\ExpensesScript.log -append
}