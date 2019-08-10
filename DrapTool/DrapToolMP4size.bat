@echo off

rem ------------------------
rem loading config if needed
rem ------------------------
call C:\DrapTool\config\config.bat


rem -----------------------
rem Getting input parameter
rem -----------------------
cls
set mp4filelocation=%1


rem -------------------------------
rem Extracting info from given path
rem -------------------------------
call :file_path mp4path %mp4filelocation%
call :file_name mp4filename %mp4filelocation%
call :file_ext filewithoutext %mp4filelocation%

if not exist %mp4path%optimized (
	mkdir %mp4path%optimized
) else (
	echo folder optimized exists
)

if not exist %mp4path%optimized\%filewithoutext%.mp4 (
	set outputname="%mp4path%optimized\%mp4filename%"
) else (
	set outputname="%mp4path%optimized\%filewithoutext%_%timestamp%.mp4"
)

rem -----------------------
rem Where the magic happens
rem -----------------------
%scriptpath%\library\ffmpeg.exe -n -i "%mp4filelocation%" -vcodec libx264 -crf %mp4quality% %outputname%


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


rem --------------------
rem Extracting file name
rem --------------------
:file_name <resultVar> <pathVar>
    (
        set "%~1=%~nx2"
        exit /b
    )
    goto :eof


rem -----------------------
rem Removing file extension
rem -----------------------
:file_ext <resultVar> <pathVar>
    (
        set "%~1=%~n2"
        exit /b
    )
    goto :eof


rem ----------------------------
rem Removing extension from file
rem ----------------------------
:file_extension <resultVar> <pathVar>
    (
        set "%~1=%~x2"
        exit /b
    )
    goto :eof



