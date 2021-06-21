try
{
    $session=New-CimSession -ComputerName localhost
    Get-CimInstance win32_computersystem -CimSession $session -ErrorAction Stop
    #exit
    #throw "terminating error"
}
catch{
    "An error occurred"
}
finally{
    "Removing the CIM session"
    Remove-CimSession -CimSession $session
}

"Script continues"