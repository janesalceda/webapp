@echo off

set /p CURBRANCH="Enter the name of the branch:"

for /f "delims=" %%i in ('where git') do set gitpath=%%i

start "" "%gitpath%\..\..\bin\sh.exe" --login -i -c "git checkout %CURBRANCH%"