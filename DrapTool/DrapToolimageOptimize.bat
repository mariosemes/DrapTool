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
set "filelocation=%~1"
set "quality=%~2"
set "filetype=%~3"

rem Parameter validation
if "%filelocation%"=="" (
    echo Input file or folder is missing.
    goto :eof
)
if "%quality%"=="" (
    echo Quality setting is missing.
    goto :eof
)
if "%filetype%"=="" (
    echo File type is missing.
    goto :eof
)

rem --------------------------------------------------------
rem checking what file type it is and redirecting to section
rem --------------------------------------------------------
if %filetype%==png (
	set app=%scriptpath%\library\pngquant.exe
	set settings=--nofs --force --speed 1 --quality %quality% --strip
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

		CALL :foldercheck
		copy "%filepath%\%filename%" "%filepath%\Originals\%filename%"

		%app% %settings% "%filepath%\%filename%" %outputsett% "%filepath%\%filename%"
		echo "%filepath%\%filename%" generated
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

		CALL :foldercheck
		copy "%filepath%\%filename%" "%filepath%\Originals\%filename%"

		%app% %settings% "%filepath%\%filename%" %outputsett% "%filepath%\%filename%"
		echo "%filepath%\%filename%" generated
		goto :eof

rem ------------------------------------------
rem Check if the folder exists, if not, create
rem ------------------------------------------
:foldercheck
	if not exist "%filepath%\Originals" (
		mkdir "%filepath%\Originals"
	) else (
		echo folder Originals exists
	)