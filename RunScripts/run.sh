#!/bin/bash
# =====================================================================
#   SOAR - Sovereign On-premise Agentic Reasoning (REAL MODE)
#   Live Local Models: Qwen3, Qwen2.5-Coder, Qwen2.5-VL + BGE-M3 RAG
# =====================================================================

set -e
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_ROOT"
if [ ! -d "backend" ] && [ -d "../backend" ]; then
    cd ..
fi

echo "====================================================================="
echo "  Starting SOAR in Real Mode (Live Ollama Inference)"
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

# 2. Check Ollama
if ! curl -s http://localhost:11434/api/version >/dev/null 2>&1; then
    echo "[WARNING] Ollama does not appear to be running on http://localhost:11434."
    echo "Make sure to start Ollama with: ollama serve"
fi

# 3. Check Frontend node_modules
if [ ! -d "frontend/node_modules" ]; then
    echo "[INFO] Installing frontend dependencies..."
    cd frontend && npm install && cd ..
fi

echo "[1/3] Starting Backend (Port 8000)..."
export SOAR_CONFIG_PATH="config/config.yaml"
cd backend
$PYTHON_CMD -m uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload &
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
