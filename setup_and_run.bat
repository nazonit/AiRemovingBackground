@echo off
title Background Removal App - Setup and Run
color 0A

echo ==========================================================
echo    AI Background Removal Application - Complete Setup    
echo ==========================================================
echo.

REM Check if Python is installed
echo [1/6] Checking Python installation...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Error: Python is not installed or not in PATH.
    echo    Please install Python 3.6 or higher and add it to your PATH.
    echo    Download from: https://www.python.org/downloads/
    pause
    exit /b 1
)
echo ✅ Python is installed
echo.

REM Create virtual environment
echo [2/6] Creating virtual environment...
python -m venv bgremover_env >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Error: Failed to create virtual environment.
    pause
    exit /b 1
)
echo ✅ Virtual environment created
echo.

REM Activate virtual environment
echo [3/6] Activating virtual environment...
call bgremover_env\Scripts\activate.bat >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Error: Failed to activate virtual environment.
    pause
    exit /b 1
)
echo ✅ Virtual environment activated
echo.

REM Upgrade pip
echo [4/6] Upgrading pip...
python -m pip install --upgrade pip >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Error: Failed to upgrade pip.
    pause
    exit /b 1
)
echo ✅ Pip upgraded
echo.

REM Install dependencies
echo [5/6] Installing dependencies...
pip install rembg onnxruntime pillow >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Error: Failed to install dependencies.
    echo    Make sure you have an internet connection and try again.
    pause
    exit /b 1
)
echo ✅ Dependencies installed
echo.

REM Verify installation
echo [6/6] Verifying installation...
python -c "import rembg, onnxruntime, PIL; print('✅ All dependencies imported successfully')" >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Error: Failed to verify dependencies.
    pause
    exit /b 1
)
echo ✅ Installation verified
echo.

echo ==========================================================
echo    Setup completed successfully!                            
echo ==========================================================
echo.

REM Ask user if they want to run the application
echo Do you want to run the application now? (Y/N)
set /p choice="Enter your choice: "
if /i "%choice%"=="Y" goto run_app
if /i "%choice%"=="y" goto run_app
echo Setup completed. You can run the application later using run.bat
pause
exit /b 0

:run_app
echo.
echo Starting the Background Removal Application...
echo.
python main.py
echo.
echo Application closed.
pause