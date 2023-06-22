@echo off
setlocal enabledelayedexpansion

rem Set the root directory as the directory where the script is located
set "root_directory=%~dp0"

rem Change to the root directory
cd /d "%root_directory%"

rem Extract all compressed files at the root folder
for %%f in (*.zip *.rar *.7z) do (
    rem Get the compressed file name without extension
    set "compressed_file_name=%%~nf"

    rem Create a folder with the same name as the compressed file
    mkdir "!compressed_file_name!" > nul 2>&1

    rem Extract the compressed file into the created folder
    7z x "%%f" -o"!compressed_file_name!" > nul 2>&1

    rem Rename the folder with the compressed file name
    ren "!compressed_file_name!" "%%~nf"

    rem Get the current timestamp (including milliseconds)
    for /f "tokens=1-4 delims=:. " %%a in ("%time%") do (
        set "hour=0%%a"
        set "minute=0%%b"
        set "second=0%%c"
        set "millisecond=00%%d"
    )
    set "timestamp=%date:/=-%_%hour:~-2%%minute:~-2%%second:~-2%_%millisecond:~-3%"

    rem Rename every file (except .bat files) inside the extracted folder
    for /r "%%~nf" %%x in (*) do (
        if not "%%~xx"==".bat" (
            set "file_name=%%~nx"
            set "file_extension=%%~xx"
            ren "%%x" "!file_name!_%timestamp%!file_extension!"
        )
    )
)

echo Extraction, renaming, and refresh completed.

pause
