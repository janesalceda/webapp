
@echo off
echo                              FIXING BITBUCKET ISSUES
echo ======================================================================================
echo Enter 1 if you are trying to execute script but you are on a different branch.
echo Enter 2 if there is on staged changes but unrelated to what you want to checkin.
echo ======================================================================================

:choose_scenario
set /p scenario="Enter scenario(1/2): "
if %scenario% == 1 (
	GOTO scenario_one
) else if %scenario% == 2 ( 
	GOTO scenario_two
) else ( GOTO noscenario )

REM IF INPUT IS NOT BETWEEN 1 OR 2
:noscenario
	echo.
	echo **You are entering wrong scenario please choose between 1 or 2**
	echo.
	goto choose_scenario

REM IF SCENARIO 1 HAS CHOSEN
:scenario_one 
	set /p curbranch="Enter branch: "
	REM CHECKING IF BRANCH IS EXIST OR NOT
	if %CURBRANCH% == master (
		GOTO checkout_branch
	) else if %CURBRANCH% == develop (
		GOTO checkout_branch 
	) else (
		echo This '%CURBRANCH%' branch doesn't exist. Please enter correct branch.
		GOTO scenario_one
	)
	
:checkout_branch
	echo.
	call git checkout %CURBRANCH%
	Goto End
	
REM IF SCENARIO 2 HAS CHOSEN
:scenario_two
	echo.
	call git status 
	echo Deleting Local Branch . . . Please wait . . .
	for /f %%i in ('git branch') do ( 
		If NOT %%i == * (
			echo Deleting %%i branch is in progress...
		)else (echo.)
	)
<<<<<<< HEAD
	if errorlevel 1 goto error_echo
=======
>>>>>>> 8b15f65ac3f22c388a9bee0807707530c09657be
	call git add .
	call git reset --merge
	echo.
	call git status 

	for /f "delims=" %%i in ('where git') do set gitpath=%%i
	start "" "%gitpath%\..\..\bin\sh.exe" --login -i -c "git checkout master"
	Goto End
:error_echo
	cmd /k
:end
	echo.
	cmd /k