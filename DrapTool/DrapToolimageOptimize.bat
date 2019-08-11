@echo off
rem setlocal enabledelayedexpansion enableextensions

rem ------------------------
rem loading config if needed
rem ------------------------
call C:\DrapTool\config\config.bat

rem ---------------------------------
rem setting variables from parameters
rem ---------------------------------
cls
set filelocation=%1
set quality=%2
set filetype=%3

rem --------------------------------------------------------
rem checking what file type it is and redirecting to section
rem --------------------------------------------------------
if %filetype%=="png" (
	set app=%scriptpath%\library\pngquant.exe
	set settings=--force --verbose --quality=%quality%
	set outputsett=--output
	goto :optimization
) else if %filetype%=="jpg" (
	set app=%scriptpath%\library\magick.exe
	set settings=-quality %quality%
	set outputsett=
	goto :optimization
) else (
	echo Something went wrong. Try again...
	TIMEOUT /T 10
)

rem -----------------------
rem where the magic happens
rem -----------------------
:optimization

	call %scriptpath%\PathExtractor.bat filepath %filelocation% file_path
	call %scriptpath%\PathExtractor.bat filename %filelocation% file_name
	call %scriptpath%\PathExtractor.bat filewithoutextension %filelocation% file_ext

	if exist "%~1" (2>nul pushd "%~1" && (goto :batch) || goto :single ) else set "type=INVALID"

	:single

		%app% %settings% "%filepath%\%filename%" %outputsett% "%filepath%\%filewithoutextension%-%quality%.%filetype%"
		echo %name% optimized
		goto :eof

	:batch

		cd %filelocation%
		CALL :foldercheck
		for %%a in (*.%filetype%) do call :process %%a
		goto :eof

	:process

		set name=%*

		%app% %settings% "%filelocation%\%name%" %outputsett% "%filelocation%\optimized %filetype% q%quality%\%name%"
		echo %name% optimized
		goto :eof

rem ------------------------------------------
rem Check if the folder exists, if not, create
rem ------------------------------------------
:foldercheck
	if not exist "optimized %filetype% q%quality%" (
		mkdir "optimized %filetype% q%quality%"
	) else (
		echo folder optimized-%quality% exists
	)