@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"
title Janffer 3 - setup and self-check
color 0B
echo =========================================
echo  JANFFER 3 - WINDOWS INSTALLER
echo =========================================
echo.
set "PY=python"
where py >nul 2>nul
if not errorlevel 1 (
 py -3 -c "import sys; assert sys.version_info >= (3,10)" >nul 2>nul
 if not errorlevel 1 set "PY=py -3"
)
%PY% -c "import sys; assert sys.version_info >= (3,10), 'Python 3.10+ required'" >nul 2>nul
if errorlevel 1 goto missing
%PY% -m unittest discover -s tests -p "test_v3_*.py" -q
if errorlevel 1 (
 echo Janffer self-check failed. Please send us a screenshot of this window.
 pause
 exit /b 1
)
echo.
echo Core checks passed. Launching Janffer...
call "%~dp0START_JANFFER.bat"
exit /b 0
:missing
echo Python 3.10 or newer is required. Janffer cannot safely run without it.
echo Install it from https://www.python.org/downloads/windows/
echo Select Add python.exe to PATH, then reopen INSTALL_WINDOWS.bat.
pause
exit /b 1
