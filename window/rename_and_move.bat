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

rem Function to move all files from the sub-folder to the root folder
:MoveFilesToRoot
for /d %%d in (*) do (
    pushd "%%d"

    rem Rename and move files within the sub-folder
    for %%f in (*) do (
        if not "%%~xf"==".bat" (
            set "file_name=%%~nf"
            set "file_extension=%%~xf"
            ren "%%f" "!file_name!_%timestamp%!file_extension!"
            move "!file_name!_%timestamp%!file_extension!" "%root_directory%" > nul 2>&1
        )
    )

    popd
)

echo File renaming and moving completed.

pause
