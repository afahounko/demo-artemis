
param 
( 
    [string]$fqdn = "MyVM", 
    [string]$sqlinstancename = "artemisd1"

)

#$command = "C:\Temp\Test2.ps1" –Computer L014 –User User1

#$params = @{Flag=$true;Str=”Bagels”}
#& “.\myScript.ps1” @params

#$PSScriptRoot


$command = concat($PSScriptRoot,"\Configure-SQL.ps1") 

Invoke-Expression $command


$command = ".\ConfigureWinRM.ps1 $fqdn" 

Invoke-Expression $command


