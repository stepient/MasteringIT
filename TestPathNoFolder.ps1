$folderPath = "C:\dummydir"

If (Test-Path $folderPath){
    
    Get-ChildItem $folderPath

}else{

    New-Item $folderPath -ItemType Directory

}
