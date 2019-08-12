@echo off
:: BatchGotAdmin
::-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
::--------------------------------------

rem Create uninstall folder
@RD /S /Q "%uplocation%"
mkdir %temp%\DrapToolUpgrade
set uplocation=%temp%\DrapToolUpgrade
echo Upgrade Location created

C:\tools\wget.exe -P "%uplocation%" https://raw.githubusercontent.com/mariosemes/DrapTool/master/DrapTool/version.txt
TIMEOUT 5
findstr /vig:C:\DrapTool\version.txt %uplocation%\version.txt > %uplocation%\upgrade.txt

cls
echo Your Version:
type C:\DrapTool\version.txt
echo.
echo Current Version
type "%uplocation%\version.txt"
echo.

set fileIsBlank=0
for /f %%i in ("%uplocation%\upgrade.txt") do set fileIsBlank=%%~zi
if %fileIsBlank% gtr 0 (
	echo The app needs an update...
	TIMEOUT 5
	goto :upgrade
) else (
	echo Your app is up-to-date.
	call :deletefiles
	exit /b
)

:upgrade
rem Download new master from GIT
C:\tools\wget.exe -P "%uplocation%" https://github.com/mariosemes/DrapTool/archive/master.zip 

rem Extracting master
C:\tools\7z.exe x -o"%uplocation%" "%uplocation%\master.zip" 

rem Copy uninstall.bat from installation
xcopy /s C:\DrapTool\installation\uninstall.bat %uplocation%

call %uplocation%\uninstall.bat
call %uplocation%\DrapTool-master\install.bat
call :deletefiles
exit /b

:deletefiles
@RD /S /Q "%uplocation%"
echo Everything is done.
TIMEOUT 5
exit /b
