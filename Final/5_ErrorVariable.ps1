
try{
    Get-ChildItem c:\dummydir -ErrorVariable DummyDirError # -ErrorAction Stop
    "Line after the error"
}
catch {
    "An error occurred"
    #$DummyDirError
    $_.exception
}

finally{
    "This code is executed no matter what"
    }
