try
{
    $session=New-CimSession -ComputerName localhost
    Get-CimInstance win32_computersys -CimSession $session -ErrorAction Stop #change class name
}
catch{
    "An error occurred"
    #exit
    throw "Terminating error occurred"
}
finally{
    "Removing the CIM session"
    Remove-CimSession -CimSession $session
}

"Script continues"