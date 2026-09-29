#!/bin/bash
# =====================================================================
#   SAW - Sovereign Agentic AI Workbench (Demo Mode)
#   Starting with Zero GPU, Zero Model Downloads, Zero Ollama
# =====================================================================

set -e
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_ROOT"
if [ ! -d "backend" ] && [ -d "../backend" ]; then
    cd ..
fi

echo "====================================================================="
echo "  Starting SAW in Instant Demo Mode (Zero Downloads, Zero Ollama)"
echo "====================================================================="

# 1. Check Python Venv
PYTHON_CMD="backend/.venv/bin/python"
if [ -f "backend/.venv/Scripts/python.exe" ]; then
    PYTHON_CMD="backend/.venv/Scripts/python.exe"
fi

if [ ! -f "$PYTHON_CMD" ]; then
    echo "[ERROR] Backend virtual environment not found in backend/.venv"
    echo "Current directory: $(pwd)"
    exit 1
fi

# 2. Check Frontend node_modules
if [ ! -d "frontend/node_modules" ]; then
    echo "[INFO] Installing frontend dependencies..."
    cd frontend && npm install && cd ..
fi

echo "[1/3] Starting Backend (Port 8000)..."
export SOAR_CONFIG_PATH="config/config.demo.yaml"
cd backend
$PYTHON_CMD -m uvicorn app.main:app --host 127.0.0.1 --port 8000 &
BACKEND_PID=$!
cd ..

echo "[2/3] Starting Frontend (Port 3000)..."
cd frontend
npm run dev &
FRONTEND_PID=$!
cd ..

trap "kill $BACKEND_PID $FRONTEND_PID 2>/dev/null" EXIT

echo "[3/3] System online!"
echo "  Frontend UI : http://localhost:3000"
echo "  Backend API : http://127.0.0.1:8000/docs"
echo "Press Ctrl+C to stop both servers."

wait
