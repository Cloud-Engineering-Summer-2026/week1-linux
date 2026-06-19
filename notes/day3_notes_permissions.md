# Permissions, Ownership & Access Control — Week 1 Day 3
**Date:** June 18, 2026
**Author:** Micah Cheboi | SCT 211-0014/2024

---

## Core Concept

Linux checks access using three identities on every file and directory:

```
Owner
Group
Others
```

The access check flow:

```
Who are you?
   ↓
Owner? → check owner permissions
Group member? → check group permissions
Neither? → check "others" permissions
   ↓
Do you have permission for this action?
   ↓
Allow or Deny
```

---

## Permission Structure

Example:
```
-rwxr-x---
```

| Section | Meaning |
|---|---|
| `-` | File type (`-` = file, `d` = directory) |
| `rwx` | Owner permissions |
| `r-x` | Group permissions |
| `---` | Others permissions |

---

## Files vs Directories

**For files:**

| Permission | Meaning |
|---|---|
| `r` | Read contents |
| `w` | Modify contents |
| `x` | Execute file |

**For directories:**

| Permission | Meaning |
|---|---|
| `r` | List filenames inside (`ls`) |
| `w` | Create or delete files inside |
| `x` | Enter the directory (`cd`) — also required to access anything inside, even if the filename is known |

**Key insight:** `x` on a directory is different from `x` on a file. Without `x` on a directory, even having `r` only lets you see filenames — you can't actually enter or access the files themselves.

---

## Numeric Permissions

```bash
chmod 755 script.sh
```

| Number | Meaning |
|---|---|
| 4 | Read |
| 2 | Write |
| 1 | Execute |

```
7 = 4+2+1 = rwx
6 = 4+2   = rw-
5 = 4+1   = r-x
```

---

## Lab Results

### Part A — Investigating Real Permissions

`~/.ssh/id_ed25519` (private key) is more restricted than `id_ed25519.pub` (public key) because the private key must never be readable by anyone but the owner — if another user or process could read it, they could impersonate me on any server or service that trusts that key.

`/etc/passwd` is world-readable because many system tools need to look up usernames and UIDs. `/etc/shadow` is restricted because it stores password hashes — exposing it would let anyone attempt to crack passwords offline.

---

### Part B — File Permission Experiments

```bash
touch secret.txt
chmod 444 secret.txt
echo "test" >> secret.txt
```

Result: `Permission denied`. The `444` permission removed write access for everyone, including the owner, proving the restriction works exactly as expected.

Restored with:
```bash
chmod 644 secret.txt
```

---

### Part C — Directory Permission Experiments

```bash
mkdir secure-folder
chmod 700 secure-folder
ls -ld secure-folder
```

Output:
```
drwx------ 2 micah micah 4096 Jun 19 08:17 secure-folder
```

**What each permission means here:**

| Permission | Meaning for this directory |
|---|---|
| `rwx` (owner) | I can list, create/delete, and enter the folder |
| `---` (group) | No access at all |
| `---` (others) | No access at all |

Only the owner (me) can list, enter, or modify anything inside `secure-folder`. Anyone else attempting to `cd` into it or `ls` it gets `Permission denied`, even if they know exact filenames inside.

---

### Part D — Dangerous Permissions Demo

```bash
touch payroll.txt
chmod 777 payroll.txt
```

**Why this is dangerous:** `777` grants read, write, and execute to owner, group, and others — meaning literally any user on the system can read, modify, or delete the file. On a shared or multi-user server this is a serious security hole. Restored immediately with:
```bash
chmod 600 payroll.txt
```

---

## User & Group Administration

```bash
id
groups
sudo useradd -m developer
sudo passwd developer
sudo usermod -aG sudo developer
id developer
```

---

## Build Deliverable: create_user.sh

Enhanced version that checks for existing users before creating one:

```bash
#!/bin/bash
# create_user.sh — User Management Script
# Week 1 Day 3 — Cloud Accelerator V3
# Author: Micah Cheboi | SCT 211-0014/2024

if [ "$EUID" -ne 0 ]; then
    echo "Run with sudo."
    exit 1
fi

USERNAME=$1

if [ -z "$USERNAME" ]; then
    echo "Usage: sudo ./create_user.sh username"
    exit 1
fi

if id "$USERNAME" &>/dev/null; then
    echo "User already exists."
    exit 1
fi

useradd -m -s /bin/bash "$USERNAME"
passwd "$USERNAME"
usermod -aG sudo "$USERNAME"

echo "User created successfully."
id "$USERNAME"
```

Tested with `clouduser`, verified with `id clouduser`, then removed with `sudo userdel -r clouduser`.

---

## Commands Learned

```
chmod
chown
id
groups
useradd
usermod
passwd
userdel
```

---

## Cloud Connection

Linux permissions are the foundation of cloud server security. On AWS EC2 instances:
- SSH private keys must be `600` or `400` or the connection is refused
- Misconfigured file permissions (e.g. `777`) are one of the most common causes of real-world security breaches
- Every Docker container and Kubernetes node still relies on this same Linux permission model underneath

---

## Troubleshooting Reference

| Error | Cause |
|---|---|
| `Permission denied` | Wrong permissions, not owner, or missing sudo |
| `useradd: user already exists` | User already exists — check with `id username` first |
| `Operation not permitted` | Administrative privileges required — use sudo |

---

## Key Takeaways

- Owner vs Group vs Others — three identities checked on every single access
- File permissions and directory permissions mean different things, especially `x`
- `chmod 777` is dangerous because it removes all access restrictions
- SSH keys require strict permissions (`600`/`400`) to be trusted

## Questions

(anything that still feels unclear — fill in honestly)
