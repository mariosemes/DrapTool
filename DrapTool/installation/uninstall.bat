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

call :pngremover
cls
echo DrapTool Optimize PNG uninstalled
call :jpegremover
cls
echo DrapTool Optimize PNG uninstalled
echo DrapTool Optimize JPG uninstalled
call :mp4remover
cls
echo DrapTool Optimize PNG uninstalled
echo DrapTool Optimize JPG uninstalled
echo DrapTool Edit MP4 uninstalled
call :mp4remover2
cls
echo DrapTool Optimize PNG uninstalled
echo DrapTool Optimize JPG uninstalled
echo DrapTool Edit MP4 uninstalled
echo DrapTool ANYtoMP4 uninstalled
call :faviconremover
cls
echo DrapTool Optimize PNG uninstalled
echo DrapTool Optimize JPG uninstalled
echo DrapTool Edit MP4 uninstalled
echo DrapTool ANYtoMP4 uninstalled
echo DrapTool Favicon uninstalled
call :renderremover
cls
echo DrapTool Optimize PNG uninstalled
echo DrapTool Optimize JPG uninstalled
echo DrapTool Edit MP4 uninstalled
echo DrapTool ANYtoMP4 uninstalled
echo DrapTool Favicon uninstalled
echo DrapTool Renderer uninstalled
timeout /T 5
goto :eof

:pngremover
reg delete "HKEY_CLASSES_ROOT\*\shell\DrapTool Optimize PNG" /f
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\DrapTool Optimize all PNGs" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\pngbest" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\png10" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\png20" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\png30" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\png40" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\png50" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\png60" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\png70" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\png80" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\png90" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\png100" /f
goto :eof

:jpegremover
reg delete "HKEY_CLASSES_ROOT\*\shell\DrapTool Optimize JPG" /f
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\DrapTool Optimize all JPGs" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\jpg10" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\jpg20" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\jpg30" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\jpg40" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\jpg50" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\jpg60" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\jpg70" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\jpg80" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\jpg90" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\jpg100" /f
goto :eof

:mp4remover
reg delete "HKEY_CLASSES_ROOT\*\shell\DrapTool Edit MP4" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\optimp4" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\mp4towebm" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\mp4toogg" /f
goto :eof

:mp4remover2
reg delete "HKEY_CLASSES_ROOT\*\shell\DrapTool ANYtoMP4" /f
goto :eof

:faviconremover
reg delete "HKEY_CLASSES_ROOT\*\shell\DrapTool Favicon" /f
goto :eof

:renderremover
reg delete "HKEY_CLASSES_ROOT\*\shell\DrapTool Render" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\lossless" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\converting" /f
goto :eof



