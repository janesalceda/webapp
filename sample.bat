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
) else ( GOTO noscenario)

REM IF INPUT IS NOT BETWEEN 1 OR 2
:noscenario
	echo.
	echo **You are entering wrong scenario please choose between 1 or 2**
	echo.
	goto choose_scenario

REM IF SCENARIO 1 HAS CHOSEN
:scenario_one 
	REM echo you choose scenario 1
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
		call git checkout %CURBRANCH%
		start checkIns.bat
		Goto End
	
REM IF SCENARIO 2 HAS CHOSEN
:scenario_two
	echo you choose scenario 2
REM DELETING LOCAL BRANCH
	REM call git branch | grep -v `git branch --show-current` | xargs git branch -d
	set /p curbranch="Enter branch: "
	call git status 
	call git add .
	call git reset --merge
	call git status
	REM CHECKING IF BRANCH IS EXIST OR NOT
	if %CURBRANCH% == master (
		GOTO checkout_branch
	) else if %CURBRANCH% == develop (
		GOTO checkout_branch 
	) else (
		echo This '%CURBRANCH%' branch doesn't exist. Please enter correct branch.
		GOTO scenario_two
		start checkIns.bat
		Goto End
	)
:end
