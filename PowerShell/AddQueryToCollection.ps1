#dot-sourcing function Add-ADGroupMembershipRuleToCollection. Function code is also in the here-string at the end of the script
. "C:\Users\stepiet\Documents\WindowsPowerShell\Scripts\ConfigManager\Functions\Add-ADGroupMembershipRuleToCollection\Add-ADGroupMembershipRuleToCollection.ps1"

#Modify the script below thisline
$ConfigMgrModulePath="D:\SCCM Site\AdminConsole\bin\ConfigurationManager\ConfigurationManager.psd1"
$SiteCode="XXX"
$CollectionType="Device"
$Domain="XXX"
#Don't modify the script above this line


$ConfigManagerDrive=$SiteCode + ":\"

#Input file should contain the following columns: ApplicationName, ADGroupName
#$InputCSVPath="$PSScriptRoot\Input.csv"
$OutputCSVPath="$PSScriptRoot\Output.csv"
$LogPath="$PSScriptRoot\ScriptLog.log"

#uncomment the below section to use the latest output file as input

$outputFiles=Get-ChildItem $PSScriptRoot\Output*.csv | sort lastwritetime -Descending
$InputCSVPath=$outputFiles[0].fullname

If (Test-Path $InputCSVPath)
{
    $Input=Import-csv $InputCSVPath -Delimiter `;
}
else
{
    $message="File $InputCSVPath does not exist, exiting"
    (Get-Date).ToString() + " " + $message >> $LogPath
    $message
}

#renaming the existing Output.csv file, if exists
If (Test-Path $OutputCSVPath)
{
    $NewName="Output"+ "_" + (Get-Date).ToString('yyyy.MM.dd_hh.mm') + ".csv"
    Rename-Item -Path $OutputCSVPath -NewName $NewName
}

Import-Module $ConfigMgrModulePath
Set-Location $ConfigManagerDrive

Foreach ($Application in $Input)
{
    $Output=Add-ADGroupMembershipRuleToCollection -ADGroupName $Application.ADGroupName -CollectionName $Application.ApplicationName -CollectionType  $CollectionType -Domain $Domain

                             If (Test-Path $OutputCSVPath)
                             {
                                $Output | Export-Csv $OutputCSVPath -NoTypeInformation -Append
                             }
                             else
                             {
                                $Output | Export-Csv $OutputCSVPath -NoTypeInformation
                             }
                             $Output
                             $VariablesToClear=($Output | gm | where {$_.membertype -eq "Noteproperty"}).Name
}

