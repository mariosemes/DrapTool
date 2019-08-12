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


:everything
if %files%=="moved" (
    goto :continue
    start "" https://github.com/mariosemes/DrapTool#draptool-for-windows
    exit /b
) else (
    call :copyfiles
    call :continue
    start "" https://github.com/mariosemes/DrapTool#draptool-for-windows
    exit /b
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


:copyfiles
mkdir C:\DrapTool
xcopy DrapTool\* C:\DrapTool\* /E
goto :eof




