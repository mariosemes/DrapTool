@echo off

if %3==file_path (
	call :file_path %1 %2
	goto :eof
) else if %3==file_name (
	call :file_name %1 %2
	goto :eof
) else if %3==file_ext (
	call :file_ext %1 %2
	goto :eof
) else if %3==file_extension (
	call :file_extension %1 %2
	goto :eof
) else (
	echo error, command wrong.
	pause
)

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