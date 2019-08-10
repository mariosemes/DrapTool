@echo off

setlocal enabledelayedexpansion enableextensions

call C:\DrapTool\config\config.bat

if not exist favicon (
	mkdir favicon
) else (
	echo folder favicon exists
)

cls
set filelocation=%1

call :file_path filepath %filelocation%
call :file_extension detectext %filelocation%

if %detectext%==.jpg (
    echo its JPG
    set fileext=.jpg
    goto :converter
) else if %detectext%==.jpeg (
    echo its JPEG
    set fileext=.jpg
    goto :converter
) else if %detectext%==.png (
    echo its PNG
    set fileext=.png
    goto :converter
) else (
    echo Given image is not compatibile.
    pause
)


:converter

for /f "tokens=*" %%a in (%scriptpath%\files\apple-touch-icon.txt) do call :createapple-touch-icon %%a
for /f "tokens=*" %%b in (%scriptpath%\files\favicon.txt) do call :createfavicon %%b
for /f "tokens=*" %%c in (%scriptpath%\files\mstile.txt) do call :createmstile %%c
for /f "tokens=*" %%d in (%scriptpath%\files\ico.txt) do call :createico %%d
copy "%scriptpath%\files\code.txt" "%filepath%\favicon\code.txt"
goto :efo

:createapple-touch-icon
	set size=%*
	%scriptpath%\library\magick.exe convert "%filelocation%" -resize %size% "%filepath%\favicon\apple-touch-icon-%size%%fileext%"
	goto :eof

:createfavicon
	set size=%*
	%scriptpath%\library\magick.exe convert "%filelocation%" -resize %size% "%filepath%\favicon\favicon-%size%%fileext%"
	goto :eof

:createmstile
	set size=%*
	%scriptpath%\library\magick.exe convert "%filelocation%" -resize %size% "%filepath%\favicon\mstile-%size%%fileext%"
	goto :eof

:createico
	set size=%*
	%scriptpath%\library\magick.exe convert -background transparent "%filelocation%" -resize %size% "%filepath%\favicon\favicon.ico"
	goto :eof




:file_extension <resultVar> <pathVar>
(
    set "%~1=%~x2"
    exit /b
)
goto :eof

:file_path <resultVar> <pathVar>
(
    set "%~1=%~dp2"
    exit /b
)
goto :eof



