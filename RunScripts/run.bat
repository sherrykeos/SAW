@echo off
setlocal enabledelayedexpansion

echo =====================================================================
echo   SOAR - Sovereign On-premise Agentic Reasoning (REAL MODE)
echo   Live Local Models: Qwen3, Qwen2.5-Coder, Qwen2.5-VL + BGE-M3 RAG
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

:: 2. Check Ollama is reachable
powershell -Command "$res = try { (Invoke-WebRequest -Uri 'http://localhost:11434/api/version' -TimeoutSec 2 -UseBasicParsing).StatusCode } catch { 0 }; if ($res -ne 200) { exit 1 }" >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] Ollama server does not appear to be running on http://localhost:11434.
    echo Please make sure Ollama is started - run: ollama serve - before using Real Mode.
    echo.
) else (
    echo [OK] Ollama is active on http://localhost:11434
)

:: 3. Check Frontend node_modules
if not exist "frontend\node_modules" (
    echo [INFO] Installing frontend dependencies...
    cd frontend
    call npm install
    cd ..
)

echo [1/3] Starting SOAR Backend (Real Mode) on http://127.0.0.1:8000 ...
start "SOAR Backend (Real Mode)" cmd /k "cd backend && set SOAR_CONFIG_PATH=config/config.yaml && .venv\Scripts\python.exe -m uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload"

echo [2/3] Starting SOAR Frontend on http://localhost:3000 ...
start "SOAR Frontend" cmd /k "cd frontend && npm run dev"

echo [3/3] Waiting for servers to initialize...
timeout /t 5 >nul

echo.
echo =====================================================================
echo   SOAR Real Mode is now running!
echo   Frontend UI : http://localhost:3000
echo   Backend API : http://127.0.0.1:8000/docs
echo =====================================================================
start http://localhost:3000
