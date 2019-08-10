@echo off

call C:\DrapTool\config\config.bat


:begin
cls
set ANYfilelocation=%1

:ANYoptimize

call :file_path ANYpath %ANYfilelocation%
call :file_name ANYfilename %ANYfilelocation%
call :file_ext ANYfilewithoutext %ANYfilelocation%

if not exist %ANYpath%converted (
    mkdir %ANYpath%converted
) else (
    echo folder converted exists
)

call :file_extension ANYextension %ANYfilelocation%

if %ANYextension%==.avi (
    echo its AVI
    set ENCODER=%avitomp4%
    goto :converter
) else if %ANYextension%==.mov (
    echo its MOV
    set ENCODER=%movtomp4%
    goto :converter
) else if %ANYextension%==.mkv (
    echo its mkv
    set ENCODER=%mkvtomp4%
    goto :converter
) else if %ANYextension%==.mp4 (
    echo its already mp4, try to optimize it.
    pause
) else (
    echo Given container is not compatibile.
    pause
)

:converter
    %scriptpath%\library\ffmpeg.exe -n -i "%ANYfilelocation%" %ENCODER% "%ANYpath%\converted\%ANYfilewithoutext%.mp4"
    goto :eof


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

:file_extension <resultVar> <pathVar>
    (
        set "%~1=%~x2"
        exit /b
    )
    goto :eof


