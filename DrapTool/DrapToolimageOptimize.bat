@echo off
SETLOCAL enabledelayedexpansion

rem ------------------------
rem loading config if needed
rem ------------------------
call C:\DrapTool\config\config.bat

rem ---------------------------------
rem setting variables from parameters
rem ---------------------------------
cls
set filelocation=%1
set filelocation=%filelocation:"=%
set quality=%2
set quality=%quality:"=%
set filetype=%3
set filetype=%filetype:"=%

rem --------------------------------------------------------
rem checking what file type it is and redirecting to section
rem --------------------------------------------------------
if %filetype%==png (
	set app=%scriptpath%\library\pngquant.exe
	set settings=--nofs --speed 1 --quality %quality% --strip
	set outputsett=--output
	goto :optimization
) else if %filetype%==jpg (
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

	if exist "%~1" (2>nul pushd "%~1" && (goto :batch) || goto :single ) else set "type=INVALID"

	:single

		call %scriptpath%\PathExtractor.bat filepath "%filelocation%" file_path
		call %scriptpath%\PathExtractor.bat filename "%filelocation%" file_name
		call %scriptpath%\PathExtractor.bat filewithoutextension "%filelocation%" file_ext

		%app% %settings% "%filepath%\%filename%" %outputsett% "%filepath%\%filewithoutextension%-%quality%.%filetype%"
		echo %filepath%\%filewithoutextension%-%quality%.%filetype% generated
		goto :eof

	:batch

		CALL :foldercheck
		for %%a in ("%filelocation%\*.%filetype%") do call :process %%a
		goto :eof

	:process
		set name="%*"

		call %scriptpath%\PathExtractor.bat filepath %name% file_path
		call %scriptpath%\PathExtractor.bat filename %name% file_name
		call %scriptpath%\PathExtractor.bat filewithoutextension %name% file_ext

		%app% %settings% %name% %outputsett% "%filelocation%\optimized %filetype% q%quality%\%filename%"
		echo optimized %filetype% q%quality%\%filename% generated
		goto :eof

rem ------------------------------------------
rem Check if the folder exists, if not, create
rem ------------------------------------------
:foldercheck
	if not exist "%filelocation%\optimized %filetype% q%quality%" (
		mkdir "%filelocation%\optimized %filetype% q%quality%"
	) else (
		echo folder optimized-%quality% exists
	)