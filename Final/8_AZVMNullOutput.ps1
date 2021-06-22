$VMName="VM01"

#Connect-AzAccount
Get-AzVM -Name $VMName
#Get-AzVM -Name $VMName -ResourceGroupName RG1
$VM=Get-AzVM -Name $VMName

If ($VM){
"$VMName exists"
} else {
"$VMName does not exist"
}

$VM -eq $false
$VM -eq $null
$null -eq $false


$EmptyString=""
$EmptyString -eq $null
$EmptyString -eq $false

If ($EmptyString){
    "Positive"
}else{
    "Negative"
}





