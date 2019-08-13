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
    call :continue
    call :librarydl
    start "" https://github.com/mariosemes/DrapTool#draptool-for-windows
    exit /b
) else (
    call :copyfiles
    call :continue
    call :librarydl
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


:librarydl
C:\DrapTool\library\wget.exe https://pngquant.org/pngquant-windows.zip
C:\DrapTool\library\7z.exe x pngquant-windows.zip

copy pngquant\pngquant.exe C:\DrapTool\library\

del pngquant-windows.zip
@RD /S /Q "pngquant"



C:\DrapTool\library\wget.exe https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-4.2-win64-static.zip
C:\DrapTool\library\7z.exe x ffmpeg-4.2-win64-static.zip

copy ffmpeg-4.2-win64-static\bin\ffmpeg.exe C:\DrapTool\library\
copy ffmpeg-4.2-win64-static\bin\ffplay.exe C:\DrapTool\library\
copy ffmpeg-4.2-win64-static\bin\ffprobe.exe C:\DrapTool\library\

del ffmpeg-4.2-win64-static.zip
@RD /S /Q "ffmpeg-4.2-win64-static"



C:\DrapTool\library\wget.exe https://imagemagick.org/download/binaries/ImageMagick-7.0.8-60-portable-Q16-x64.zip
C:\DrapTool\library\7z.exe x -o"imagemagick" ImageMagick-7.0.8-60-portable-Q16-x64.zip

copy imagemagick\magick.exe C:\DrapTool\library\

del ImageMagick-7.0.8-60-portable-Q16-x64.zip
@RD /S /Q "imagemagick"

goto :eof




