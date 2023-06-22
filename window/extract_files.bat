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

echo Extraction completed.

pause
