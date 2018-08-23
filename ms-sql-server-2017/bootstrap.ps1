#################################################################################################################################
#  Name        : Configure-SQL.ps1                                                                                            #
#                                                                                                                               #
#  Description : Configures the SQL Server 2017 on a local machine                                                                        #
#                                                                                                                               #
#                                                           #
#################################################################################################################################

# WINRM
$shellWinRM = concat('ConfigureWinRM.ps1 ', 'MyVM' )
Invoke-Expression -Command "$shellWinRM"

# -- END WINRM

# SQL network port
$sqlPort = "15000"
# Delete an exisitng rule
netsh advfirewall firewall delete rule name="SQL Server 2017 Remote Access (TCP-In)" dir=in protocol=TCP localport=$sqlPort

# Add a new firewall rule
netsh advfirewall firewall add rule name="SQL Server 2017 Remote Access (TCP-In)" dir=in action=allow protocol=TCP localport=$sqlPort

# SQL network port
$sqlPort = "16000"
# Delete an exisitng rule
netsh advfirewall firewall delete rule name="SQL Server 2017 Remote Access (TCP-In 16000)" dir=in protocol=TCP localport=$sqlPort

# Add a new firewall rule
netsh advfirewall firewall add rule name="SQL Server 2017 Remote Access (TCP-In 16000)" dir=in action=allow protocol=TCP localport=$sqlPort




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



$installCmd0 = "net use Z: \\artemisdemo.file.core.windows.net\sqlserver /u:AZURE\artemisdemo F61uZaslNlR9Y2CJfhkX+QXswLnFxsIoaAbTp+prKHA9u7sjk9UyVM5fj7Wqwb6PW1/4ZkPvRjuFGtja+LV7aQ=="

try{
	Invoke-Expression $installCmd0
}
catch{ 
	Write-Output "Error while mounting Z drive"
}



Write-Output "Copying Installation files..."
#$installCmd = ".\setup.exe /SQLSVCPASSWORD=""$ServiceAccountPassword"" /AGTSVCPASSWORD=""$ServiceAccountPassword"" /SAPWD=""$saPassword"" /ConfigurationFile=""$configFile"""
$installCmd1 = "robocopy ""$networkSharedDir1"" ""$installDir"" /E"

#Write-Host $installCmd1
try{
	Invoke-Expression $installCmd1
	#Copy-Item $networkSharedDir1 -Destination $installDir
}
catch{ 
	Write-Output "Error while trying to copy files from : $networkSharedDir1 to $installDir"
}



Write-Warning "Copying SSMS setup files..."
$installCmd2 = "robocopy ""$networkSharedDir2"" ""$sourceDir"" /E"

Write-Host $installCmd2
try{
	Invoke-Expression $installCmd2
}
catch{ 
	Write-Warning "Error while trying to copy files from : $networkSharedDir2 to $sourceDir"
}


Write-Warning "Copying SQL Server Patch files..."
$installCmd3 = "robocopy ""$networkSharedDir3"" ""$patchDir"" /E"

Write-Host $installCmd3
try{
	Invoke-Expression $installCmd3
}
catch{ 
	Write-Warning "Error while trying to copy files from : $networkSharedDir3 to $patchDir"
}



Write-Warning "Copying SQL Server setup files..."
$installCmd4 = "robocopy ""$networkSharedDir4"" ""$sourceDir"" /E"

Write-Host $installCmd4
try{
	Invoke-Expression $installCmd4
}
catch{ 
	Write-Warning "Error while trying to copy files from : $networkSharedDir4 to $sourceDir"
}



### ------


$instanceName = "ARTEMISD1"
$workDir = "C:\infra\install"

$policyCommand = $workDir + "\02_force_ExecutionPolicy.ps1"
$svcactCommand = $workDir + "\03_create_svcsql_account.ps1"
$sqlSetupCommand = $workDir + "\04_install_SQL_Instance.ps1 -instance " + $instanceName


try{
    
    Write-Output $policyCommand
    Invoke-Expression $policyCommand
}
catch{
    Write-Output "Error while executing following Command: $policyCommand"
}
finally{
    Start-Sleep -s 15
}


try{
    
    Write-Output $policyCommand
    Invoke-Expression $policyCommand
}
catch{
    Write-Output "Error while executing following Command: $policyCommand"
}
finally{
    Start-Sleep -s 15
}


try{
    Write-Output $svcactCommand
    Invoke-Expression $svcactCommand

}
catch{
    Write-Output "Error while executing following Command: $svcactCommand"
}
finally{
    Start-Sleep -s 15
}


try{
    Write-Output $sqlSetupCommand
    Invoke-Expression -Command "$sqlSetupCommand"
}
catch{
    Write-Output "Error while executing following Command: $sqlSetupCommand"
}
