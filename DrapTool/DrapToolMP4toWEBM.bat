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
call :file_ext mp4filewithoutext %mp4filelocation%

if not exist %mp4path%optimized (
    mkdir %mp4path%optimized
) else (
    echo folder optimized exists
)


rem -----------------------
rem Where the magic happens
rem -----------------------
%scriptpath%\library\ffmpeg.exe -n -i "%mp4filelocation%" %mp4towebm% "%mp4path%optimized\%mp4filewithoutext%.webm"


rem --------------------
rem Extracting file path
rem --------------------
:file_path <resultVar> <pathVar>
    (
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


