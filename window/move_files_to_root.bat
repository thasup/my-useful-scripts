@echo off
setlocal enabledelayedexpansion

rem Set the root directory as the directory where the script is located
set "root_directory=%~dp0"

rem Change to the root directory
cd /d "%root_directory%"

rem Loop through each sub-folder
for /d %%d in (*) do (
    rem Move all files inside each sub-folder to the root directory
    move "%%d\*" "%root_directory%" > nul 2>&1
)

echo File moving completed.

pause
