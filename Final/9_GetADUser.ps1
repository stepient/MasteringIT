#Requires -Modules ActiveDirectory

$ADUserObj = Get-ADUser tstepien -Properties *

$ADUserObj

($ADUserObj.psobject.properties | where {$_.value}) | select name, value
($ADUserObj.psobject.properties | where {$_.value}).count # false is left out

($ADUserObj.psobject.properties | where {$_.value -ne $null}) | select name, value
($ADUserObj.psobject.properties | where {$_.value -ne $null}).count #empty string is included

($ADUserObj.psobject.properties | where {$_.value -ne $null -and $_.value -ne ""}) | select name, value
($ADUserObj.psobject.properties | where {$_.value -ne $null -and $_.value -ne ""}).count #false is dropped - $null and "" are after the evaluated expressions

($ADUserObj.psobject.properties | where {$null -ne $_.value -and "" -ne $_.value}) | select name, value
($ADUserObj.psobject.properties | where {$null -ne $_.value -and "" -ne $_.value}).count #all required properties are listed, but multiple conditions are needed

$EmptyArray=@()
$Array = 1, 2, $null, "", 'test',1

$EmptyArray
$Array

$Array -ne $null
$Array -eq 1
$EmptyArray -ne $null
$EmptyArray -eq $null
$EmptyArray -eq ""
# Both expressions below return 'false' because the comparison does not return an object and therefore the if statement always falls through:
if ($EmptyArray -eq $null) { 'true' } else { 'false' }
if ($EmptyArray -ne $null) { 'true' }else { 'false' } 

if ($null -eq $EmptyArray) { 'true' } else { 'false' }
if ($null -ne $EmptyArray) { 'true' }else { 'false' } 

($EmptyArray -ne $null) -and ($EmptyArray -ne "")
$null -and $null
$null -eq $Array
$null -eq $EmptyArray


$null -eq $array
"" -eq $array

($ADUserObj.psobject.properties | where {-not [system.string]::IsNullOrEmpty($_.value)}).count #all required properties are litsed, only one condition
($ADUserObj.psobject.properties | where {-not [system.string]::IsNullOrEmpty($_.value)}) | select name, value

$ADUserObj.AccountExpirationDate -eq $null #null value

$ADUserObj.AuthenticationPolicy -eq $null #empty array

$ADUserObj.AuthenticationPolicy -eq ""

$null -eq $ADUserObj.AuthenticationPolicy #empty array

"" -eq $ADUserObj.AuthenticationPolicy #empty array is seen as empty string in this evaluation

