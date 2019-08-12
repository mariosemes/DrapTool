@echo off
setlocal enabledelayedexpansion
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


:begin
if not exist C:\DrapTool\config\config.bat (
    set files="notmoved"
) else (
    set files="moved"
)

cls
echo.
echo     ____                 ______            __
echo    / __ \_________ _____/_  __/___  ____  / /
echo   / / / / ___/ __ `/ __ \/ / / __ \/ __ \/ / 
echo  / /_/ / /  / /_/ / /_/ / / / /_/ / /_/ / /  
echo /_____/_/   \__,_/ .___/_/  \____/\____/_/   
echo                 /_/                          
echo.
echo.
echo Installation packs:
echo.
echo (1) Install
echo (2) Uninstall
echo.
set /p selection=Please select installation pack: 

if %selection%==1 goto :everything
if %selection%==2 goto :uninstall

:everything

if %files%=="moved" (
    goto :continue
) else (
    call :copyfiles
    goto :continue
)


:continue
REGEDIT.EXE  /S  "C:\DrapTool\installation\install_image.reg"
REGEDIT.EXE  /S  "C:\DrapTool\installation\install_favicon.reg"
REGEDIT.EXE  /S  "C:\DrapTool\installation\install_video.reg"

call C:\DrapTool\RenderSearch.bat
call C:\DrapTool\config\config.bat

if not defined aerender (
    cls
    echo Missing aerender.exe, Plugin installed but please edit the aerender path in the config file
    REGEDIT.EXE  /S  "C:\DrapTool\installation\install_aerender.reg"
    goto :eof
) else (
    REGEDIT.EXE  /S  "C:\DrapTool\installation\install_aerender.reg"
    goto :eof
)


:uninstall
if %files%=="moved" (
    call uninstall.bat
    goto :eof
) else (
    echo DrapTool not installed or missing files on C:
    pause
    goto :begin
)


:copyfiles
mkdir C:\DrapTool
xcopy DrapTool\* C:\DrapTool\* /E
goto :eof




