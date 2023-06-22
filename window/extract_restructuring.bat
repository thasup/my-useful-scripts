@echo off
setlocal enabledelayedexpansion

rem Set the root directory as the directory where the script is located
set "root_directory=%~dp0"

rem Change to the root directory
cd /d "%root_directory%"

rem Extract all compressed files at the root folder
for %%f in (*.zip *.rar *.7z) do (
    rem Extract the compressed file using 7-Zip
    7z x "%%f" -o"%%~nf" > nul 2>&1
)

rem Look inside every sub-folder and move files from sub-sub-folders
for /d /r %%d in (*) do (
    pushd "%%d"

    rem Check if there is a sub-sub-folder
    for /d %%s in (*) do (
        rem Move all files under the sub-sub-folder to the sub-folder
        move "%%s\*" ".\" > nul 2>&1

        rem Remove the empty sub-sub-folder
        rd "%%s" > nul 2>&1
    )

    popd
)

rem Delete the compressed files
del *.zip *.rar *.7z > nul 2>&1

echo Extraction, folder restructuring, and file deletion completed.

pause
