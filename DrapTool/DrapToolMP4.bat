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
set filelocation=%filelocation:"=%
set filetype=%2
set filetype=%filetype:"=%
set crf=%3
set crf=%crf:"=%

rem -------------------------------
rem Extracting info from given path
rem -------------------------------
call %scriptpath%\PathExtractor.bat filepath "%filelocation%" file_path
call %scriptpath%\PathExtractor.bat filename "%filelocation%" file_name
call %scriptpath%\PathExtractor.bat filewithoutextension "%filelocation%" file_ext
call %scriptpath%\PathExtractor.bat fileextension "%filelocation%" file_extension


rem ---------------------------------------
rem Check for file type and send to process
rem ---------------------------------------
if %filetype%==mp4 (
	set outputfolder=optimized
	call :foldercheck
	call :fileexistscheck
	call :mp4optimize
	goto :eof
) else if %filetype%==ogg (
	set outputfolder=converted
	set ENCODER=%mp4toogg%
	call :foldercheck
	set fileextension=.ogv
	call :fileexistscheck
	call :webmoggconvert
	goto :eof
) else if %filetype%==webm (
	set outputfolder=converted
	set ENCODER=%mp4towebm%
	call :foldercheck
	set fileextension=.webm
	call :fileexistscheck
	call :webmoggconvert
	goto :eof
) else if %filetype%==any (
	call :anyfilechecker
	goto :eof
) else (
	echo Given container is not compatibile.
    pause
    goto :eof
)

:anyfilechecker
if %fileextension%==.avi (
	set outputfolder=converted
	set ENCODER=%avitomp4%
	call :foldercheck
	set fileextension=.mp4
	call :fileexistscheck
	call :anyfileconvert
	goto :eof
) else if %fileextension%==.mov (
	set outputfolder=converted
	set ENCODER=%movtomp4%
	call :foldercheck
	set fileextension=.mp4
	call :fileexistscheck
	call :anyfileconvert
	goto :eof
) else if %fileextension%==.mkv (
	set outputfolder=converted
	set ENCODER=%mkvtomp4%
	call :foldercheck
	set fileextension=.mp4
	call :fileexistscheck
	call :anyfileconvert
	goto :eof
) else (
	echo Given container is not compatibile.
    pause
    goto :eof
)
goto :eof



:foldercheck
if not exist "%filepath%%outputfolder%" (
	mkdir "%filepath%%outputfolder%"
) else (
	echo folder "%outputfolder%" exists
)
goto :eof


:fileexistscheck
if not exist "%filepath%%outputfolder%\%filewithoutextension%%fileextension%" (
	set outputname="%filepath%%outputfolder%\%filename%"
	goto :eof
) else (
	set /A counter=1
	call :filecounter
	goto :eof
)


:filecounter
if not exist "%filepath%%outputfolder%\%filewithoutextension%_(%counter%)%fileextension%" (
	set outputname="%filepath%%outputfolder%\%filewithoutextension%_(%counter%)%fileextension%"
	goto :eof
) else (
	set /a counter+=1
	goto :filecounter
)


rem -----------------------
rem Where the magic happens
rem -----------------------
:mp4optimize
%scriptpath%\library\ffmpeg.exe -n -i "%filelocation%" -vcodec libx264 -crf %crf% -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" %outputname%
goto :eof



rem -----------------------
rem Where the magic happens
rem -----------------------
:webmoggconvert
%scriptpath%\library\ffmpeg.exe -n -i "%filelocation%" %ENCODER% -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" %outputname%
goto :eof


rem -----------------------
rem Where the magic happens
rem -----------------------
:anyfileconvert
%scriptpath%\library\ffmpeg.exe -n -i "%filelocation%" %ENCODER% -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" "%filepath%%outputfolder%\%filewithoutextension%%fileextension%"
goto :eof