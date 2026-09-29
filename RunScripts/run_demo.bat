@echo off
setlocal enabledelayedexpansion

echo =====================================================================
echo   SOAR - Sovereign On-premise Agentic Reasoning (Demo Mode)
echo   Starting with Zero GPU, Zero Model Downloads, Zero Ollama
echo =====================================================================
echo.

cd /d "%~dp0"
if not exist "backend" if exist "..\backend" cd ..

:: 1. Check Python Venv
if not exist "backend\.venv\Scripts\python.exe" (
    echo [ERROR] Backend virtual environment not found at backend\.venv
    echo Current directory: %CD%
    echo Please make sure backend\.venv exists.
    pause
    exit /b 1
)

:: 2. Check Frontend node_modules
if not exist "frontend\node_modules" (
    echo [INFO] Installing frontend dependencies...
    cd frontend
    call npm install
    cd ..
)

echo [1/3] Starting SOAR Backend in Demo Mode on http://127.0.0.1:8000 ...
start "SOAR Backend (Demo Mode)" cmd /k "cd backend && set SOAR_CONFIG_PATH=config/config.demo.yaml && .venv\Scripts\python.exe -m uvicorn app.main:app --host 127.0.0.1 --port 8000"

echo [2/3] Starting SOAR Frontend on http://localhost:3000 ...
start "SOAR Frontend" cmd /k "cd frontend && npm run dev"

echo [3/3] Waiting for servers to initialize...
timeout /t 5 >nul

echo.
echo =====================================================================
echo   SOAR is now running!
echo   Frontend UI : http://localhost:3000
echo   Backend API : http://127.0.0.1:8000/docs
echo =====================================================================
start http://localhost:3000
