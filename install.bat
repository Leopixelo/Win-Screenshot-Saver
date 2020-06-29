@echo off
set pc_user_name=%COMPUTERNAME%\%USERNAME%

SETLOCAL ENABLEDELAYEDEXPANSION
SET count=1
FOR /F "tokens=* USEBACKQ" %%i IN (`wmic useraccount where name^="%username%" get sid`) DO (
    SET var!count!=%%i
    SET /a count=!count!+1
)
ENDLOCAL & set userSID=%var2%

set path_to_exe=%userprofile%\screenshot_saver.exe

::echo %pc_user_name%
::echo %userSID%
::echo %path_to_exe%

powershell $xml_path = "\"%userprofile%\Screenshot_Saver.xml\""; $xml_temp = (Get-Content $xml_path) -replace 'pc_user_name', '%pc_user_name%'; $xml_temp = $xml_temp -replace 'userSID', '%userSID%'; $xml_temp = $xml_temp -replace 'path_to_exe', '%path_to_exe%'; $xml_temp ^| Out-File $xml_path

schtasks /Create /XML "%userprofile%\Screenshot_Saver.xml" /TN Screenshot_Saver

schtasks /Run /TN Screenshot_Saver

del "%userprofile%\Screenshot_Saver.xml"