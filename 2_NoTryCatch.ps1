$FolderPath = "C:\Temp\ErrorFolder"

If (!(Test-Path $FolderPath)){
    New-Item $FolderPath -ItemType Directory
}

Get-ChildItem $FolderPath -ErrorAction Stop