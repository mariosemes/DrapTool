@echo off

cls

echo Please wait, searching for aerender.exe file
for /r "C:\Program Files" %%a in (*) do if "%%~nxa"=="aerender.exe" set p=%%~dpnxa
if defined p (
	echo File found its path - %p%
	echo. >> C:\DrapTool\config\config.bat
	echo. >> C:\DrapTool\config\config.bat
	echo rem Aerender.exe file location >> C:\DrapTool\config\config.bat
	echo set aerender="%p%" >> C:\DrapTool\config\config.bat
	goto :eof
) else (
	echo File not found! Trying one more time!
	TIMEOUT /T 3
	goto :secondtry
)

:secondtry
cls
echo Looking for the second time, please wait
for /r "C:\Program Files (x86)" %%a in (*) do if "%%~nxa"=="aerender.exe" set p=%%~dpnxa
if defined p (
	echo File found its path - %p%
	echo. >> C:\DrapTool\config\config.bat
	echo. >> C:\DrapTool\config\config.bat
	echo rem Aerender.exe file location >> C:\DrapTool\config\config.bat
	echo set aerender="%p%" >> C:\DrapTool\config\config.bat
	goto :eof
) else (
	echo File not found!
	goto :eof
)