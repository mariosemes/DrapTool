@echo off

rem ------------------------
rem loading config if needed
rem ------------------------
call C:\DrapTool\config\config.bat


rem -----------------------
rem Getting input parameter
rem -----------------------
cls
set aepfilelocation=%1
set convert=%2

set /p composition=Type composition name: 

rem -------------------------------
rem Extracting info from given path
rem -------------------------------
call :file_path aeppath %aepfilelocation%

if not exist %aeppath%exported (
    mkdir %aeppath%exported
) else (
    echo folder exported exists
)

if %convert%=="false" (
	echo Converting disabled
	call :lossless
	goto :eof
) else (
	echo Converting enabled
	call :lossless
	call :converting
	goto :eof
)


rem --------------------------------
rem Rendering lossless avi from file
rem --------------------------------
:lossless
%aerender% -project %aepfilelocation% -comp "%composition%" -RStemplate "Best Settings" -v "ERRORS_AND_PROGRESS" -mp -output "%aeppath%exported\%composition%.avi"
goto :eof

rem ----------------------
rem Converting file to mp4
rem ----------------------
:converting
%scriptpath%\library\ffmpeg.exe -i "%aeppath%exported\%composition%.avi" -c:v libx264 -crf 19 -preset slow -c:a aac -b:a 192k -ac 2 "%aeppath%exported\%composition%.mp4"
rem ---------------------
rem Deleting old AVI file
rem ---------------------
del "%aeppath%exported\%composition%.avi"
goto :eof


rem --------------------
rem Extracting file path
rem --------------------
:file_path <resultVar> <pathVar>
    (
        cls
        set "%~1=%~dp2"
        exit /b
    )
    goto :eof

