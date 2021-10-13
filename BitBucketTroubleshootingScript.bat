@echo OFF
echo                              AUTOMATED BITBUCKET SCRIPT
echo ======================================================================================
echo Enter 1 if you are trying to execute script but you are on a different branch or if there is on staged changes but unrelated to what you want to checkin.
echo ======================================================================================

:choose_scenario
set /p scenario="Enter scenario: "
set /p curbranch="Enter branch: "
if %scenario% == 1 (
	GOTO scenario_one
)  else ( GOTO noscenario )

REM IF INPUT IS NOT BETWEEN 1 
:noscenario
	echo.
	echo **Please choose a valid scenario number. Example - "1"**
	echo.
	goto choose_scenario

:checkout_branch
	echo.
	call git checkout %CURBRANCH%
	echo You may now close this window.
	GOTO End
	
REM IF SCENARIO 1 HAS CHOSEN
:scenario_one
	echo.
	echo Deleting Local Branch . . . Please wait . . .
	for /f %%i in ('git branch') do ( 
		If NOT %%i == * (
			echo Deleting %%i branch is in progress...
			call git branch -D %%i
		)else (
		echo.
		call git checkout %CURBRANCH% 		
		)
	)
	call git status
	call git add .
	call git reset --merge
	REM call git checkout %CURBRANCH% 
	GOTO End
:end
	echo.
	cmd /k