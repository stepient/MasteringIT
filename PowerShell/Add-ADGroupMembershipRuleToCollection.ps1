Function Add-ADGroupMembershipRuleToCollection
{
[cmdletbinding()]
Param(
[Parameter(Mandatory=$true)]
$CollectionName,
[Parameter(Mandatory=$true)]
$ADGroupName,
[Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("User", "Device")]
$CollectionType,
[Parameter(Mandatory=$true)]
$Domain
)
#end param

$QueryExpression=@"
select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client 
from SMS_R_System 
where SMS_R_System.SecurityGroupName = "$Domain\\$ADGroupName"
"@
$RuleName="ADGroupMembership"

Try
{
    $ADGroup=Get-ADGroup $ADGroupName
    $Collection=Get-CMCollection -Name $CollectionName -CollectionType $CollectionType
    If($Collection -eq $null)
    {
        #collection does not exist
        $message="$CollectionName does not exist"
        Write-Verbose $message
        [bool]$QueryCreated=$false
        $Reason="Collection does not exist"  
    }
    else
    {
        
        Switch($CollectionType)
        {
            "Device" {
                            $message="Creating new membership rule. Collection: $ApplicationName; AD Group: $ADGroupName; rule name: $RuleName; Collectiontype: $CollectionType"
                            Write-Verbose $message
                            Add-CMDeviceCollectionQueryMembershipRule -CollectionName $CollectionName -RuleName $RuleName -QueryExpression $QueryExpression
                            [bool]$QueryCreated=$true
                            $message="Membership rule $RuleName created for collection $CollectionName"
                            Write-Verbose $message
                     }
            "User"   {
                            $message="Creating new membership rule. Collection: $ApplicationName; AD Group: $ADGroupName; rule name: $RuleName; Collectiontype: $CollectionType"
                            Write-Verbose $message
                            Add-CMDeviceCollectionQueryMembershipRule -CollectionName $CollectionName -RuleName $RuleName -QueryExpression $QueryExpression
                            [bool]$QueryCreated=$true
                            $message="Membership rule $RuleName created for collection $CollectionName"
                            Write-Verbose $message
            
                     }
        }
        
    }
}
Catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
{
    #AD group does not exist
    $message="AD group $ADGroupName does not exist"
    Write-Verbose $message
    [bool]$QueryCreated=$false
    $Reason="AD group does not exist"
}

Catch [System.Management.Automation.ParameterBindingException]
{
    #No AD group name passed to the ADGroupName parameter
    $message="The variable '`$ADGroupName' is null"
    Write-Verbose $message
    [bool]$QueryCreated=$false
    $Reason="No AD group name provided"
}

Catch [System.Management.Automation.ItemNotFoundException]
{
    #collection does not exist
    $message="$CollectionName does not exist"
    Write-Verbose $message
    [bool]$QueryCreated=$false
    $Reason="Collection does not exist"
}
Catch
{
    $message="Failed to create rule"
    Write-Verbose $message
    $Error[0]
    [bool]$QueryCreated=$false
    $Reason="Failed to add query"
}
Finally
{
   $output=[pscustomobject]@{
                                #modify property and variable names
                                CollectionName=$CollectionName
                                ADGroupName=$ADGroupName
                                QueryCreated=$QueryCreated
                                Reason=$Reason
                             } 
                             $output
}


}