@echo off
setlocal enabledelayedexpansion

rem Set the root directory as the directory where the script is located
set "root_directory=%~dp0"

rem Change to the root directory
cd /d "%root_directory%"

rem Get the current timestamp (including milliseconds)
for /f "tokens=1-4 delims=:. " %%a in ("%time%") do (
    set "hour=0%%a"
    set "minute=0%%b"
    set "second=0%%c"
    set "millisecond=00%%d"
)
set "timestamp=%date:/=-%_%hour:~-2%%minute:~-2%%second:~-2%_%millisecond:~-3%"

rem Rename every file (except .bat files) inside the root folder
for %%f in (*) do (
    if not "%%~xf"==".bat" (
        set "file_name=%%~nf"
        set "file_extension=%%~xf"
        ren "%%f" "!file_name!_%timestamp%!file_extension!"
    )
)

echo File renaming completed.

pause
