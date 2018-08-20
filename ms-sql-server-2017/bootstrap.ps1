
param 
( 
    [string]$fqdn = "MyVM", 
    [string]$sqlinstancename = "artemisd1"

)

#$command = "C:\Temp\Test2.ps1" –Computer L014 –User User1



$command = "./ConfigureWinRM.ps1 $fqdn" 

Invoke-Expression $command

$command = "./Configure-SQL.ps1" 

Invoke-Expression $command
