@ECHO OFF

ECHO.
ECHO Preparation des fichiers d'installation en local ...
ECHO.

md "C:\SQL_Server_2017_Developer"
md "C:\Patches.SQL.2017"
md "C:\infra\deploylog"
md "C:\infra\install"


robocopy "\\104.42.153.56\SQL\SQL_Server_2017_Developer" "C:\SQL_Server_2017_Developer" /E
robocopy "\\104.42.153.56\SQL\SSMS" "C:\SQL_Server_2017_Developer" /E
robocopy "\\104.42.153.56\SQL\Patches.SQL.2017" "C:\Patches.SQL.2017" /E
robocopy "\\104.42.153.56\SQL\install" "C:\infra\install" /E
