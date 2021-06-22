try{
    Get-ChildItem c:\dummydir
    "Line after the error"
}
catch{
    "An error occurred"
}
finally{
    "This code is executed no matter what"
}
