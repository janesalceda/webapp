@echo off

set /p JIRA="Enter the JIRA Number : IPP-"
set /p TITLE="Enter the JIRA Summary : "

for /f "delims=" %%i in ('where git') do set gitpath=%%i

start "" "%gitpath%\..\..\bin\sh.exe" --login -i -c "./checkIns.bsh %JIRA% '%TITLE%'"