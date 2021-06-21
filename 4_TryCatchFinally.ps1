try{
    Get-ChildItem C:\dummydir -ErrorAction Stop
}
catch{
    "An error occurred"
}
finally{
    "Finally statement"
}