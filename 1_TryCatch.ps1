$FolderPath = "C:\Temp\ErrorFolder"

Try {
    Get-ChildItem $FolderPath -ErrorAction Stop
}
Catch [System.Management.Automation.ItemNotFoundException]{
    New-Item $FolderPath -ItemType Directory
}
Finally {
    Get-ChildItem $FolderPath -ErrorAction Stop
}