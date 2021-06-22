$pscustomobject=[pscustomobject]@{
Name = "test"
EmptyStringProperty = ""
NullProperty = $null
BooleanTrueProperty = $true
BooleanFalseProperty = $false
NotEmptyArrayProperty = @(1,2,3)
EmptyArrayProperty = @()
}

$pscustomobject

($pscustomobject.psobject.properties | where {$_.value}) | select name, value | ft # false is left out

($pscustomobject.psobject.properties | where {$_.value -ne $null}) | select name, value | ft #empty string is included

($pscustomobject.psobject.properties | where {$_.value -ne $null -and $_.value -ne ""}) | select name, value | ft #false is dropped - $null and "" are after the evaluated expressions

($pscustomobject.psobject.properties | where {$null -ne $_.value -and "" -ne $_.value}) | select name, value | ft #all required properties are listed, but multiple conditions are needed

($pscustomobject.psobject.properties | where {-not [system.string]::IsNullOrEmpty($_.value)}) | select name, value | ft #all required properties are litsed, only one condition