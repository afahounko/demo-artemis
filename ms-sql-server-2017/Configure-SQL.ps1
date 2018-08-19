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
