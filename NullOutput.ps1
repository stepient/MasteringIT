$VMName="VM02"

$VM = Get-AzVM -Name $VMName

#$VM=$null
#$VM=""
#$VM=$false

If ($VM){
"$VMName exists"
} else {
"$VMName does not exist"
}

