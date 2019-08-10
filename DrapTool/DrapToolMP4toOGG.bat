@echo off

call C:\DrapTool\config\config.bat

:begin
cls
set mp4filelocation=%1

if %mp4filelocation%==b (
	goto :selection
) else (
	goto :mp4optimize
)

:mp4optimize

call :file_path mp4path %mp4filelocation%
call :file_name mp4filename %mp4filelocation%
call :file_ext mp4filewithoutext %mp4filelocation%

if not exist %mp4path%optimized (
    mkdir %mp4path%optimized
) else (
    echo folder optimized exists
)


%scriptpath%\library\ffmpeg.exe -n -i "%mp4filelocation%" %mp4toogg% "%mp4path%optimized\%mp4filewithoutext%.ogv"

:file_path <resultVar> <pathVar>
(
    set "%~1=%~dp2"
    exit /b
)
goto :eof

:file_name <resultVar> <pathVar>
(
    set "%~1=%~nx2"
    exit /b
)
goto :eof

:file_ext <resultVar> <pathVar>
(
    set "%~1=%~n2"
    exit /b
)
goto :eof


