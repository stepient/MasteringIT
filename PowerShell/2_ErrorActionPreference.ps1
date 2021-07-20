
#Get-Content C:\dummy.txt 

#"Script continues"

#Get-Process dummyprocess -ErrorAction Stop

#"Script continues"

$ErrorActionPreference="Stop"

Get-Content C:\dummy.txt

"Script continues"

Get-Process dummyprocess

"Script continues"
