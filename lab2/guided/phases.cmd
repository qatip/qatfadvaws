@echo off
setlocal ENABLEDELAYEDEXPANSION

set "WORK_DIR=%~dp0"
set "SOL_ROOT=%WORK_DIR%..\..\lab2\phases"

echo Working directory : %WORK_DIR%
echo Solutions directory: %SOL_ROOT%
echo.

:MENU
echo ========================================
echo   Terraform Lab 2 - Phase Switcher
echo ========================================
echo  0 Chaos (Unpredictable behaviour)
echo  1 Structure (Readable configuration)
echo  2 Determinism (Stable, predictable outputs)
echo  3 Visibility (Detecting problems)
echo  4 Enforcement (Preventing problems)
echo  X Exit
echo.
set /p CHOICE=Select phase to load:

if "%CHOICE%"=="0" call :COPY_PHASE "phase0" & call :DEL_LOCALS & goto END
if "%CHOICE%"=="1" call :COPY_PHASE "phase1" & goto END
if "%CHOICE%"=="2" call :COPY_PHASE "phase2" & goto END
if "%CHOICE%"=="3" call :COPY_PHASE "phase3" & goto END
if "%CHOICE%"=="4" call :COPY_PHASE "phase4" & goto END
if /I "%CHOICE%"=="X" goto END

echo Invalid choice...
echo.
goto MENU

:COPY_PHASE
set "PHASE_NAME=%~1"
set "SRC=%SOL_ROOT%\%PHASE_NAME%"

if not exist "%SRC%" (
  echo.
  echo Phase folder "%SRC%" not found.
  echo.
  goto :eof
)

echo.
echo Applying %PHASE_NAME% to "%WORK_DIR%" ...

for %%F in (main.tf locals.tf variables.tf outputs.tf terraform.tfvars) do (
  if exist "%SRC%\%%F" (
    copy /Y "%SRC%\%%F" "%WORK_DIR%\%%F.new" >nul
    move /Y "%WORK_DIR%\%%F.new" "%WORK_DIR%\%%F" >nul
  )
)

echo Done. Your working folder now reflects "%PHASE_NAME%".
echo.
goto :eof

:DEL_LOCALS
if exist "%WORK_DIR%\locals.tf" (
  del "%WORK_DIR%\locals.tf" >nul
)
goto :eof

:END
echo Bye!
endlocal
exit /b 0