import requests
import json
import sys

BASE_URL = "https://prey.wtf"
ADMIN_USER = "admin"
ADMIN_PASS = "Bright-9261387538246"

def login(username, password):
    r = requests.post(f"{BASE_URL}/api/login",
                      json={"username": username, "password": password},
                      headers={"Content-Type": "application/json"},
                      timeout=15)
    if r.status_code == 400:
        raise RuntimeError(f"Login failed: {r.json().get('error', 'Invalid credentials')}")
    if r.status_code != 200:
        raise RuntimeError(f"Login failed: HTTP {r.status_code} - {r.text[:200]}")
    data = r.json()
    token = data.get("token") or data.get("authToken") or data.get("auth_token")
    if not token:
        raise RuntimeError(f"No token in response. Keys: {list(data.keys())}")
    print(f"[+] Logged in as '{data.get('username')}' (role: {data.get('role')})")
    return token

def update_loader_lua(token, lua_content):
    url = f"{BASE_URL}/api/admin/settings/loader_lua"
    headers = {
        "x-auth-token": token,
        "Content-Type": "application/json"
    }
    payload = {"value": lua_content}
    r = requests.post(url, headers=headers, json=payload, timeout=30)
    if r.status_code == 200:
        print(f"[+] Loader Lua updated successfully.")
        print(f"    Response: {r.json()}")
        return True
    else:
        print(f"[-] Failed to update loader Lua: {r.status_code}")
        print(f"    Response: {r.text[:500]}")
        return False

def main():
    lua_file = "prey_script.lua"
    try:
        with open(lua_file, "r", encoding="utf-8") as f:
            lua_content = f.read()
    except FileNotFoundError:
        print(f"[-] File {lua_file} not found.")
        sys.exit(1)
    except Exception as e:
        print(f"[-] Error reading {lua_file}: {e}")
        sys.exit(1)

    print(f"[+] Read {len(lua_content)} characters from {lua_file}")

    try:
        token = login(ADMIN_USER, ADMIN_PASS)
    except RuntimeError as e:
        print(f"[-] {e}")
        sys.exit(1)

    success = update_loader_lua(token, lua_content)
    if success:
        print("[+] Done.")
    else:
        print("[+] Update failed.")
        sys.exit(1)

if __name__ == "__main__":
    main()