@echo off

rem ------------------------
rem loading config if needed
rem ------------------------
call C:\DrapTool\config\config.bat


rem -----------------------------
rem Checking if the folder exists
rem -----------------------------
if not exist favicon (
	mkdir favicon
) else (
	echo folder favicon exists
)


rem -----------------------
rem Getting input parameter
rem -----------------------
cls
set filelocation=%1
set filelocation=%filelocation:"=%

call %scriptpath%\PathExtractor.bat filepath "%filelocation%" file_path
call %scriptpath%\PathExtractor.bat fileextension "%filelocation%" file_extension

if %fileextension%==.jpg (
    echo its JPG
    set fileext=.jpg
    goto :converter
) else if %fileextension%==.jpeg (
    echo its JPEG
    set fileext=.jpg
    goto :converter
) else if %fileextension%==.png (
    echo its PNG
    set fileext=.png
    goto :converter
) else (
    echo Given image is not compatibile.
    pause
)

rem -----------------------
rem Where the magic happens
rem -----------------------
:converter

    for /f "tokens=*" %%a in (%scriptpath%\files\apple-touch-icon.txt) do call :createapple-touch-icon %%a
    for /f "tokens=*" %%b in (%scriptpath%\files\favicon.txt) do call :createfavicon %%b
    for /f "tokens=*" %%c in (%scriptpath%\files\mstile.txt) do call :createmstile %%c
    for /f "tokens=*" %%d in (%scriptpath%\files\ico.txt) do call :createico %%d
    copy "%scriptpath%\files\code.txt" "%filepath%\favicon\code.txt"
    echo favicon\code.txt generated
    goto :eof

:createapple-touch-icon
	set size=%*
	%scriptpath%\library\magick.exe convert "%filelocation%" -resize %size% "%filepath%\favicon\apple-touch-icon-%size%%fileext%"
    echo favicon\apple-touch-icon-%size%%fileext% generated
	goto :eof

:createfavicon
	set size=%*
	%scriptpath%\library\magick.exe convert "%filelocation%" -resize %size% "%filepath%\favicon\favicon-%size%%fileext%"
    echo favicon\favicon-%size%%fileext% generated
	goto :eof

:createmstile
	set size=%*
	%scriptpath%\library\magick.exe convert "%filelocation%" -resize %size% "%filepath%\favicon\mstile-%size%%fileext%"
    echo favicon\mstile-%size%%fileext% generated
	goto :eof

:createico
	set size=%*
	%scriptpath%\library\magick.exe convert -background transparent "%filelocation%" -resize %size% "%filepath%\favicon\favicon.ico"
    echo favicon\favicon.ico generated
	goto :eof