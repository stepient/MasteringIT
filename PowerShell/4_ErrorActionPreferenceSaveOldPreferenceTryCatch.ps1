"Starting the script"

"Setting '`$OldErrorActionPreference' to '$ErrorActionPreference'"
$OldErrorActionPreference=$ErrorActionPreference
"`$OldErrorActionPreference: $OldErrorActionPreference"

"Setting '`$ErrorActionPreference' to 'Stop'"
$ErrorActionPreference="Stop"
"`$ErrorActionPreference: $ErrorActionPreference"

try{
    
    Get-Content C:\dummy.txt
    "This line will not be shown"
    exit
}

finally{
    "Entering the Finally block"

    "Setting '`$ErrorActionPreference' to '$OldErrorActionPreference'"
    $ErrorActionPreference=$OldErrorActionPreference #this line is executed, since it is in finally block 
    "`$ErrorActionPreference: $ErrorActionPreference"
}

"Continue"