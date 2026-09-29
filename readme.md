<div align="center">

# SAW — Sovereign Agentic AI Workbench

### On-Premise, Air-Gapped Intelligence Engine for Mission-Critical Industrial Infrastructure

[![Sovereignty: 100% Air-Gapped](https://img.shields.io/badge/Sovereignty-100%25%20Air--Gapped-2ea44f?style=for-the-badge&logo=shield)](docs/SAW-Doc.md)
[![Model Pool: Qwen3 / Coder / VL](https://img.shields.io/badge/Model%20Pool-Qwen3%20%7C%20Coder%20%7C%20VL-8a2be2?style=for-the-badge)](docs/configuration.md)
[![RAG: BGE--M3 + ChromaDB](https://img.shields.io/badge/RAG-BGE--M3%20%2B%20ChromaDB-blue?style=for-the-badge)](docs/SAW-Doc.md)
[![Backend: FastAPI](https://img.shields.io/badge/Backend-FastAPI%20%2B%20Python-009688?style=for-the-badge&logo=fastapi)](docs/api.md)
[![Frontend: Next.js 16 + React 19](https://img.shields.io/badge/Frontend-Next.js%2016%20%7C%20React%2019-black?style=for-the-badge&logo=next.js)](frontend/README.md)
[![License: Proprietary / Sovereign](https://img.shields.io/badge/Compliance-PSU%20%26%20Defence%20Ready-critical?style=for-the-badge)](#-security-governance--air-gap-audit)

<br />

<p align="center">
  <img src="docs/SAW%20product%20image.png" alt="SAW — Sovereign Agentic AI Workbench Interface" width="100%" style="border-radius: 12px; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);" />
</p>

<br />

**Sovereign Local Execution &bull; Zero External Network Exposure &bull; Adaptive Multi-Model Dynamic Dispatch &bull; Real-Time Execution DAG**

[Full Technical Report (SAW-Doc.md)](docs/SAW-Doc.md) • [REST API Reference](docs/api.md) • [Configuration Guide](docs/configuration.md) • [Quick Start](#-quick-start)

---

</div>

## 📌 Executive Summary

**SAW (Sovereign Agentic AI Workbench)** is an enterprise-grade, self-hosted, air-gapped AI operations platform engineered specifically for organizations where sensitive telemetry, proprietary drawings, operational data, and source code **can never leave the physical premises**.

Designed for high-consequence environments—including **oil & gas refineries, nuclear and thermal power stations, petrochemical complexes, public sector undertakings (PSUs), defence establishments, and critical government infrastructure**—SAW delivers a modern, Claude/Codex-caliber agentic workspace entirely on local infrastructure.

Unlike fragile wrapper apps or rigid single-model chat interfaces, SAW pairs **adaptive multi-model dynamic routing** with an **autonomous ReAct agent loop**, a **local multimodal RAG engine**, and an **AST-guarded isolated code execution sandbox**. It transforms complex, multi-modal engineering workflows into verifiable deliverables—generating publication-ready PDF inspection reports, Word clearance notes, and verified calculations on premise.

---

## ⚡ Core Value Pillars

```
+--------------------------------------------------------------------------------------------------+
|                                    THE FOUR SOVEREIGN PILLARS                                    |
+--------------------------------+--------------------------------+--------------------------------+
| 🛡️ Absolute Sovereignty         | 🧠 Multi-Model Dispatch        | 🤖 Autonomous ReAct Agent      |
| Zero cloud APIs, no external   | Dynamically matches task       | Iterative Plan -> Act ->       |
| telemetry, 100% air-gapped.   | intent to specialized open-    | Observe loop with failure      |
| Complete system auditability   | weight models (Coder, Vision,  | fingerprinting & auto-recovery.|
| on local host hardware.        | Fast Reasoning, Deep Analysis).| Synthesizes PDF & DOCX outputs.|
+--------------------------------+--------------------------------+--------------------------------+
| 🔍 Multimodal RAG with Local Vision OCR                         | 🔒 AST-Guarded Code Sandbox    |
| PyMuPDF native extraction + heuristic scanned PDF detection.   | Validates Python AST prior to  |
| 150 DPI page rendering with Qwen2.5-VL optical character       | execution. Strict process      |
| recognition, BGE-M3 1024-dim embeddings, and ChromaDB.         | isolation & blocked network.   |
+----------------------------------------------------------------+--------------------------------+
```

---

## 🏗️ System Architecture

SAW features a modular seven-layer architecture engineered for clean separation of concerns, high throughput, and strict local containment:

```
[ User Workstation Browser ]
              │
              ▼  (HTTP / WebSocket on localhost:3000)
┌────────────────────────────────────────────────────────────────────────┐
│ 1. PRESENTATION LAYER (Next.js 16 + React 19 + Tailwind CSS v4)        │
│    • Multi-Session Conversational Workspace                            │
│    • Real-Time Run Inspector DAG (9 Execution Stages)                  │
│    • Managed File Manager & Interactive Download Cards                 │
│    • Local Diagnostics, Model Matrix & Settings Console                │
└────────────────────────────────────┬───────────────────────────────────┘
                                     │
                                     ▼  (REST API on 127.0.0.1:8000)
┌────────────────────────────────────────────────────────────────────────┐
│ 2. API GATEWAY & CONTROLLER (FastAPI + Pydantic v2)                    │
│    • /api/tasks (Unified Task Dispatcher)                              │
│    • /api/tasks/{run_id}/events (Checkpoint Ledger Stream)            │
│    • /api/files (Secure Multipart Uploads, Streaming Downloads)       │
│    • /api/models (Local Model Pool Health & Availability)              │
└────────────────────────────────────┬───────────────────────────────────┘
                                     │
                                     ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 3. ORCHESTRATION & AGENT CORE (Vajra Engine)                           │
│    • Deterministic Task Classifier (< 1ms heuristic analysis)          │
│    • Execution Mode Selector: Direct Answer | Code | ReAct Agent       │
│    • ReAct Agent State Machine (Plan -> Act -> Observe -> Recover)     │
│    • Failure Fingerprint Interceptor (Hallucinatory Loop Defense)      │
│    • Progress Event Emitter (Thread-Safe Checkpoint Ledger)            │
└──────┬─────────────────────────────┼────────────────────────────┬──────┘
       │                             │                            │
       ▼                             ▼                            ▼
┌──────────────────────┐  ┌──────────────────────┐  ┌────────────────────┐
│ 4. LOCAL MODEL POOL  │  │ 5. TOOL ECOSYSTEM    │  │ 6. MULTIMODAL RAG  │
│ • qwen3:1.7b (General│  │ • python_sandbox     │  │ • PyMuPDF Extractor│
│   Fast, Priority 10) │  │   (AST Static Guard) │  │ • Scanned PDF Heur-│
│ • qwen3:4b (Hard     │  │ • pdf_creator        │  │   istic (<50 c/pg) │
│   Reasoning, 15s max)│  │   (ReportLab Engine) │  │ • Qwen2.5-VL OCR   │
│ • qwen2.5-coder:1.5b │  │ • docx_creator       │  │ • BGE-M3 Embeddings│
│   (Python Specialist)│  │   (python-docx)      │  │   (1024-dim dense) │
│ • qwen2.5vl:3b       │  │ • search_knowledge   │  │ • ChromaDB Vector  │
│   (Multimodal Vision)│  │   (ChromaDB Query)   │  │   (data/chroma)    │
│ • Mock Providers     │  │ • ToolValidator      │  │ • SHA-256 Content  │
│   (Zero-GPU Demo)    │  │   (Auto-Aliasing)    │  │   Deduplication    │
└──────────────────────┘  └──────────┬───────────┘  └────────────────────┘
                                     │
                                     ▼
┌────────────────────────────────────────────────────────────────────────┐
│ 7. LOCAL STORAGE & AUDIT LEDGER                                        │
│    • Managed Local File Storage (data/files/)                          │
│    • Path Traversal Defense & Windows Device Name Sanitization         │
│    • Relational SQLite Database (data/soar.db)                         │
│      [ documents | files | agent_runs | agent_steps | audit_logs ]     │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 🎯 Dual Execution Modes: Real vs. Demo

SAW is built with a dual-mode configuration system to suit both full on-premise hardware deployments and zero-setup compliance demonstrations:

| Feature Dimension | 🚀 Real Mode (Production) | ⚡ Demo Mode (Quickstart) |
| :--- | :--- | :--- |
| **Configuration** | `config/config.yaml` | `config/config.demo.yaml` |
| **Inference Engine** | Local Ollama (`http://localhost:11434`) | In-Memory Deterministic Mock Engine |
| **Model Suite** | `qwen3:1.7b`, `qwen3:4b`, `qwen2.5-coder`, `qwen2.5vl` | Simulated Specialized Model Responses |
| **Hardware Reqs** | NVIDIA GPU (8 GB+ VRAM) or 16 GB+ CPU | Any standard dual-core laptop (2 GB RAM) |
| **Model Downloads** | Requires pulling weights via Ollama | **Zero Downloads (0 bytes downloaded)** |
| **Embeddings** | Neural `BAAI/bge-m3` (1024-dim dense) | Deterministic Hash-Based Mock Vectors |
| **Tools & Sandbox** | Real Python Sandbox & Document Generators | Real Python Sandbox & Document Generators |
| **Launch Command** | `RunScripts\run.bat` / `run.sh` | `RunScripts\run_demo.bat` / `run_demo.sh` |

---

## 🔄 End-to-End Workflow Demonstration

Consider an operational task at an oil refinery: **"Inspect scanned vibration report, identify abnormalities, verify against ISO standard, calculate pump efficiency, and draft a formal clearance note."**

```mermaid
sequenceDiagram
    autonumber
    actor Engineer as Plant Reliability Engineer
    participant UI as SAW Workbench
    participant Orch as Vajra Orchestrator
    participant Vision as Qwen2.5-VL Vision
    participant RAG as ChromaDB / BGE-M3
    participant Box as Python Sandbox
    participant Gen as PDF Creator Tool

    Engineer->>UI: Uploads scanned report & requests clearance note
    UI->>Orch: POST /api/tasks (with attached file_id)
    Orch->>Orch: Detects scanned PDF (<50 chars/page)
    Orch->>Vision: Renders page to 150 DPI pixmap & extracts OCR text
    Vision-->>Orch: "Boiler B-201: Vibration velocity 7.2 mm/s RMS"
    Orch->>RAG: search_knowledge("ISO 10816-3 Class II vibration limits")
    RAG-->>Orch: "Limit is 4.5 mm/s RMS. 7.2 mm/s denotes critical fault."
    Orch->>Box: python_sandbox.execute(boiler_efficiency_calc.py)
    Box-->>Orch: "Thermal Efficiency: 87.4%"
    Orch->>Gen: pdf_creator(output_path='outputs/approval_note.pdf')
    Gen-->>Orch: Document generated (24,180 bytes)
    Orch-->>UI: Clearance analysis, calculations & instant Download Card
    UI-->>Engineer: Interactive report & one-click PDF download
```

---

## 🚀 Step-by-Step Installation & Setup Guide

Follow this guide to install and configure SAW from scratch, from cloning the repository to setting up Ollama, downloading sovereign models, configuring Python/Node environments, and launching the workbench.

---

### Step 1: Clone the Repository

Clone the project repository to your local machine and navigate into the root directory:

```bash
git clone https://github.com/sherrykeos/SAW.git
cd "SAW v0.1"
```

---

### Step 2: Install Ollama (Local Model Runtime)

SAW uses [Ollama](https://ollama.com) as its local inference server to run open-weight models on your host hardware with zero cloud dependencies.

#### Windows Installation
- **Option A (Direct Installer):** Download and run the official installer from [ollama.com/download/windows](https://ollama.com/download/windows).
- **Option B (Windows Package Manager / winget):**
  ```powershell
  winget install Ollama.Ollama
  ```
- *Ollama starts automatically in the system tray. To verify:*
  ```powershell
  ollama --version
  ```

#### Linux Installation (Ubuntu / Debian / RHEL / CentOS)
Run the official Linux installation script:
```bash
curl -fsSL https://ollama.ai/install.sh | sh
```
*Start and enable the systemd service:*
```bash
sudo systemctl enable --now ollama
```

#### macOS Installation (Apple Silicon / Intel)
- Download the installer from [ollama.com/download/mac](https://ollama.com/download/mac) or install via Homebrew:
  ```bash
  brew install ollama
  ollama serve
  ```

#### Verify Ollama is Reachable
Test that Ollama is responding on `http://localhost:11434`:
```bash
# Windows PowerShell:
(Invoke-WebRequest -Uri "http://localhost:11434/api/version").Content

# Linux / macOS:
curl http://localhost:11434/api/version
# Output: {"version":"0.x.x"}
```

---

### Step 3: Download Local Sovereign Models

Pull the specialized local open-weight model pool into your local Ollama library. Each model fulfills a dedicated capability role in SAW's dynamic routing matrix:

```bash
# 1. Primary Fast General & Reasoning Model (~1.2 GB)
# Used for: Fast conversational QA, direct answers, and default resilient fallback
ollama pull qwen3:1.7b

# 2. Hard Multi-Step Reasoning Model (~2.5 GB)
# Used for: Complex logical deductions, root-cause troubleshooting (15s latency budget)
ollama pull qwen3:4b

# 3. Dedicated Python Coding Model (~1.0 GB)
# Used for: Writing, refactoring, and debugging Python functions & engineering calculators
ollama pull qwen2.5-coder:1.5b

# 4. Multimodal Vision & OCR Model (~2.1 GB)
# Used for: P&ID drawings, scanned inspection reports, and visual weld/flange analysis
ollama pull qwen2.5vl:3b
```

#### Verify Installed Models
Confirm that all 4 models are successfully installed:
```bash
ollama list
```
*Expected output:*
```text
NAME                    ID              SIZE      MODIFIED
qwen3:1.7b              ...             1.2 GB    ...
qwen3:4b                ...             2.5 GB    ...
qwen2.5-coder:1.5b      ...             1.0 GB    ...
qwen2.5vl:3b            ...             2.1 GB    ...
```

---

### Step 4: Configure Backend Python Virtual Environment

Navigate to the `backend/` directory, create an isolated virtual environment, and install dependencies:

#### Windows:
```powershell
cd backend
python -m venv .venv
.venv\Scripts\activate
python -m pip install --upgrade pip
pip install -r requirements.txt
```

#### Linux / macOS:
```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
```

*Key backend libraries installed: `fastapi`, `uvicorn`, `pydantic`, `PyMuPDF` (PDF parsing), `python-docx` (Word synthesis), `reportlab` (PDF synthesis), `chromadb` (vector store), `sentence-transformers` (BGE-M3 embeddings).*

---

### Step 5: Configure Frontend Node Dependencies

Open a new terminal, navigate to the `frontend/` directory, and install the Node packages:

```bash
cd frontend
npm install
```

*Key frontend libraries installed: `next` 16, `react` 19, `tailwindcss` v4, `framer-motion`, `lucide-react`.*

---

### Step 6: Launch SAW (Production Real Mode)

#### 1-Click Automated Launchers
From the project root directory, run the launch script corresponding to your operating system:

- **Windows:**
  ```cmd
  RunScripts\run.bat
  ```
  *(Or double-click `RunScripts\run.bat` in File Explorer)*

- **Linux / macOS:**
  ```bash
  chmod +x RunScripts/run.sh
  ./RunScripts/run.sh
  ```

*The launcher automatically verifies the Python virtual environment, checks that Ollama is listening on port 11434, starts the FastAPI backend on port 8000, starts the Next.js frontend on port 3000, and opens your default browser to `http://localhost:3000`.*

#### Manual Launch (Alternative)
If you prefer running services manually across separate terminal windows:

```bash
# Terminal 1: Ollama Server
ollama serve

# Terminal 2: SAW FastAPI Backend
cd backend
# Windows: .venv\Scripts\activate | Linux: source .venv/bin/activate
set SOAR_CONFIG_PATH=config/config.yaml      # Linux: export SOAR_CONFIG_PATH=config/config.yaml
python -m uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload

# Terminal 3: SAW Next.js Frontend
cd frontend
npm run dev
```

- **Frontend Workbench:** `http://localhost:3000`
- **Backend API & Swagger Docs:** `http://127.0.0.1:8000/docs`

---

### ⚡ Alternative: Zero-GPU Demo Mode (No Ollama, Zero Downloads)

If you are evaluating SAW on a laptop without a dedicated GPU or in an environment where model downloads are temporarily restricted, launch **Demo Mode**:

```bash
# Windows:
RunScripts\run_demo.bat

# Linux / macOS:
bash RunScripts/run_demo.sh
```

- **Zero GPU / Zero Model Downloads:** Runs entirely in memory using deterministic mock providers.
- **Full UI Experience:** All features—conversational chat, Run Inspector DAG, PDF/DOCX file generators, and AST sandbox execution—run with instant, simulated responses.

---

## ⚙️ Centralized Configuration (`config/config.yaml`)

SAW uses a single, strictly-typed configuration file. To add or adjust models, simply modify `backend/config/config.yaml` without changing source code:

```yaml
app:
  name: "SAW"
  environment: "development"
  debug: false

# Dynamic Model Pool (Lower priority integer = higher preference)
models:
  - id: "qwen3:1.7b"
    provider: "ollama"
    capabilities: ["general", "reasoning"]
    priority: 10
    enabled: true
    timeout: 180

  - id: "qwen3:4b"
    provider: "ollama"
    capabilities: ["reasoning"]
    priority: 20
    enabled: true
    timeout: 15.0  # Strict latency budget safeguard

  - id: "qwen2.5-coder:1.5b"
    provider: "ollama"
    capabilities: ["coding"]
    priority: 15
    enabled: true
    timeout: 180

  - id: "qwen2.5vl:3b"
    provider: "ollama"
    capabilities: ["vision"]
    priority: 15
    enabled: true
    timeout: 180

storage:
  root: "./data/files"
  max_file_size_bytes: 52428800  # 50 MB limit

vector_store:
  backend: "chroma"
  path: "./data/chroma"
  collection_name: "saw_knowledge"

embeddings:
  model_name_or_path: "BAAI/bge-m3"
  dimension: 1024
  normalize_embeddings: true

sandbox:
  root: "./sandbox"
  timeout: 10  # 10s execution cap

security:
  allow_external_network: false  # Sovereign air-gap assertion
```

---

## 🛠️ Local Tools & Sandbox Safeguards

SAW includes a rich ecosystem of locally registered tools managed by `ToolRegistry`:

| Tool Identifier | Core Implementation | Safeguards & Capabilities |
| :--- | :--- | :--- |
| `python_sandbox` | `app/tools/python_sandbox.py` | **AST Static Security Gate:** Blocks `socket`, `requests`, `urllib`, `subprocess`, `os.system`, and path escapes (`..`). Runs in isolated `./sandbox/workspace/` with a 10s timeout cap. |
| `pdf_creator` | `app/tools/pdf_creator.py` | **ReportLab Document Generator:** Generates professional multi-page PDFs with styling, margins, and automatic metadata registration in managed storage. |
| `docx_creator` | `app/tools/docx_creator.py` | **python-docx Generator:** Builds structured Word documents with headings, bulleted lists, and telemetry tables. |
| `pdf_reader` | `app/tools/pdf_reader.py` | **PyMuPDF Engine:** Extracts text layers from PDF documents with encrypted file detection. |
| `read_file` | `app/tools/read_file.py` | **Local Safe Reader:** Reads text/CSV/code files bounded to 8,000 characters to safeguard model context windows. |
| `search_knowledge` | `app/tools/search_knowledge.py` | **Semantic RAG Retrieval:** Queries ChromaDB for top-$k$ context passages with document source and page citations. |
| `validator` | `app/tools/validator.py` | **Auto-Aliasing Engine:** Transparently maps parameter aliases (e.g. `path` $\rightarrow$ `file_path`, `output_file` $\rightarrow$ `output_path`) before tool execution. |

---

## 📊 Real-Time Run Inspector (Execution DAG)

The right-hand collapsible Run Inspector monitors all real backend progress event checkpoints emitted across **9 standard execution stages**:

```
[1. CLASSIFYING] ──> [2. MODEL_SELECTING] ──> [3. PLANNING] ──> [4. TOOL_EXECUTING]
                                                                        │
[8. COMPLETED]   <── [7. OUTPUT_GENERATION]<── [6. REASONING] <── [5. OBSERVING]
```

- **Sensitive Data Scrubbing:** Automatically removes chain-of-thought `<think>` tags and redacts sensitive credentials matching `(?i)(password|token|key|secret)` from event logs.
- **Duration Tracking:** Measures exact sub-second execution duration for every individual tool call.
- **Audit Logging:** Every step is committed to the SQLite `agent_steps` and `audit_logs` tables.

---

## 📡 REST API Reference

The backend provides a clean REST API running on `http://127.0.0.1:8000`:

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/health` | Operational health and version status |
| `POST` | `/api/tasks` | Submit user prompt with adaptive model routing & file attachments |
| `GET` | `/api/tasks/{run_id}/events` | Retrieve full checkpoint ledger for a specific task run |
| `POST` | `/api/files/upload` | Upload local file to managed storage (`data/files/`) |
| `GET` | `/api/files` | List managed files with pagination (`limit`, `offset`) |
| `GET` | `/api/files/{file_id}` | Retrieve file metadata & SHA-256 checksum |
| `GET` | `/api/files/{file_id}/download` | Stream binary file download with original filename |
| `DELETE` | `/api/files/{file_id}` | Delete file, metadata, and database records |
| `GET` | `/api/models` | List configured local models and live availability |

*Explore full interactive OpenAPI documentation at [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs).*

---

## 📂 Repository Directory Layout

```text
SAW v0.1/
├── RunScripts/                 # One-click automated startup scripts
│   ├── run.bat                 # Windows: Real Mode launcher (Ollama + UI)
│   ├── run_demo.bat            # Windows: Zero-GPU Demo Mode launcher
│   ├── run.sh                  # Linux/macOS: Real Mode launcher
│   └── run_demo.sh             # Linux/macOS: Demo Mode launcher
├── backend/                    # Core Python Application & Inference Engine
│   ├── app/
│   │   ├── api/                # FastAPI application, routes, schemas, dependencies
│   │   ├── config/             # YAML configuration parser & typed dataclasses
│   │   ├── database/           # SQLite schema, connection pool & repository
│   │   ├── embeddings/         # BGE-M3 local embedding model & mock fallbacks
│   │   ├── ingestion/          # Multimodal ingestion pipeline (PDF, DOCX, PPTX, Image)
│   │   ├── models/             # Model manager, registry, Ollama adapter, router
│   │   ├── orchestrator/       # Vajra engine: agent loop, planner, executor, recovery
│   │   ├── storage/            # Local file storage with traversal & device protection
│   │   ├── tools/              # Python sandbox, PDF/DOCX creators, knowledge search
│   │   ├── vector_store/       # Local ChromaDB vector database integration
│   │   └── vision/             # Local Qwen2.5-VL vision processor & OCR
│   ├── config/
│   │   ├── config.yaml         # Real Mode production configuration
│   │   └── config.demo.yaml    # Zero-GPU quickstart configuration
│   ├── data/                   # Local persistent files, SQLite DB & ChromaDB
│   ├── sandbox/                # Isolated workspace for Python script execution
│   ├── test_cases/             # 36 test suites, benchmarks & verification scripts
│   └── requirements.txt        # Python backend dependencies
├── frontend/                   # Sovereign Presentation Layer (Next.js 16)
│   ├── app/                    # Next.js App Router (Landing page & /app workspace)
│   │   └── app/                # Main Workbench, Files, Knowledge, Models, Settings
│   ├── components/             # React 19 UI components
│   │   ├── chat/               # Conversational workspace, file cards, markdown
│   │   ├── inspector/          # Run Inspector DAG & animated pipeline connectors
│   │   ├── landing/            # Product showcase, hero section, CTA
│   │   └── layout/             # Sovereign dark sidebar, command palette, top bar
│   ├── context/                # WorkbenchContext (multi-session state, local storage)
│   ├── lib/api/                # Strongly-typed API client connectors
│   └── package.json            # Node.js dependencies (Tailwind v4, Framer Motion)
└── docs/                       # Comprehensive Technical Documentation
    ├── SAW-Doc.md              # 1,500-line In-Depth Architecture & Technical Report
    ├── api.md                  # REST API Specification & Examples
    ├── configuration.md        # Centralized Configuration Guide
    └── SAW product image.png   # High-resolution workbench visual asset
```

---

## 🔒 Security, Governance & Air-Gap Audit

To verify that SAW strictly conforms to air-gapped sovereign security standards:

1. **Hardware Disconnect Test:** Disconnect all external Ethernet cables and disable Wi-Fi adapters. SAW runs with 100% functionality.
2. **Loopback Binding Audit:** All services bind strictly to `127.0.0.1`:
   ```powershell
   # Windows PowerShell verification:
   Get-NetTCPConnection | Where-Object { $_.LocalPort -in 8000, 3000, 11434 }
   ```
3. **Packet Capture Inspection:** Run `Wireshark` or `tcpdump -i any -n` while executing tasks, document creation, and OCR extraction. **Zero outbound packets** are transmitted beyond the local loopback interface.
4. **AST Code Security:** The Python sandbox rejects network modules (`socket`, `requests`, `urllib`), subprocess shells (`subprocess`, `os.system`), and path traversal tokens (`../`) before any code is executed.
5. **Sanitized Event Ledger:** Internal chain-of-thought `<think>` tags and sensitive authorization secrets are permanently stripped before events reach the UI or client logs.

---

## 📚 Technical Documentation Index

For exhaustive architectural breakdowns, implementation details, and benchmarks:

- 📖 **[SAW-Doc.md](docs/SAW-Doc.md):** 1,500-line comprehensive technical report covering architectural topology, agent state machines, failure fingerprinting algorithms, scanned PDF vision OCR pipelines, and benchmarks.
- 🔌 **[api.md](docs/api.md):** Detailed REST API endpoints, JSON payloads, query parameters, and cURL commands.
- ⚙️ **[configuration.md](docs/configuration.md):** Configuration schema reference, guide to adding new local models, and storage tuning.

---

## ⚖️ License & Intellectual Property

**SAW (Sovereign Agentic AI Workbench)** is proprietary and confidential software developed for high-security industrial and sovereign public infrastructure. All rights reserved.

---

<div align="center">
  <b>Built for Sovereign National Infrastructure & Industrial Security</b><br />
  <sub>Zero Cloud Exposure &bull; Air-Gapped Intelligence &bull; On-Premise Control</sub>
</div>
