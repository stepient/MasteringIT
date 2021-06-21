"Starting the script"

$OldErrorActionPreference=$ErrorActionPreference
$OldErrorActionPreference

$ErrorActionPreference="Stop"

Get-Content C:\dummy.txt
"Script continues"

$ErrorActionPreference=$OldErrorActionPreference