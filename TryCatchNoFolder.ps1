$FolderPath = "C:\dummydir"

try {
    Get-ChildItem $FolderPath -ErrorAction Stop
}
catch [System.Management.Automation.ItemNotFoundException]{ #add error type
    New-Item $FolderPath -ItemType Directory
}
catch{
    "An unexpected error occurred"
}
