# Sovereign Agentic AI Workbench (SAW) — Comprehensive Technical Documentation & Architecture Report

**Version:** 0.1.0  
**Classification:** Sovereign / Air-Gapped Industrial AI System  
**Target Environments:** Refineries, Power & Nuclear Plants, Public Sector Undertakings (PSUs), Defence Establishments, Government Infrastructure  
**Author:** Antigravity Engineering & Architecture Team  
**Date:** March 2026  

---

## Table of Contents

1. [Executive Summary & Project Overview](#1-executive-summary--project-overview)
   - 1.1 The Sovereignty Imperative
   - 1.2 Core Architectural Principles
   - 1.3 High-Level Feature Matrix
   - 1.4 Dual Operating Modes (Real vs. Demo)
2. [End-to-End System Architecture](#2-end-to-end-system-architecture)
   - 2.1 Architectural Topology
   - 2.2 Subsystem Layering & Separation of Concerns
   - 2.3 Comprehensive Subsystem Decomposition
3. [System Flow & Execution Pipelines](#3-system-flow--execution-pipelines)
   - 3.1 End-to-End Task Lifecycle
   - 3.2 The Three Core Execution Modes
   - 3.3 ReAct Agent State Machine (Plan-Act-Observe-Recover)
   - 3.4 Progress Event Checkpoint Lifecycle
   - 3.5 Failure Fingerprinting & Automatic Error Recovery
4. [Multi-Model Dynamic Routing & Model Pool](#4-multi-model-dynamic-routing--model-pool)
   - 4.1 Philosophy: Capability-Based Dynamic Dispatch
   - 4.2 Local Model Ecosystem
   - 4.3 Task Classification Engine
   - 4.4 Routing Decision Matrix & Latency Safeguards
   - 4.5 Fallback Recovery Chain
5. [Multimodal Knowledge Ingestion & RAG Pipeline](#5-multimodal-knowledge-ingestion--rag-pipeline)
   - 5.1 Supported Document Formats
   - 5.2 Scanned Document Detection & Local Vision OCR
   - 5.3 Recursive Character Chunking
   - 5.4 Dense Embeddings & Vector Space
   - 5.5 ChromaDB Persistent Vector Store
   - 5.6 SQLite Metadata Indexing & Deduplication
6. [Local Tools & Isolated Execution Sandbox](#6-local-tools--isolated-execution-sandbox)
   - 6.1 Tool Registry Architecture
   - 6.2 Python Sandbox & AST Static Security Gate
   - 6.3 Document Synthesis: PDF & DOCX Creators
   - 6.4 Knowledge Search & File Inspection Tools
   - 6.5 Parameter Validation & Auto-Aliasing Engine
7. [Data Architecture & Storage Subsystem](#7-data-architecture--storage-subsystem)
   - 7.1 Managed Local File Storage
   - 7.2 Path Traversal & Windows Device Sanitization
   - 7.3 Relational Database Schema (SQLite)
   - 7.4 Audit Logging & Compliance Trails
8. [Complete REST API Specification](#8-complete-rest-api-specification)
   - 8.1 API Conventions & Architecture
   - 8.2 Endpoints Reference
   - 8.3 Data Transfer Objects & Schemas
   - 8.4 HTTP Status Codes & Error Formats
9. [Frontend User Interface & User Experience](#9-frontend-user-interface--user-experience)
   - 9.1 UI Architecture & Tech Stack
   - 9.2 Conversational Chat & Multi-Session System
   - 9.3 Real-Time Run Inspector & DAG Visualization
   - 9.4 Workspace Navigation & Document Management
10. [Centralized Configuration System](#10-centralized-configuration-system)
    - 10.1 Configuration Structure & Hierarchy
    - 10.2 Modifying & Adding Models
    - 10.3 Environmental Overrides
11. [Installation, Deployment & Air-Gap Verification Guide](#11-installation-deployment--air-gap-verification-guide)
    - 11.1 Hardware Sizing & System Prerequisites
    - 11.2 Production Real Mode Installation
    - 11.3 Demo Mode Installation (Zero GPU / Zero Ollama)
    - 11.4 Launcher Scripts Breakdown
    - 11.5 Air-Gap Verification & Network Isolation Audit
12. [Testing, Benchmarking & Quality Assurance](#12-testing-benchmarking--quality-assurance)
    - 12.1 Backend Test Suite Overview
    - 12.2 Model Routing Benchmarks
    - 12.3 Vision OCR Benchmarks
    - 12.4 Running Tests Locally
13. [Security, Governance & Compliance](#13-security-governance--compliance)
    - 13.1 Air-Gap Isolation Guarantee
    - 13.2 Memory & Storage Sanitization
    - 13.3 Subprocess Isolation Policy
14. [Troubleshooting & Frequently Asked Questions (FAQ)](#14-troubleshooting--frequently-asked-questions-faq)

---

## 1. Executive Summary & Project Overview

### 1.1 The Sovereignty Imperative

In high-consequence industries—such as oil refineries, petrochemical complexes, nuclear installations, power grids, public sector undertakings (PSUs), defence establishments, and intelligence agencies—confidentiality is an absolute regulatory and operational constraint. Standard commercial AI services (e.g., cloud-hosted OpenAI ChatGPT, Anthropic Claude, Google Gemini) require sending prompts, proprietary documents, telemetry data, and source code over the public internet to third-party data centers.

For sovereign operators, this exposure is unacceptable. Intellectual property leaks, cyber-espionage risks, and regulatory embargoes make cloud AI non-viable.

**SAW (Sovereign Agentic AI Workbench)** was conceived and built from the ground up to solve this trilemma:
1. **Full Sovereignty:** Runs 100% locally on on-premise hardware with zero internet egress, air-gapped network policies, and local open-weight model weights.
2. **True Agentic Intelligence:** Transcends simple text chat by incorporating an autonomous ReAct loop (Plan $\rightarrow$ Act $\rightarrow$ Observe $\rightarrow$ Reason) capable of executing tools, analyzing industrial drawings, compiling reports, and running sandboxed code.
3. **Multi-Model Orchestration:** Eliminates vendor and model lock-in by pairing task demands dynamically with specialized open-weight models (e.g., mathematical reasoning, coding, visual OCR, and fast general instruction).

```
+------------------------------------------------------------------------------------+
|                               SAW SOVEREIGNTY BOUNDARY                             |
|                                                                                    |
|  [On-Premise Server / Workstation]                                                 |
|  +--------------------+   +---------------------+   +---------------------------+  |
|  | Local Next.js UI   |<->| Local FastAPI Core  |<->| Local Ollama Model Server |  |
|  | (Port 3000)        |   | (Port 8000)         |   | (Port 11434)              |  |
|  +--------------------+   +---------------------+   +---------------------------+  |
|                                      |                                             |
|                         +------------+------------+                                |
|                         |                         |                                |
|              +--------------------+    +--------------------+                      |
|              | Local ChromaDB RAG |    | Local SQLite DB    |                      |
|              | (data/chroma)      |    | (data/soar.db)     |                      |
|              +--------------------+    +--------------------+                      |
|                                                                                    |
|  [NO EXTERNAL API CALLS]  [NO TELEMETRY]  [NO CLOUD DATA EXPOSURE]  [100% AIR-GAP] |
+------------------------------------------------------------------------------------+
```

### 1.2 Core Architectural Principles

- **Zero-Trust Local Execution:** Every component—from document parsing, vector embedding generation, LLM token generation, to code execution—takes place inside the local operating system boundary.
- **Dynamic Model-to-Task Pairing:** Rather than forcing a single model to handle disparate tasks, SAW categorizes tasks into semantic profiles and dispatches them to specialized open-weight models.
- **Fail-Safe Determinism & Fallbacks:** High availability is guaranteed through strict latency budgets, connection health checks, and automatic fallback chains. If an intensive model times out or is offline, the system gracefully cascades down to a resilient lightweight model.
- **Observable Execution DAG:** Every phase of agent deliberation is emitted as a structured, sanitized progress event checkpoint, allowing human operators to audit the model's chain of thought, tool arguments, and intermediate findings in real time.
- **Multi-Format Deliverables (Artifacts):** SAW produces concrete, verifiable artifacts—including formatted PDF inspection certificates, Word (`.docx`) approval memos, Python scripts, and calculated tables—rather than ephemeral chat responses.

### 1.3 High-Level Feature Matrix

| Capability Category | SAW Real Mode (Production) | SAW Demo Mode (Zero-GPU) |
| :--- | :--- | :--- |
| **Inference Engine** | Local Ollama (`http://localhost:11434`) | Mock Model Provider (In-Memory Engine) |
| **General Language Model** | `qwen3:1.7b` (Low latency, high throughput) | `mock-general` (Deterministic responses) |
| **Complex Reasoning Model** | `qwen3:4b` (Multi-step logical deductions) | `mock-reasoning` (Structured analytical steps) |
| **Coding Specialist** | `qwen2.5-coder:1.5b` (Syntax & algorithm optimization) | `mock-coder` (Python calculation templates) |
| **Multimodal Vision & OCR** | `qwen2.5vl:3b` (Diagrams, P&IDs, scanned documents) | `mock-vision` (Visual weld/gauge inspections) |
| **Embeddings & Vector Store** | `BAAI/bge-m3` (1024-dim) + ChromaDB | Deterministic Mock Embeddings + ChromaDB |
| **Document Processing** | PyMuPDF, python-docx, python-pptx | PyMuPDF, python-docx, python-pptx |
| **Code Execution** | Isolated Python Sandbox (AST-restricted) | Isolated Python Sandbox (AST-restricted) |
| **Document Synthesis** | ReportLab (PDF), python-docx (Word) | ReportLab (PDF), python-docx (Word) |
| **Hardware Required** | 8 GB+ VRAM GPU (or fast 16 GB+ CPU) | Standard Dual-Core Laptop (2 GB RAM) |

### 1.4 Dual Operating Modes (Real vs. Demo)

SAW features a configuration-driven duality allowing it to operate either as an on-premise production engine or as an instant zero-dependency demonstration:

1. **Real Mode (`config/config.yaml`):**
   - Connects to local Ollama runtime.
   - Utilizes physical weights for `qwen3:1.7b`, `qwen3:4b`, `qwen2.5-coder:1.5b`, and `qwen2.5vl:3b`.
   - Generates real neural dense embeddings using BAAI BGE-M3.
   - Intended for deployment on workstations or on-prem servers equipped with NVIDIA RTX/A-series GPUs or high-core modern CPUs.
2. **Demo Mode (`config/config.demo.yaml`):**
   - Requires zero model downloads, zero GPU hardware, and zero Ollama installations.
   - Simulates complete LLM reasoning, code synthesis, visual inspection, and embedding vectors using deterministic mock engines.
   - Enables engineers, auditors, and evaluators to test all UI interactions, progress checkpoints, file generation routines, and API endpoints instantly on standard enterprise laptops.

---

## 2. End-to-End System Architecture

### 2.1 Architectural Topology

The following diagram illustrates the interconnected topology of SAW, spanning the client application, API gateway, orchestration engine, dynamic model pool, retrieval pipeline, local sandboxes, and persistence storage layers:

```mermaid
graph TB
    subgraph ClientLayer ["1. Presentation Layer (Next.js 16 + React 19)"]
        UI_Chat["Conversational Chat UI\n(Multi-Session Management)"]
        UI_Inspector["Run Inspector DAG\n(Progress Event Stream)"]
        UI_Files["File Manager & Previews\n(Managed Uploads/Downloads)"]
        UI_Admin["Models & Settings Console\n(Diagnostics & Config Viewer)"]
    end

    subgraph APILayer ["2. Local Gateway & API Layer (FastAPI)"]
        API_Tasks["/api/tasks\n(Task Dispatcher)"]
        API_Events["/api/tasks/{id}/events\n(Checkpoint Ledger)"]
        API_Files["/api/files\n(Upload / Download / Delete)"]
        API_Models["/api/models\n(Health & Availability)"]
        API_Health["/api/health\n(Operational Status)"]
    end

    subgraph OrchestrationLayer ["3. Orchestration & Agent Core (Vajra Pipeline)"]
        Classifier["Deterministic Task Classifier\n(Pattern & Intent Analysis)"]
        Router["Adaptive Model Router\n(Capability & Priority Matching)"]
        Orchestrator["Unified Orchestrator\n(Direct / Code / Agent Router)"]
        AgentCore["ReAct Autonomous Agent\n(Plan -> Act -> Observe Loop)"]
        Planner["Dynamic JSON Planner\n(Tool Schema Prompting)"]
        Executor["Safe Tool Executor\n(Argument Validation & Recovery)"]
        Recovery["Failure Fingerprinting\n(Loop Detection & Mitigation)"]
        EventEmitter["Progress Event Emitter\n(Sanitized Event Checkpoints)"]
    end

    subgraph ModelPool ["4. Dynamic Local Model Pool (Ollama / Mock)"]
        M_Gen["qwen3:1.7b\n(Fast General / Fallback)"]
        M_Reas["qwen3:4b\n(Hard Multi-Step Reasoning)"]
        M_Code["qwen2.5-coder:1.5b\n(Dedicated Python Coder)"]
        M_Vis["qwen2.5vl:3b\n(Multimodal Vision & OCR)"]
        M_Mock["Deterministic Mock Engine\n(Zero-GPU Quickstart)"]
    end

    subgraph ToolEcosystem ["5. Isolated Tool Execution Subsystem"]
        T_Sandbox["python_sandbox\n(AST-Guarded Child Process)"]
        T_PDFGen["pdf_creator\n(ReportLab Document Generator)"]
        T_DocxGen["docx_creator\n(python-docx Generator)"]
        T_PDFRead["pdf_reader\n(PyMuPDF Text Extractor)"]
        T_FileRead["read_file\n(Local Safe File Reader)"]
        T_RAG["search_knowledge\n(ChromaDB Semantic Query)"]
    end

    subgraph KnowledgeSubsystem ["6. Multimodal Knowledge Ingestion & RAG"]
        IngestPipe["Ingestion Pipeline\n(PDF, DOCX, PPTX, Images)"]
        ScannedDetector["Scanned PDF Detection\n(< 50 chars/page heuristic)"]
        VisionOCR["Local Vision OCR\n(Page Pixmap -> Qwen-VL)"]
        Chunker["Recursive Character Chunker\n(500-token / 50-overlap)"]
        Embeddings["BGE-M3 Dense Embeddings\n(1024-dim Vector Engine)"]
        VectorStore[("ChromaDB Vector Store\n(data/chroma)")]
    end

    subgraph PersistenceLayer ["7. Managed Local Storage & Relational Database"]
        FileStore["Local File Storage Engine\n(Path Traversal & Device Name Defense)"]
        LocalDisk[("Managed File Root\ndata/files/")]
        DBManager["SQLite Database Repository\n(data/soar.db)"]
        Tables[("SQLite Tables:\n- documents\n- files\n- agent_runs\n- agent_steps\n- audit_logs")]
    end

    %% Wiring Client to API
    UI_Chat --> API_Tasks
    UI_Inspector --> API_Events
    UI_Files --> API_Files
    UI_Admin --> API_Models
    UI_Admin --> API_Health

    %% Wiring API to Orchestration
    API_Tasks --> Orchestrator
    API_Events --> EventEmitter
    API_Files --> FileStore
    API_Models --> Router

    %% Orchestration Internal Flow
    Orchestrator --> Classifier
    Orchestrator --> Router
    Orchestrator --> EventEmitter
    Orchestrator --> AgentCore
    AgentCore --> Planner
    AgentCore --> Executor
    AgentCore --> Recovery
    Executor --> ToolEcosystem

    %% Router to Models
    Router --> ModelPool

    %% Tools to Subsystems
    T_RAG --> VectorStore
    T_Sandbox --> LocalDisk
    T_PDFGen --> LocalDisk
    T_DocxGen --> LocalDisk

    %% Ingestion Pipeline Flow
    IngestPipe --> ScannedDetector
    ScannedDetector --> VisionOCR
    IngestPipe --> Chunker
    Chunker --> Embeddings
    Embeddings --> VectorStore
    IngestPipe --> DBManager

    %% Storage Wiring
    FileStore --> LocalDisk
    FileStore --> DBManager
    DBManager --> Tables
```

### 2.2 Subsystem Layering & Separation of Concerns

SAW is architected across seven independent, modular layers:

1. **Presentation Layer (Frontend):** Modern, dark-mode, responsive web interface built with Next.js 16, React 19, TypeScript, and Tailwind CSS v4. Delivers streaming execution status, chat sessions, document previews, and an interactive Execution DAG inspector.
2. **API & Gateway Layer (Backend):** Built with FastAPI and Pydantic v2. Provides strict validation, dependency injection, uniform error responses, and clean RESTful separation between chat sessions and execution runs.
3. **Orchestration & Agent Core:** The "brain" (internally dubbed Vajra). Handles task classification, selects between single-turn direct response, specialized code generation, or multi-step agent workflows, and coordinates tool execution with automatic failure recovery.
4. **Model Pool & Inference Engine:** Model registry and adapter abstraction layer that dynamically routes requests to local Ollama endpoints or mock providers based on model capabilities, priorities, and health status.
5. **Tool Execution Subsystem:** A collection of local tools registered into a unified Tool Registry. Enforces AST security validation for code execution and synthesizes documents into managed disk storage.
6. **Knowledge Ingestion & Retrieval (RAG):** Multimodal document ingestion engine that extracts text from native and scanned PDFs, DOCX, PPTX, and images, generates 1024-dimensional dense vectors using BAAI BGE-M3, and persists them into ChromaDB.
7. **Storage & Persistence Layer:** Robust local filesystem storage engine featuring path traversal protection, file hashing, and a relational SQLite database for tracking documents, file metadata, agent runs, agent steps, and security audit logs.

### 2.3 Comprehensive Subsystem Decomposition

| Subsystem | Primary Python / TS Modules | Key Classes / Interfaces | Core Responsibility |
| :--- | :--- | :--- | :--- |
| **API Layer** | `app/api/app.py`<br>`app/api/routes/*.py` | `FastAPI`, `api_router`, `TaskRequest`, `TaskResponse` | REST API routing, exception handling, schema validation |
| **Orchestrator** | `app/orchestrator/orchestrator.py` | `Orchestrator` | Central task workflow coordinator, file context injection, result synthesis |
| **Task Classifier** | `app/orchestrator/routing/task_classifier.py` | `TaskClassifier`, `TaskProfile` | Zero-latency heuristic analysis of task intent, complexity, and resource needs |
| **Model Router** | `app/models/router.py`<br>`app/models/manager.py` | `ModelRouter`, `ModelManager`, `ModelRouteDecision` | Capability-based model routing, health checks, fallback chains, latency budgets |
| **Agent Engine** | `app/orchestrator/agent/agent.py`<br>`app/orchestrator/agent/state.py` | `Agent`, `AgentState`, `TaskContext` | Autonomous ReAct execution loop, state management, iteration caps |
| **Planner & Parser** | `app/orchestrator/planning/planner.py`<br>`app/orchestrator/planning/parser.py` | `Planner`, `PlanParser` | JSON schema prompting, LLM plan generation, structured action extraction |
| **Executor & Validator** | `app/orchestrator/execution/executor.py`<br>`app/tools/validator.py` | `Executor`, `ToolValidator`, `ValidationResult` | Argument type-checking, alias resolution, tool invocation, error formatting |
| **Recovery Manager** | `app/orchestrator/agent/recovery.py` | `RecoveryManager` | Failure fingerprinting, loop interception, recovery guidance prompt injection |
| **Event Checkpoints** | `app/orchestrator/events/emitter.py` | `ProgressEventEmitter`, `ProgressEvent`, `InMemoryEventSink` | Real backend execution checkpoint tracking, thread-safe buffering, data redaction |
| **Document Ingestion** | `app/ingestion/pipeline.py`<br>`app/ingestion/pdf.py` | `IngestionPipeline`, `PDFExtractor`, `DOCXExtractor` | Multimodal document parsing, scanned page detection, visual OCR extraction |
| **Vector Database** | `app/vector_store/chroma.py`<br>`app/embeddings/bge_m3.py` | `ChromaVectorStore`, `BGEM3EmbeddingModel` | Vector similarity search, collection management, dense vector persistence |
| **Sandboxed Tools** | `app/tools/python_sandbox.py`<br>`app/tools/pdf_creator.py` | `PythonSandboxTool`, `PDFCreatorTool`, `DOCXCreatorTool` | AST-guarded script execution, PDF/DOCX generation, local knowledge search |
| **Managed Storage** | `app/storage/local.py`<br>`app/database/repository.py` | `LocalFileStorage`, `DatabaseManager` | Secure file lifecycle management, SHA-256 deduplication, SQLite relational audit trails |
| **Workbench Frontend** | `frontend/context/WorkbenchContext.tsx`<br>`frontend/components/chat/*` | `WorkbenchProvider`, `ChatInterface`, `RunInspector` | Multi-session chat, local storage sync, DAG visualization, model selection |

---

## 3. System Flow & Execution Pipelines

### 3.1 End-to-End Task Lifecycle

The execution of any user prompt submitted through the web UI or REST API traverses a deterministic, multi-stage pipeline:

```mermaid
sequenceDiagram
    autonumber
    actor User as Human Operator / Client
    participant UI as Next.js Frontend
    participant API as FastAPI Gateway
    participant Orch as Orchestrator
    participant Class as TaskClassifier
    participant Mgr as ModelManager
    participant Agent as ReAct Agent
    participant Tool as Sandboxed Tools
    participant Store as Managed Storage

    User->>UI: Submits Prompt (with optional attached file_ids)
    UI->>API: POST /api/tasks (task, model, file_ids)
    API->>Orch: process_task(task, attached_file_ids)
    
    rect rgb(25, 35, 28)
        note right of Orch: Stage 1: Document Resolution
        Orch->>Store: Resolve file_ids to disk paths
        Store-->>Orch: Extracted document contents (PDF/Text)
        Orch->>Orch: Prepend document context to prompt
    end

    rect rgb(30, 40, 35)
        note right of Orch: Stage 2: Classification & Routing
        Orch->>Class: classify(task)
        Class-->>Orch: TaskProfile (mode, complexity, requires_rag, etc.)
        Orch->>Mgr: Select model by capability & priority
        Mgr-->>Orch: Target Model Adapter (or fallback)
    end

    alt Execution Mode == "direct_answer"
        rect rgb(20, 30, 40)
            note right of Orch: Direct Answer Pipeline
            opt requires_rag is True
                Orch->>Tool: search_knowledge(query, top_k=3)
                Tool-->>Orch: Retrieved knowledge chunks & citations
            end
            Orch->>Mgr: generate_with_routing(prompt + context)
            Mgr-->>Orch: ModelExecutionResult (response text)
        end
    else Execution Mode == "code"
        rect rgb(40, 35, 20)
            note right of Orch: Dedicated Coding Pipeline
            Orch->>Mgr: generate_with_routing(coding_prompt)
            Mgr-->>Orch: Generated Python Code
            opt Explicit Sandbox Execution Requested
                Orch->>Tool: python_sandbox.execute(code)
                Tool-->>Orch: Sandbox stdout/stderr
            end
        end
    else Execution Mode == "agent"
        rect rgb(35, 20, 40)
            note right of Orch: Multi-Step ReAct Agent Loop
            loop Max Iterations (Default: 5)
                Orch->>Agent: Step(state)
                Agent->>Mgr: Plan step (JSON tool action)
                Mgr-->>Agent: Action: tool_name, arguments
                Agent->>Tool: Execute action with validation
                Tool-->>Agent: Action observation result
                opt Action Failed
                    Agent->>Agent: Record failure fingerprint
                end
            end
            opt Generated Document (PDF/DOCX) Detected
                Orch->>Store: Register generated artifact into LocalFileStorage
                Store-->>Orch: file_id, download URI
            end
        end
    end

    Orch-->>API: TaskResponse (answer, events, citations, generated_files)
    API-->>UI: HTTP 200 OK (JSON payload)
    UI-->>User: Renders Answer, Citations, Download Cards & Inspector DAG
```

### 3.2 The Three Core Execution Modes

SAW avoids the overhead of executing a full agentic loop for simple questions while ensuring full agentic autonomy when complex multi-step reasoning or document generation is required.

#### Mode 1: `direct_answer`
- **Trigger Conditions:** Simple factual questions, industrial SOP lookups, general engineering inquiries, or semantic knowledge base queries without file modification requests.
- **Workflow:**
  1. Checks if `profile.requires_rag` is `True`.
  2. If RAG is required, queries `search_knowledge` tool for top-3 relevant context chunks.
  3. Synthesizes a local-context prompt injecting source citations (document name, page number).
  4. Dispatches the prompt to `qwen3:1.7b` (or explicit model override).
  5. Emits `CLASSIFYING` $\rightarrow$ `MODEL_SELECTING` $\rightarrow$ `GENERATING_OUTPUT` $\rightarrow$ `COMPLETED` events.
  6. Returns structured answer with citation metadata in under 2 seconds.

#### Mode 2: `code`
- **Trigger Conditions:** Explicit requests to generate Python functions, algorithms, boiler efficiency calculators, or data processing scripts.
- **Workflow:**
  1. Routes directly to the dedicated coding model: `qwen2.5-coder:1.5b`.
  2. Generates clean, well-commented Python code.
  3. Extracts the clean Python code block from markdown fences.
  4. If the user explicitly requested execution/testing (e.g., "write and test", "run in sandbox"), passes the code directly to `python_sandbox`.
  5. Appends the sandbox execution output or verification errors to the response.
  6. Emits checkpoints including sandbox execution status.

#### Mode 3: `agent`
- **Trigger Conditions:** Multi-step tasks, requests to generate files (`.pdf`, `.docx`), tasks requiring chaining multiple tools (e.g., "read report $\rightarrow$ extract findings $\rightarrow$ create summary PDF"), or complex industrial troubleshooting.
- **Workflow:**
  1. Initializes `AgentState` with a unique `run_id`, iteration counters, and detected file paths (`TaskContext`).
  2. Initiates the iterative ReAct loop.
  3. Synthesizes the final output from all tool observations.
  4. Automatically inspects generated documents on disk and indexes them into `LocalFileStorage`.
  5. Returns structured files, observations, and events.

### 3.3 ReAct Agent State Machine (Plan-Act-Observe-Recover)

The autonomous agent loop follows a deterministic state machine:

```mermaid
stateDiagram-v2
    [*] --> Initializing: process_task()
    Initializing --> Classifying: Task submitted
    Classifying --> Planning: Execution Mode == 'agent'
    
    state AgentLoop {
        Planning --> GeneratingPlan: Send state + tool schemas to LLM
        GeneratingPlan --> ParsingPlan: Extract JSON ToolAction
        ParsingPlan --> ValidatingAction: ToolValidator.validate()
        
        state ActionDecision <<choice>>
        ValidatingAction --> ActionDecision
        
        ActionDecision --> InterceptFailure: Matches Failure Fingerprint
        ActionDecision --> ExecutingTool: Validation Passed
        ActionDecision --> RecoveryFeedback: Validation Failed
        
        InterceptFailure --> RePlanning: Inject warning into prompt
        RecoveryFeedback --> RePlanning: Inject error schema observation
        
        ExecutingTool --> Observing: Capture tool stdout / return value
        Observing --> CheckingCompletion: Tool finished
        
        state CompletionCheck <<choice>>
        CheckingCompletion --> CompletionCheck
        CompletionCheck --> Completed: Document Created or Goal Met
        CompletionCheck --> RePlanning: More steps needed (Iterations < 5)
        CompletionCheck --> MaxIterationsExceeded: Iterations >= 5
        
        RePlanning --> Planning: Increment iteration counter
    }
    
    Completed --> RegisteringArtifacts: Scan observations for files
    RegisteringArtifacts --> [*]: Emit COMPLETED & Return TaskResponse
    MaxIterationsExceeded --> [*]: Emit FAILED & Return Partial State
```

### 3.4 Progress Event Checkpoint Lifecycle

To provide transparent observability without leaking sensitive prompt tokens or internal system secrets, SAW incorporates an execution checkpoint architecture.

The system defines **9 standard lifecycle stages**:

| Event Stage | Emitted When | Typical Statuses | Metadata Captured |
| :--- | :--- | :--- | :--- |
| `CLASSIFYING` | Task processing begins and classification completes | `STARTED`, `COMPLETED` | `task_type`, `complexity`, `execution_mode`, `requires_rag`, `requires_coding` |
| `MODEL_SELECTING` | Router determines which model to execute; also if fallback triggers | `STARTED`, `IN_PROGRESS`, `COMPLETED` | `selected_model`, `requested_model`, `fallback_used`, `fallback_reason` |
| `PLANNING` | Agent formulates execution steps for an iteration | `STARTED`, `COMPLETED` | `iteration`, `step_count`, `planned_tools` |
| `TOOL_EXECUTING` | A specific tool begins or completes execution | `STARTED`, `COMPLETED`, `FAILED` | `tool`, `arguments` (sanitized & truncated), `duration_seconds` |
| `OBSERVING` | Tool output is returned and formatted for the agent | `COMPLETED` | `tool`, `success` (boolean), `result_summary` |
| `REASONING` | Agent analyzes multi-turn observations prior to next plan | `IN_PROGRESS` | `iteration`, `analysis_summary` |
| `GENERATING_OUTPUT`| LLM begins synthesizing final user response or code block | `STARTED`, `COMPLETED` | `requires_rag`, `output_type` |
| `COMPLETED` | Overall task run finishes successfully | `COMPLETED` | `execution_mode`, `model`, `iterations`, `status` |
| `FAILED` | Task fails due to fatal planning error, timeout, or max iterations | `FAILED` | `status`, `iterations`, `error` |

#### Data Sanitization in Event Streams
Before any event is emitted to in-memory buffers or client SSE/REST endpoints:
- Chains of thought enclosed in `<think>...</think>` tags are stripped.
- Passwords, API tokens, and authorization credentials matching `(?i)(password|api_key|token|secret)` are replaced with `[REDACTED]`.
- Text arguments longer than 300 characters are safely truncated to prevent buffer flooding.

### 3.5 Failure Fingerprinting & Automatic Error Recovery

A primary vulnerability in autonomous LLM agents is the **hallucinatory loop**: when an action fails (e.g., due to an incorrect file path or invalid parameter name), smaller models frequently retry the exact same failing action repeatedly until iterations are exhausted.

SAW prevents this using the `RecoveryManager`:
1. **Fingerprint Calculation:** After every failed tool execution, a normalized fingerprint of the tool name and sorted arguments is computed:
   $$\text{Fingerprint} = \text{Hash}(\text{tool\_name} + \text{JSON}(\text{sorted\_arguments}))$$
2. **Loop Interception:** Before executing any action, the agent checks if its fingerprint matches any prior failure in `state.failure_fingerprints`.
3. **Repeated Action Prevention:** If a match is detected, the executor cancels execution and immediately returns an interception warning:
   ```text
   REPEATED FAILING ACTION DETECTED:
   The action 'pdf_reader' with arguments {'file_path': 'report.pdf'} already failed 
   previously in this run with error: 'File not found'.
   DO NOT repeat the exact same failing action. Correct the argument names, fix file paths, 
   or choose another valid approach.
   ```
4. **Self-Correction:** The agent planner reads this observation in the next iteration and dynamically corrects the path (e.g., prepending `inputs/report.pdf`) or chooses an alternative tool.

---

## 4. Multi-Model Dynamic Routing & Model Pool

### 4.1 Philosophy: Capability-Based Dynamic Dispatch

Monolithic LLM deployments suffer from clear tradeoffs:
- Large reasoning models (70B+) require massive GPU clusters, consume excessive power, and introduce high latency for simple operational queries.
- Small models (1B–3B) are fast and cost-effective, but struggle with complex multi-step planning and deep code generation.

SAW decouples the user request from any single model. Requests are mapped to **semantic capabilities**:
- `general`: Fast conversational inference, factual QA, direct answers.
- `reasoning`: Multi-step deduction, root-cause analysis, complex planning.
- `coding`: Python code synthesis, debugging, mathematical algorithms.
- `vision`: Image inspection, visual OCR, P&ID diagram analysis.
- `document`: Parsing structured contracts, forms, and technical specifications.

### 4.2 Local Model Ecosystem

The dynamic model pool is configured via `config/config.yaml` and loaded into the `ModelRegistry` upon startup:

```yaml
models:
  # 1. Primary Fast General & Simple Reasoning Model
  - id: "qwen3:1.7b"
    provider: "ollama"
    capabilities: ["general", "reasoning"]
    priority: 10
    enabled: true
    timeout: 180

  # 2. Hard Reasoning & Complex Multi-Step Analysis Model
  - id: "qwen3:4b"
    provider: "ollama"
    capabilities: ["reasoning"]
    priority: 20
    enabled: true
    timeout: 15

  # 3. Dedicated Python Coding Model
  - id: "qwen2.5-coder:1.5b"
    provider: "ollama"
    capabilities: ["coding"]
    priority: 15
    enabled: true
    timeout: 180

  # 4. Local Multimodal Vision & OCR Model
  - id: "qwen2.5vl:3b"
    provider: "ollama"
    capabilities: ["vision"]
    priority: 15
    enabled: true
    timeout: 180
```

### 4.3 Task Classification Engine

The `TaskClassifier` performs heuristic intent analysis on incoming prompts in **< 1 millisecond** with zero external network overhead.

Key heuristic patterns:
- **Vision Intent:** Scans for keywords (`scanned`, `diagram`, `chart`, `ocr`, `visual`, `photo`, `drawing`) or file extensions (`.png`, `.jpg`, `.jpeg`, `.tiff`, `.bmp`, `.webp`). Sets `requires_vision = True`.
- **Coding Intent:** Matches keywords (`write a python`, `def `, `class `, `python function`, `implement an algorithm`, `bug in python`). Sets `requires_coding = True` and `execution_mode = "code"`.
- **Sandbox Execution Intent:** Matches commands (`test the code`, `run the code`, `verify in sandbox`). Sets `metadata['run_sandbox'] = True`.
- **Multi-Step Document Intent:** Matches deliverable targets (`create a docx`, `make a pdf`, `generate approval note`, `inspection report`). Sets `requires_tools = True` and `execution_mode = "agent"`.
- **RAG Retrieval Intent:** Matches organizational knowledge queries (`according to manual`, `standard operating procedure`, `sop`, `specifications`, `guideline`). Sets `requires_rag = True`.

### 4.4 Routing Decision Matrix & Latency Safeguards

When `ModelRouter.route_task(profile)` evaluates a task:

1. **Target Capability Selection:**
   - If `requires_coding`: selects candidates matching `ModelCapability.CODING`.
   - If `requires_vision`: selects candidates matching `ModelCapability.VISION`.
   - If `complexity == "hard"`: selects dedicated reasoning models (e.g., `qwen3:4b`), applying a strict **15-second latency budget**.
   - Otherwise: selects general high-speed models (`qwen3:1.7b`).
2. **Priority Ordering:** Candidates are sorted by priority (lowest integer value = highest priority).
3. **Availability Verification:** The router checks whether the model is online in the local Ollama instance (`adapter.is_available()`).

### 4.5 Fallback Recovery Chain

If a model fails, times out, or is offline:
- **Offline Model Fallback:** If `qwen3:4b` is not installed or Ollama returns an error, the router logs a warning, emits a fallback event, and reroutes immediately to `qwen3:1.7b`.
- **Timeout Fallback:** If `qwen3:4b` exceeds its 15-second hard timeout budget during reasoning, the call is cleanly aborted and re-executed against `qwen3:1.7b`.
- **User Override:** Users can explicitly pin a model via the API or UI dropdown. If the requested model is offline, the API returns a clear 400 error explaining that the requested local model is unavailable.

---

## 5. Multimodal Knowledge Ingestion & RAG Pipeline

### 5.1 Supported Document Formats

SAW's ingestion subsystem (`IngestionPipeline`) processes structured, unstructured, and visual industrial documents:

```
[Raw Document / Image]
       |
       +---> PDF (.pdf) --------> PyMuPDF (fitz) Extractor
       +---> Word (.docx) ------> python-docx Extractor
       +---> Slides (.pptx) ----> python-pptx Extractor
       +---> Images (.png/.jpg)-> Local Vision Processor (Qwen2.5-VL)
```

### 5.2 Scanned Document Detection & Local Vision OCR

A critical failure point in standard RAG pipelines is encountering **scanned raster PDFs** (e.g., scanned inspection sheets, stamped permits). Standard text extractors return empty strings, causing silent retrieval failures.

SAW implements an automatic **scanned-PDF heuristic**:
1. PyMuPDF attempts standard text layer extraction.
2. If total extracted characters across the document average **less than 50 characters per page**, the document is classified as `is_scanned = True`.
3. The extractor renders each PDF page to an in-memory PNG pixmap at 150 DPI.
4. Each page pixmap is forwarded to the local vision model (`qwen2.5vl:3b` via `QwenVisionProcessor`).
5. The vision model executes optical character recognition and visual structure extraction:
   ```text
   [Page 1 Scanned Page Vision OCR]
   Header: Indian Oil Corporation - Refinery Equipment Inspection Sheet
   Equipment Tag: B-201 Atmospheric Boiler
   Observation: Flange weld seam shows micro-fissuring along heat-affected zone.
   Vibration Velocity: 7.2 mm/s RMS (Exceeds ISO 10816-3 Class II Limit).
   ```
6. The combined OCR text and visual layout descriptions are indexed into the knowledge base, enabling full semantic search over scanned documents.

### 5.3 Recursive Character Chunking

Extracted text is split into semantic chunks using the `RecursiveCharacterChunker`:
- **Default Chunk Size:** 500 characters.
- **Default Overlap:** 50 characters.
- **Hierarchy of Separators:** Paragraph breaks (`\n\n`), line breaks (`\n`), sentence terminators (`. `, `? `, `! `), and spaces (` `).
- Preserves document hierarchy and ensures that tables and numerical telemetry readings are not sliced mid-value.

### 5.4 Dense Embeddings & Vector Space

- **Model:** `BAAI/bge-m3` (Running locally via HuggingFace `sentence-transformers`).
- **Embedding Dimensions:** 1024-dimensional dense vectors.
- **L2 Normalization:** Enabled (`normalize_embeddings = True`), enabling fast cosine similarity calculation via inner product dot products.
- **Device Support:** Auto-detects NVIDIA CUDA if available; falls back to multicore CPU inference.
- **Mock Mode:** When running in demo mode, `MockEmbeddingModel` generates deterministic 1024-dimensional float vectors from string hashes without downloading neural weights.

### 5.5 ChromaDB Persistent Vector Store

- **Storage Location:** `./data/chroma/`
- **Default Collection:** `saw_knowledge` (configurable via `config.yaml`).
- **Persistence Engine:** Embedded DuckDB/Parquet vector index managed by ChromaDB.
- **Metadata Stored with Each Chunk:**
  - `doc_id`: Unique UUID linking to SQLite `documents` table.
  - `filename`: Original document name (e.g., `ISO_10816_Vibration_Standard.pdf`).
  - `source_path`: Absolute path on the host system.
  - `file_type`: `pdf`, `docx`, `pptx`, or `image`.
  - `page_number`: 1-based page index.
  - `chunk_index`: Sequential integer index within the document.
  - `content_hash`: SHA-256 hash of the source document.

### 5.6 SQLite Metadata Indexing & Deduplication

Before any file is chunked or embedded:
1. The SHA-256 hash of the binary file is calculated.
2. The database is queried: `SELECT id FROM documents WHERE content_hash = ?`.
3. If a match exists, ingestion skips re-indexing, preventing duplicate vectors from polluting search results.
4. Upon successful embedding, the document metadata is committed to the SQLite `documents` table with timestamp and size.

---

## 6. Local Tools & Isolated Execution Sandbox

### 6.1 Tool Registry Architecture

Every tool available to the agent inherits from `BaseTool` (`app/tools/base.py`) and is registered in the centralized `ToolRegistry`.

```python
class BaseTool(ABC):
    @property
    @abstractmethod
    def name(self) -> str: ...

    @property
    @abstractmethod
    def description(self) -> str: ...

    @property
    @abstractmethod
    def parameters(self) -> dict[str, dict[str, Any]]: ...

    @abstractmethod
    def execute(self, **kwargs: Any) -> Any: ...
```

Tools expose dynamic JSON schema definitions that are injected directly into the planner's system prompt during ReAct loops.

### 6.2 Python Sandbox & AST Static Security Gate

SAW includes a local, isolated Python code execution environment (`PythonSandboxTool`). To safeguard the host system without relying on heavy external hypervisors, the tool implements a **two-layer defence**:

#### Layer 1: AST (Abstract Syntax Tree) Static Code Gate
Before code is written to disk or executed, Python's built-in `ast` module parses the code into an abstract syntax tree and traverses all nodes:
- **Network Module Rejection:** Rejects any imports of network or socket libraries:
  `socket`, `urllib`, `requests`, `httpx`, `http`, `ftplib`, `smtplib`, `paramiko`, `telnetlib`, `xmlrpc`.
- **Subprocess & Shell Rejection:** Rejects any invocation of operating system shell commands:
  `subprocess`, `os.system`, `os.popen`, `os.spawn*`, `os.exec*`, `os.fork`.
- **Dynamic Import Rejection:** Blocks `importlib` and `__import__`.
- **Path Escape Rejection:** Detects and rejects directory traversal tokens (`../`, `..\\`).

#### Layer 2: Subprocess Process Boundary
- The validated script is written to a temporary file inside `./sandbox/temp/`.
- Execution is spawned as an isolated child process (`sys.executable -u <script>`).
- **Working Directory:** Strictly set to `./sandbox/workspace/`.
- **Environment Isolation:** Strips shell access and isolates path variables.
- **Execution Timeout:** Enforces a strict timeout (default: 10 seconds). If a script enters an infinite loop, the child process is terminated immediately.
- Captures combined `stdout` and `stderr` up to 10,000 characters.

### 6.3 Document Synthesis: PDF & DOCX Creators

SAW enables agents to synthesize professional documents for plant managers and engineering leads.

#### `PDFCreatorTool` (ReportLab Engine)
- Saves to specified `output_path` (e.g., `outputs/approval_note.pdf`).
- Configures standard Letter page geometry with 72pt (1 inch) margins.
- Applies clean typographical styles (Title: 24pt, Body: 11pt with 14pt leading).
- Escapes XML markup entities automatically to prevent ReportLab parsing crashes.
- Automatically registers generated files into `LocalFileStorage` so they appear as instant download cards in the UI.

#### `DOCXCreatorTool` (python-docx Engine)
- Generates Microsoft Word `.docx` documents.
- Creates hierarchical heading structures (`Heading 1`, `Heading 2`).
- Formats paragraphs, bulleted recommendation lists, and telemetry tables.
- Automatically registers created documents into managed file storage.

### 6.4 Knowledge Search & File Inspection Tools

- **`search_knowledge`:** Queries ChromaDB using BGE-M3 embeddings, returning top-$k$ contextual excerpts with document source, page number, and similarity score.
- **`read_file`:** Safely reads plain text, Markdown, CSV, or configuration files from the project directory. Enforces size boundaries (8,000 characters) to avoid overwhelming model context windows.
- **`pdf_reader`:** Extracts raw text layers from PDF files using PyMuPDF page-by-page.

### 6.5 Parameter Validation & Auto-Aliasing Engine

LLMs frequently generate minor variations in parameter naming (e.g., writing `filepath` or `path` instead of `file_path`, or `save_path` instead of `output_path`).

The `ToolValidator` provides an auto-aliasing layer:

```python
PARAM_ALIASES = {
    "file_path": ["path", "filepath"],
    "output_path": ["output_file", "save_path", "target_path"],
    "query": ["search_query", "q"],
    "code": ["script", "python_code"],
}
```

If an LLM uses a known alias, the validator transparently maps it to the canonical parameter name. If a truly invalid or missing parameter is detected, the validator catches it **before** tool execution and injects an actionable schema error back into the agent's observation history.

---

## 7. Data Architecture & Storage Subsystem

### 7.1 Managed Local File Storage

Managed file storage is implemented in `LocalFileStorage` (`app/storage/local.py`). It manages user-uploaded documents and agent-generated artifacts inside `./data/files/`.

Every file stored receives:
- A unique UUID `file_id`.
- An isolated physical filename: `{file_id}_{sanitized_original_filename}`.
- A sidecar JSON metadata descriptor inside `./data/files/.meta/{file_id}.json`.
- A relational entry in the SQLite `files` table.

### 7.2 Path Traversal & Windows Device Sanitization

To ensure security across Windows and Linux deployments, `LocalFileStorage` sanitizes every incoming filename:
- **Path Traversal Defense:** Strips all directory navigation characters (`/`, `\`, `..`), extracting only the pure base filename.
- **Prohibited Null Bytes:** Immediate rejection if `\0` is detected.
- **Windows Reserved Names Neutralization:** Windows reserves names such as `CON`, `PRN`, `AUX`, `NUL`, `COM1-COM9`, and `LPT1-LPT9`. If an uploaded file is named `CON.pdf` or `aux.txt`, the storage engine renames it to `safe_CON.pdf` to prevent operating system file lockup.
- **Length Bounding:** Truncates excessive filenames to a maximum of 255 characters while preserving the extension.

### 7.3 Relational Database Schema (SQLite)

The local SQLite database (`data/soar.db`) maintains complete relational tracking:

```mermaid
erDiagram
    DOCUMENTS {
        TEXT id PK
        TEXT filename
        TEXT source_path
        TEXT file_type
        INTEGER file_size
        TEXT content_hash UK
        TIMESTAMP created_at
    }

    FILES {
        TEXT id PK
        TEXT original_filename
        TEXT stored_filename
        TEXT file_type
        INTEGER file_size
        TEXT content_hash
        TEXT mime_type
        TEXT storage_path
        TIMESTAMP created_at
    }

    AGENT_RUNS {
        TEXT id PK
        TEXT task
        TEXT model_used
        TEXT status
        TIMESTAMP started_at
        TIMESTAMP completed_at
    }

    AGENT_STEPS {
        TEXT id PK
        TEXT run_id FK
        INTEGER iteration
        TEXT tool
        TEXT arguments
        TEXT result
        TEXT status
        TIMESTAMP created_at
    }

    AUDIT_LOGS {
        TEXT id PK
        TIMESTAMP timestamp
        TEXT event
        TEXT component
        TEXT details
    }

    AGENT_RUNS ||--o{ AGENT_STEPS : "contains"
```

#### Schema DDL Specifications

```sql
-- Knowledge Base Ingested Documents
CREATE TABLE IF NOT EXISTS documents (
    id TEXT PRIMARY KEY,
    filename TEXT NOT NULL,
    source_path TEXT NOT NULL,
    file_type TEXT NOT NULL,
    file_size INTEGER NOT NULL,
    content_hash TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Managed File Storage
CREATE TABLE IF NOT EXISTS files (
    id TEXT PRIMARY KEY,
    original_filename TEXT NOT NULL,
    stored_filename TEXT NOT NULL,
    file_type TEXT NOT NULL,
    file_size INTEGER NOT NULL,
    content_hash TEXT NOT NULL,
    mime_type TEXT,
    storage_path TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Agent Execution Runs
CREATE TABLE IF NOT EXISTS agent_runs (
    id TEXT PRIMARY KEY,
    task TEXT NOT NULL,
    model_used TEXT,
    status TEXT NOT NULL,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP
);

-- Granular Agent Steps
CREATE TABLE IF NOT EXISTS agent_steps (
    id TEXT PRIMARY KEY,
    run_id TEXT NOT NULL REFERENCES agent_runs(id) ON DELETE CASCADE,
    iteration INTEGER NOT NULL,
    tool TEXT NOT NULL,
    arguments TEXT,
    result TEXT,
    status TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Security and Operational Audit Logs
CREATE TABLE IF NOT EXISTS audit_logs (
    id TEXT PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    event TEXT NOT NULL,
    component TEXT NOT NULL,
    details TEXT
);
```

### 7.4 Audit Logging & Compliance Trails

Every document uploaded, tool executed, and configuration change is recorded in the `audit_logs` table. In sensitive facilities, security auditors can inspect this table to confirm:
- Exactly which operator ran which task.
- Which documents were accessed or synthesized.
- Confirmation that zero outbound network requests occurred.

---

## 8. Complete REST API Specification

### 8.1 API Conventions & Architecture

- **Base URL:** `http://127.0.0.1:8000`
- **Protocol:** HTTP/1.1 REST
- **Payload Format:** JSON (`application/json`)
- **File Upload Format:** Multipart Form (`multipart/form-data`)
- **Documentation:** Interactive OpenAPI Swagger documentation available at `http://127.0.0.1:8000/docs`

### 8.2 Endpoints Reference

| Method | Endpoint | Description | Request Body | Response Body |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/api/health` | Health & operational status check | None | `HealthResponse` |
| `POST` | `/api/tasks` | Execute task with dynamic routing | `TaskRequest` | `TaskResponse` |
| `GET` | `/api/tasks/{run_id}/events`| Retrieve progress checkpoint ledger | None | `TaskEventsResponse`|
| `POST` | `/api/files/upload` | Upload file to managed storage | `file` (Binary Form) | `FileMetadataResponse`|
| `GET` | `/api/files` | List managed files (with pagination) | Query: `limit`, `offset` | `FileListResponse` |
| `GET` | `/api/files/{file_id}` | Retrieve metadata for a file | None | `FileMetadataResponse`|
| `GET` | `/api/files/{file_id}/download`| Download binary file stream | None | Binary Stream |
| `DELETE`| `/api/files/{file_id}` | Delete file & metadata | None | `FileDeleteResponse` |
| `GET` | `/api/models` | List configured models & statuses | None | `ModelListResponse` |

### 8.3 Data Transfer Objects & Schemas

#### `POST /api/tasks`
**Request Payload (`TaskRequest`):**
```json
{
  "task": "Extract vibration readings from uploaded inspection sheet and create an approval note in PDF format.",
  "model": null,
  "run_id": "9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d",
  "attached_file_ids": ["d7c72f20-d0bc-4ed0-a88d-f3d1707c9aec"]
}
```

**Response Payload (`TaskResponse`):**
```json
{
  "run_id": "9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d",
  "status": "completed",
  "answer": "Inspection analysis complete. Abnormal vibration of 7.2 mm/s RMS identified on Boiler B-201. Formal approval note generated and saved.",
  "model": "qwen3:1.7b",
  "execution_mode": "agent",
  "citations": [],
  "model_details": {
    "requested": "qwen3:1.7b",
    "actual": "qwen3:1.7b",
    "fallback_used": false,
    "fallback_reason": null
  },
  "events": [
    {
      "event_id": "e-1",
      "stage": "CLASSIFYING",
      "status": "COMPLETED",
      "message": "Task classified",
      "timestamp": "2026-09-29T14:40:00Z",
      "metadata": {
        "execution_mode": "agent",
        "requires_tools": true
      }
    },
    {
      "event_id": "e-2",
      "stage": "TOOL_EXECUTING",
      "status": "COMPLETED",
      "message": "Creating PDF document at outputs/approval_note.pdf",
      "timestamp": "2026-09-29T14:40:03Z",
      "metadata": {
        "tool": "pdf_creator",
        "duration_seconds": 0.42
      }
    },
    {
      "event_id": "e-3",
      "stage": "COMPLETED",
      "status": "COMPLETED",
      "message": "Task completed",
      "timestamp": "2026-09-29T14:40:05Z",
      "metadata": {
        "iterations": 2,
        "status": "completed"
      }
    }
  ],
  "generated_files": [
    {
      "file_id": "a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d",
      "filename": "approval_note.pdf",
      "mime_type": "application/pdf"
    }
  ]
}
```

#### `GET /api/models`
**Response Payload (`ModelListResponse`):**
```json
{
  "default_model": "qwen3:1.7b",
  "models": [
    {
      "id": "qwen3:1.7b",
      "provider": "ollama",
      "capabilities": ["general", "reasoning"],
      "priority": 10,
      "enabled": true,
      "available": true,
      "timeout": 180.0
    },
    {
      "id": "qwen3:4b",
      "provider": "ollama",
      "capabilities": ["reasoning"],
      "priority": 20,
      "enabled": true,
      "available": true,
      "timeout": 15.0
    },
    {
      "id": "qwen2.5-coder:1.5b",
      "provider": "ollama",
      "capabilities": ["coding"],
      "priority": 15,
      "enabled": true,
      "available": true,
      "timeout": 180.0
    },
    {
      "id": "qwen2.5vl:3b",
      "provider": "ollama",
      "capabilities": ["vision"],
      "priority": 15,
      "enabled": true,
      "available": true,
      "timeout": 180.0
    }
  ]
}
```

### 8.4 HTTP Status Codes & Error Formats

Uniform error responses are guaranteed across the application:
```json
{
  "error": "validation_error",
  "message": "Invalid request payload format.",
  "details": [
    {
      "loc": ["body", "task"],
      "msg": "field required",
      "type": "value_error.missing"
    }
  ]
}
```

| HTTP Status | Reason | Trigger Conditions |
| :--- | :--- | :--- |
| `200 OK` | Success | Normal task execution, file list, download, health check |
| `400 Bad Request` | Storage / Parameter Error | Path traversal attempt, file exceeds 50 MB, invalid file ID |
| `404 Not Found` | Resource Missing | Non-existent `file_id` or non-existent `run_id` |
| `422 Unprocessable`| Pydantic Validation | Missing required JSON fields, empty prompt strings |
| `500 Internal Error`| Server Exception | Uncaught runtime error, sandbox process failure |

---

## 9. Frontend User Interface & User Experience

### 9.1 UI Architecture & Tech Stack

The SAW presentation layer is built with modern, industrial-grade web technologies:
- **Framework:** Next.js 16 (App Router) + React 19 + TypeScript.
- **Styling:** Tailwind CSS v4 with custom dark sovereign color tokens (`#0D120F` background, `#202A22` borders, `#B8F23D` industrial lime accent, `#F1F5ED` primary text).
- **Animations & Layout:** Framer Motion for smooth panel transitions and layout reflows.
- **Iconography:** Lucide React icons.
- **Persistence:** Client-side synchronized local storage with custom event broadcasting (`saw-store-change`).

### 9.2 Conversational Chat & Multi-Session System

The primary workspace (`frontend/components/chat/ChatInterface.tsx`):
- **ChatGPT / Claude-Style Multi-Chat:** Supports creating, renaming, searching, and deleting multiple chat sessions (`ChatSession`).
- **Context Injection:** Drag-and-drop or paperclip file attachment uploading directly to `/api/files/upload`. File IDs are passed with prompts.
- **Dynamic Model Switcher:** Real-time dropdown displaying local models with capability tags (`General`, `Reasoning`, `Coder`, `Vision`), priority indicators, and live availability badges.
- **Markdown & Code Rendering:** Full GitHub-flavored markdown with code syntax highlighting, copy-to-clipboard buttons, and collapsible thought process panels.
- **Instant Document Cards:** Any file synthesized by the agent (`pdf_creator`, `docx_creator`) renders as an interactive `GeneratedFileCard` with direct download action.

### 9.3 Real-Time Run Inspector & DAG Visualization

The Run Inspector (`frontend/components/inspector/RunInspector.tsx`) is a standout sovereign feature:
- Collapsible right-hand panel visualizing the **live Execution DAG**.
- Connects stages (`CLASSIFYING` $\rightarrow$ `MODEL_SELECTING` $\rightarrow$ `PLANNING` $\rightarrow$ `TOOL_EXECUTING` $\rightarrow$ `OBSERVING` $\rightarrow$ `REASONING` $\rightarrow$ `GENERATING_OUTPUT` $\rightarrow$ `COMPLETED`).
- Renders animated pulsing connecting lines (`PipelineConnectingLine.tsx`) between active stages.
- Displays step-by-step tool invocation parameters, duration counters, and observation summaries.

```
+-------------------------------------------------------------+
| RUN INSPECTOR (Run: 9b1deb4d...)               [x] Close    |
| Status: Completed | Duration: 4.82s | Model: qwen3:1.7b     |
+-------------------------------------------------------------+
|   [✓] Task Classification                                   |
|       Mode: agent | Complexity: medium | Requires Tools     |
|         │                                                   |
|   [✓] Model Selection                                       |
|       Selected: qwen3:1.7b (Priority: 10)                   |
|         │                                                   |
|   [✓] Planning (Iteration 1)                                |
|       Plan: read_file -> pdf_creator                        |
|         │                                                   |
|   [✓] Tool Execution                                        |
|       pdf_creator(output_path='outputs/approval.pdf')       |
|         │                                                   |
|   [✓] Observation                                           |
|       Document successfully created (24,180 bytes)          |
|         │                                                   |
|   [✓] Task Completed                                        |
+-------------------------------------------------------------+
```

### 9.4 Workspace Navigation & Document Management

The navigation sidebar (`Sidebar.tsx`) provides access to dedicated workspaces:
- **Chat (`/app`):** Primary agentic workspace and inspector.
- **Files (`/app/files`):** Managed document repository. Upload, view SHA-256 hashes, inspect MIME types, download, or delete.
- **Knowledge (`/app/knowledge`):** RAG vector database inspection. View collections (`saw_knowledge`, `iso_standards`), chunk statistics, and test semantic retrieval.
- **Models (`/app/models`):** Local model pool health matrix. Displays memory usage, Ollama connectivity, timeouts, and capability matrices.
- **Tools (`/app/tools`):** Registered tool directory showing parameters and schemas for `python_sandbox`, `pdf_creator`, `docx_creator`, and `search_knowledge`.
- **Settings (`/app/settings`):** Read-only inspection of active `config.yaml` parameters and host diagnostics.

---

## 10. Centralized Configuration System

### 10.1 Configuration Structure & Hierarchy

SAW uses a single, centralized configuration file: `backend/config/config.yaml`. Relative paths resolve automatically relative to the backend root directory.

```
config/config.yaml
       ↓
app/config/loader.py (YAML Parsing + Strict Path Resolution)
       ↓
app/config/schema.py (Typed SOARConfig Dataclasses)
       ↓
ModelManager / Storage / ChromaDB / SQLite / Agent
```

### 10.2 Modifying & Adding Models

To add an open-weight model (e.g., `deepseek-coder:6.7b` for advanced coding):

1. **Pull the model locally via Ollama:**
   ```bash
   ollama pull deepseek-coder:6.7b
   ```
2. **Add the entry to `backend/config/config.yaml`:**
   ```yaml
   models:
     - id: "deepseek-coder:6.7b"
       provider: "ollama"
       capabilities:
         - "coding"
       priority: 5
       enabled: true
       timeout: 180
   ```
3. **Restart SAW.** The `ModelRouter` immediately discovers the model, registers its capabilities, and prioritizes it for all coding tasks without modifying a single line of Python source code.

### 10.3 Environmental Overrides

The configuration path can be overridden at runtime via the environment variable `SOAR_CONFIG_PATH`:

```bash
# Run in Demo Mode
export SOAR_CONFIG_PATH="config/config.demo.yaml"
python -m uvicorn app.main:app --port 8000

# Or via CLI flag
python app/main.py --demo
```

---

## 11. Installation, Deployment & Air-Gap Verification Guide

### 11.1 Hardware Sizing & System Prerequisites

#### Recommended Hardware Specifications

| Deployment Profile | Minimum (Demo / CPU) | Recommended (Production Workstation) | Enterprise Sovereign Server |
| :--- | :--- | :--- | :--- |
| **CPU** | 4 Cores (Intel i5 / AMD Ryzen 5) | 8+ Cores (Intel i7 / Ryzen 7) | 16+ Cores (AMD EPYC / Intel Xeon) |
| **RAM** | 8 GB | 32 GB DDR4/DDR5 | 64 GB+ ECC RAM |
| **GPU (VRAM)** | None (Zero GPU Mode) | NVIDIA RTX 4060/4070 (8–12 GB VRAM) | NVIDIA RTX A6000 / A100 (24–40 GB) |
| **Storage** | 10 GB Free SSD | 100 GB NVMe SSD | 500 GB NVMe SSD |
| **OS** | Windows 10/11, Ubuntu 22.04+ | Windows 11, Ubuntu 22.04 LTS | Ubuntu 22.04 / RHEL 9 |

#### Software Prerequisites
- **Python:** Version 3.10, 3.11, or 3.12 (with `venv`).
- **Node.js:** Version 18.x, 20.x, or 22.x (with `npm`).
- **Ollama:** Version 0.3.0+ (Required for Real Mode only).

---

### 11.2 Production Real Mode Installation

#### Step 1: Install & Start Ollama
Download and install Ollama from `https://ollama.com`. Start the local service:
```bash
ollama serve
```

#### Step 2: Pull Required Sovereign Models
In a terminal, pull the open-weight model suite:
```bash
# 1. Primary fast general & reasoning model (1.7B)
ollama pull qwen3:1.7b

# 2. Hard reasoning model (4B)
ollama pull qwen3:4b

# 3. Dedicated Python coding model (1.5B)
ollama pull qwen2.5-coder:1.5b

# 4. Multimodal vision and OCR model (3B)
ollama pull qwen2.5vl:3b
```

#### Step 3: Configure Backend Python Virtual Environment
Navigate to the `backend/` directory:
```bash
cd backend

# Create virtual environment
python -m venv .venv

# Activate virtual environment
# Windows:
.venv\Scripts\activate
# Linux / macOS:
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

#### Step 4: Configure Frontend Dependencies
Navigate to the `frontend/` directory:
```bash
cd ../frontend
npm install
```

#### Step 5: Launch the Complete Application
You can use the automated launcher:
- **Windows:** Double-click or run `RunScripts\run.bat`.
- **Linux/macOS:** Run `bash RunScripts/run.sh`.

Or start the services manually:
```bash
# Terminal 1 - Backend:
cd backend
.venv\Scripts\activate
python -m uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload

# Terminal 2 - Frontend:
cd frontend
npm run dev
```

Access the UI at `http://localhost:3000`.

---

### 11.3 Demo Mode Installation (Zero GPU / Zero Ollama)

To run SAW on a standard laptop without downloading any LLM models or installing Ollama:

1. Follow Step 3 & Step 4 above to install Python and npm packages.
2. Launch the demo script:
   - **Windows:** Double-click `RunScripts\run_demo.bat`.
   - **Linux/macOS:** Run `bash RunScripts/run_demo.sh`.
3. The demo launcher sets `SOAR_CONFIG_PATH=config/config.demo.yaml`. The entire workbench starts instantly with simulated models, mock embeddings, and zero GPU overhead.

---

### 11.4 Launcher Scripts Breakdown

The repository includes four dedicated launcher scripts inside `RunScripts/`:

1. `RunScripts/run.bat` (Windows Real Mode):
   - Verifies Python venv exists at `backend\.venv`.
   - Sends HTTP health probe to `http://localhost:11434/api/version` to ensure Ollama is running.
   - Verifies `frontend\node_modules` exists (runs `npm install` if missing).
   - Starts Backend on `http://127.0.0.1:8000` with `SOAR_CONFIG_PATH=config/config.yaml`.
   - Starts Frontend on `http://localhost:3000`.
   - Opens the default browser to `http://localhost:3000`.

2. `RunScripts/run_demo.bat` (Windows Demo Mode):
   - Skips Ollama checks entirely.
   - Starts Backend with `SOAR_CONFIG_PATH=config/config.demo.yaml`.
   - Starts Frontend dev server.
   - Opens browser automatically.

3. `RunScripts/run.sh` & `RunScripts/run_demo.sh`:
   - Exact Unix shell equivalents supporting Linux and macOS environments.

---

### 11.5 Air-Gap Verification & Network Isolation Audit

To demonstrate and verify total sovereignty for defence or PSU compliance audits:

1. **Physical Disconnect:** Disconnect the physical Ethernet cable and disable Wi-Fi/Bluetooth adapters on the host machine.
2. **Local Address Binding:** Confirm in `config.yaml` that all services bind strictly to loopback:
   - API: `127.0.0.1:8000`
   - Frontend: `localhost:3000`
   - Ollama: `127.0.0.1:11434`
3. **Network Socket Monitoring:**
   Open an administrative terminal and run socket monitoring:
   ```powershell
   # Windows PowerShell:
   Get-NetTCPConnection | Where-Object { $_.LocalPort -in 8000, 3000, 11434 }
   
   # Linux:
   ss -tulpn | grep -E ':(8000|3000|11434)'
   ```
   *Verification:* All active sockets show state `Listen` bound strictly to `127.0.0.1`.
4. **Packet Capture Audit:** Run Wireshark or `tcpdump -i any -n` while executing complex agent tasks, document generation, and RAG searches.
   *Verification:* Zero outbound packets generated outside the loopback interface (`lo` / `127.0.0.1`).

---

## 12. Testing, Benchmarking & Quality Assurance

### 12.1 Backend Test Suite Overview

SAW includes **36 specialized test suites and benchmarks** in `backend/test_cases/` validating every subsystem:

| Test Suite File | Subsystem Tested | Key Verifications |
| :--- | :--- | :--- |
| `test_api.py` | FastAPI REST Endpoints | Route status codes, payload serialization, task submissions |
| `test_agent.py` | ReAct Agent Loop | Plan-act-observe iteration limits, recovery on errors |
| `test_agent_argument_reliability.py` | Tool Calling Reliability | Robustness against misspelled arguments and bad parameters |
| `test_task_classifier.py` | Task Classification | Deterministic routing heuristics for coding, RAG, vision, tools |
| `test_model_router.py` | Model Router | Capability matching, priority resolution, fallback triggering |
| `test_model_routing.py` | Routing Latency & Timeouts | Hard timeout enforcement (15s for 4B) and fallback to 1.7B |
| `test_python_sandbox.py` | Code Sandbox Security | AST rejection of socket, requests, subprocess, path escapes |
| `test_pdf_creator.py` | PDF Document Generation | ReportLab layout, margin bounding, XML escaping, file saving |
| `test_docx_creator.py` | Word Document Generation | Heading hierarchy, table generation, disk persistence |
| `test_pdf_reader.py` | PDF Extraction | PyMuPDF text layer reading, handling encrypted PDFs |
| `test_image_ingestion.py` | Multimodal Vision | Base64 image encoding, OCR extraction, diagram descriptions |
| `test_ingestion.py` | Ingestion Pipeline | End-to-end extraction across PDF, DOCX, PPTX, image files |
| `test_storage.py` | Managed File Storage | Path traversal rejection, Windows device names, SHA-256 |
| `test_database.py` | SQLite Repository | Relational CRUD for documents, files, runs, steps, audit logs |
| `test_events.py` | Progress Event Emitter | Chronological ordering, sanitization of passwords and thoughts |
| `test_config.py` | Centralized Configuration | YAML parsing, relative path resolution, dataclass typing |
| `verify_demo.py` | Demo Mode Quickstart | Zero-GPU verification, mock models, deterministic outputs |

### 12.2 Model Routing Benchmarks

`backend/test_cases/benchmark_model_routing.py` benchmarks the dispatch latency and throughput of the dynamic model pool.
- **Classification Latency:** Measured at **< 0.8 ms** per task.
- **Direct Answer Dispatch:** < 1.5 seconds average latency on `qwen3:1.7b`.
- **Reasoning Dispatch with 15s Budget:** Confirms that if `qwen3:4b` exceeds 15 seconds, the fallback to `qwen3:1.7b` executes within 200 ms without user-visible exceptions.

### 12.3 Vision OCR Benchmarks

`backend/test_cases/benchmark_vision.py` evaluates scanned document extraction:
- Standard 150 DPI document page rendered and OCR-processed in **1.8–3.2 seconds** on NVIDIA RTX 40-series hardware.
- Scanned text accuracy exceeds 96% on standard industrial inspection checklists and pump telemetry tables.

### 12.4 Running Tests Locally

To execute the test suite:
```bash
cd backend
.venv\Scripts\activate

# Run all unit tests
python -m unittest discover -s test_cases -p "test_*.py"

# Run smoke test for RAG pipeline
python test_cases/smoke_test_rag.py

# Verify Demo Mode
python test_cases/verify_demo.py
```

---

## 13. Security, Governance & Compliance

### 13.1 Air-Gap Isolation Guarantee

SAW is architecturally incapable of leaking data to external servers:
1. **No External SDKs:** No cloud AI provider libraries (OpenAI, Anthropic, Google GenAI, LangChain cloud connectors) exist in dependencies.
2. **Hardcoded Localhost:** All HTTP clients connect strictly to `127.0.0.1` or `localhost`.
3. **Application Security Flag:** `security.allow_external_network: false` is asserted at the configuration level.

### 13.2 Memory & Storage Sanitization

- **No Ephemeral Cloud Caches:** All intermediate reasoning, document extracts, and vector embeddings reside on local disk in directories owned and managed by the operating organization.
- **Audit Deletion:** Deleting a file via `DELETE /api/files/{file_id}` physically unlinks the binary file from disk, deletes its JSON metadata descriptor, and purges the database entry.

### 13.3 Subprocess Isolation Policy

The Python sandbox enforces strict segregation:
- **No System-Wide Installs:** Scripts cannot run `pip install` or alter host Python environments.
- **No Shell Escapes:** System shell (`cmd.exe`, `powershell`, `/bin/sh`) is inaccessible from sandbox scripts.
- **Resource Limits:** Execution times out at 10 seconds; runaway memory consumption triggers OS-level child process termination.

---

## 14. Troubleshooting & Frequently Asked Questions (FAQ)

### Q1: Ollama returns "connection refused" on port 11434
**Resolution:**
1. Verify Ollama is running:
   ```bash
   ollama list
   ```
2. If the service is stopped, launch it:
   ```bash
   ollama serve
   ```
3. If running on Windows, verify that your local security software or Windows Defender Firewall is not blocking loopback connections on port 11434.

---

### Q2: "Requested model is offline or not installed in Ollama"
**Resolution:**
The requested model tag has not been downloaded into your local Ollama library. Run the pull command:
```bash
ollama pull qwen3:1.7b
ollama pull qwen3:4b
ollama pull qwen2.5-coder:1.5b
ollama pull qwen2.5vl:3b
```
To verify installed models: `ollama list`.

---

### Q3: How do I run SAW on a machine without a dedicated GPU?
**Resolution:**
You have two options:
1. **CPU Inference in Real Mode:** Ollama automatically detects if no GPU is present and falls back to multi-threaded CPU inference. Ensure you allocate at least 16 GB of system RAM.
2. **Demo Mode:** Launch using `RunScripts\run_demo.bat` (or `python app/main.py --demo`). Demo mode runs on any dual-core computer with zero GPU usage and zero model downloads.

---

### Q4: PyMuPDF or fitz import errors during PDF ingestion
**Resolution:**
Ensure PyMuPDF is installed in your active Python virtual environment:
```bash
cd backend
.venv\Scripts\activate
pip install PyMuPDF
```

---

### Q5: Can I connect SAW to an internal corporate network?
**Resolution:**
Yes. To allow other authorized workstations on your private intranet to access the workbench:
1. Edit `backend/config/config.yaml`:
   ```yaml
   api:
     host: "0.0.0.0"
     port: 8000
   ```
2. In `frontend/.env.local`:
   ```env
   NEXT_PUBLIC_API_URL=http://<YOUR_INTERNAL_IP>:8000
   ```
3. Run the frontend with `npm run dev -- -H 0.0.0.0`.
*Note: Maintain hardware firewall rules preventing any egress from this host to the public internet.*

---

## 15. Summary & Project Roadmap

| Milestone | Status | Key Deliverables |
| :--- | :--- | :--- |
| **Milestone 1: Core Agentic Engine** | **Completed** | Dynamic Model Router, ReAct Loop, Tool Registry, Recovery Manager |
| **Milestone 2: Multimodal RAG** | **Completed** | Scanned PDF Vision OCR, BGE-M3 Embeddings, ChromaDB, SQLite |
| **Milestone 3: REST API & Storage** | **Completed** | FastAPI Gateway, Path Traversal Defense, Managed Storage Engine |
| **Milestone 4: Sovereign UI Workbench** | **Completed** | Next.js 16 UI, Run Inspector DAG, Multi-Chat Sessions, File Cards |
| **Milestone 5: Production Hardening** | **Current** | 36 Unit Test Suites, Routing Benchmarks, Air-Gap Compliance Docs |
| **Future: Distributed Air-Gap Mesh** | *Planned* | Multi-node local inference clustering, quantized 70B models, local LLM fine-tuning |

---

*End of SAW Technical Documentation Report.*
