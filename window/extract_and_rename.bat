@echo off
setlocal enabledelayedexpansion

rem Set the root directory as the directory where the script is located
set "root_directory=%~dp0"

rem Change to the root directory
cd /d "%root_directory%"

rem Function to extract and rename files/folders
:ExtractAndRename
for %%f in (*.zip *.rar *.7z) do (
    set "file_name=%%~nf"
    set "file_extension=%%~xf"

    rem Create a folder with the same name as the compressed file
    if not exist "!file_name!" mkdir "!file_name!"

    rem Extract the compressed file into the created folder
    7z x -o"!file_name!" "%%f" > nul

    rem Rename the folder with the compressed file's name
    ren "!file_name!" "!file_name!_%timestamp%"

    rem Rename every file (except .bat files) inside the folder
    pushd "!file_name!_%timestamp%"
    for %%g in (*) do (
        if not "%%~xg"==".bat" (
            set "sub_file_name=%%~ng"
            set "sub_file_extension=%%~xg"
            ren "%%g" "!sub_file_name!_%timestamp%!sub_file_extension!"
        )
    )
    popd

    rem Delete the compressed file
    del "%%f" > nul
)

rem Force refresh File Explorer
taskkill /f /im explorer.exe > nul 2>&1
start explorer.exe

echo Extraction and renaming completed.

pause
