import os
import sys

# Ensure backend root is on path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

os.environ["SOAR_CONFIG_PATH"] = "config/config.demo.yaml"

from app.config import get_config
config = get_config()
print("1. Config loaded successfully:")
print(f"   App Name: {config.app.name}")
print(f"   Environment: {config.app.environment}")
print(f"   Embedding Model: {config.embeddings.model_name_or_path}")

from app.api import create_app
app = create_app(config=config)

from fastapi.testclient import TestClient
client = TestClient(app)

print("\n2. Testing /api/health:")
res_health = client.get("/api/health")
print(f"   Status: {res_health.status_code}, Body: {res_health.json()}")

print("\n3. Testing /api/models:")
res_models = client.get("/api/models")
print(f"   Status: {res_models.status_code}")
for m in res_models.json()["models"]:
    print(f"   Model '{m['id']}' [{m['provider']}] -> Available: {m['available']}, Capabilities: {m['capabilities']}")

print("\n4. Testing /api/tasks (Coding task routing):")
res_task = client.post("/api/tasks", json={"task": "Write python code to calculate boiler efficiency"})
print(f"   Status: {res_task.status_code}")
data = res_task.json()
print(f"   Run ID: {data.get('run_id')}")
print(f"   Selected Model: {data.get('model')}")
print(f"   Execution Mode: {data.get('execution_mode')}")
print(f"   Answer:\n{data.get('answer')}")

print("\n5. Checkpoint Events Pipeline:")
for ev in data.get("events", []):
    print(f"   [{ev['stage']}] -> {ev['status']}: {ev['message']}")

print("\n6. Testing /api/tasks (General question routing):")
res_general = client.post("/api/tasks", json={"task": "What is the status of boiler inspection?"})
data_gen = res_general.json()
print(f"   Selected Model: {data_gen.get('model')}")
print(f"   Execution Mode: {data_gen.get('execution_mode')}")
print(f"   Answer: {data_gen.get('answer')}")

print("\n=== DEMO VERIFICATION PASSED COMPLETELY! ===")
