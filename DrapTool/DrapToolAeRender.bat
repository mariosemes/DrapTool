@echo off

rem ------------------------
rem loading config if needed
rem ------------------------
call C:\DrapTool\config\config.bat


rem -----------------------
rem Getting input parameter
rem -----------------------
cls
set filelocation=%1
set convert=%2

set /p composition=Type composition name: 

rem -------------------------------
rem Extracting info from given path
rem -------------------------------
call %scriptpath%\PathExtractor.bat filepath %filelocation% file_path

rem -----------------------------------------
rem Checking if folder exists, if not, create
rem -----------------------------------------
if not exist %filepath%exported (
    mkdir %filepath%exported
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
%aerender% -project %filelocation% -comp "%composition%" -RStemplate "Best Settings" -OMtemplate "Lossless" -v "ERRORS_AND_PROGRESS" -mp -output "%filepath%exported\%composition%.avi"
goto :eof

rem ----------------------
rem Converting file to mp4
rem ----------------------
:converting
%scriptpath%\library\ffmpeg.exe -i "%filepath%exported\%composition%.avi" -c:v libx264 -crf 19 -preset slow -c:a aac -b:a 192k -ac 2 "%filepath%exported\%composition%.mp4"
rem ---------------------
rem Deleting old AVI file
rem ---------------------
del "%filepath%exported\%composition%.avi"
goto :eof

