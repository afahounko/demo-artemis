
param 
( 
    [string]$fqdn = "MyVM", 
    [string]$sqlinstancename = "artemisd1"

)

#$command = "C:\Temp\Test2.ps1" –Computer L014 –User User1

#$params = @{Flag=$true;Str=”Bagels”}
#& “.\myScript.ps1” @params

#$PSScriptRoot

#& ".\Configure-SQL.ps1"

#$command = concat($PSScriptRoot,"\Configure-SQL.ps1") 
#Invoke-Expression $command


# $command = ".\ConfigureWinRM.ps1 $fqdn" 
# Invoke-Expression $command



$sourceDir = "C:\SQL_Server_2017_Developer"
$patchDir = "C:\Patches.SQL.2017"
$deploylog = "C:\infra\deploylog"
$installDir = "C:\infra\install"

$networkSharedDir1 = "Z:\SQL\install"
$networkSharedDir2 = "Z:\SQL\SSMS"
$networkSharedDir3 = "Z:\SQL\Patches.SQL.2017"
$networkSharedDir4 = "Z:\SQL\SQL_Server_2017_Developer"


#Check and create folders if not exist
if (!(Test-Path -path "$sourceDir")) #create it if not existing
{
  New-Item "$sourceDir" -type directory | out-null 
}

if (!(Test-Path -path "$patchDir")) #create it if not existing
{
  New-Item "$patchDir" -type directory | out-null 
}

if (!(Test-Path -path "$deploylog")) #create it if not existing
{
  New-Item "$deploylog" -type directory | out-null 
}

if (!(Test-Path -path "$installDir")) #create it if not existing
{
  New-Item "$installDir" -type directory | out-null 
}
