#################################################################################################################################
#  Name        : Configure-SQL.ps1                                                                                            #
#                                                                                                                               #
#  Description : Configures the SQL Server 2017 on a local machine                                                                        #
#                                                                                                                               #
#                                                           #
#################################################################################################################################

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



$installCmd0 = "net use Z: \\artemisdemo.file.core.windows.net\sqlserver2k /u:AZURE\artemisdemo FBu0zBLu8pgJ609ybk/HF6VfjjO7KhjliYuHBjdxXsG4hS+25YQhj/JLt3PnF4gkFfD+tjOqLJxx/bh/JJDI1A=="

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
