# Linux Server Automation Toolkit

## Overview

This project contains Linux administration scripts developed as part of the
Summer 2026 Cloud Engineering Accelerator — Week 1: Professional Linux Administration.

The toolkit automates common server administration tasks including user management,
directory backups, system health monitoring, and security auditing.

---

## Scripts

### create-user.sh
Automates Linux user creation with home directory, shell assignment, password
setup, and sudo access — with duplicate user prevention and input validation.

### backup.sh
Automated directory backup with timestamped `.tar.gz` archives and persistent
logging. Never overwrites previous backups.

### users.sh
Interactive menu-driven user management — create, delete, list human accounts,
list sudo users, and check user existence.

### monitor.sh
Comprehensive system health report covering CPU, memory, disk usage, top
processes, logged-in users, SSH key permissions, and recent auth log activity.

### server-audit.sh
Automated security and health audit script. Checks disk usage, human user
accounts, sudo group membership, SSH key permissions, and recent log activity.
Designed to run on any Linux server as a first-look assessment.

---

## Features

- Creates Linux users with home directory, bash shell, and optional sudo access
- Prevents duplicate user creation and validates all inputs
- Timestamped backups that never overwrite previous archives
- Logs every successful backup to `~/backup.log`
- Interactive menu interface for user management
- Full system health report in one command
- Security audit catches issues like leftover accounts and misconfigured permissions

---

## Technologies Used

- Linux
- Bash
- Ubuntu (WSL2)
- Git & GitHub

---

## Installation

Clone the repository:
```bash
git clone <repository-url>
```

Navigate to the project:
```bash
cd summer-cloud-engineering/projects
```

Make all scripts executable:
```bash
chmod +x *.sh
```

Fix line endings if on WSL:
```bash
sed -i 's/\r//' *.sh
```

---

## Usage

### Create a user
```bash
sudo ./create-user.sh username
```

### Backup a directory
```bash
./backup.sh <source_directory> <destination_directory>
```

Example:
```bash
./backup.sh ~/notes ~/backups
```

### Manage users interactively
```bash
sudo ./users.sh
```

### Run system health monitor
```bash
./monitor.sh
```

### Run server audit
```bash
./server-audit.sh
```

---

## Example Output — create-user.sh

```text
User created successfully with administrative privileges
uid=1002(testuser) gid=1002(testuser) groups=1002(testuser),27(sudo)
```

## Example Output — backup.sh

```text
✓ Backup complete: /home/micah/backups/backup_20260621_214533.tar.gz
✓ Logged to: /home/micah/backup.log
```

---

## Real Finding From server-audit.sh

On first run, the audit caught a leftover `developer` test account still
present on the system with active sudo access. Removed with `userdel -r`
and re-ran the audit to confirm cleanup — demonstrating the script works
as a real security check, not just a demo.

---

## Skills Demonstrated

- Bash scripting with guard clauses and error handling
- `set -euo pipefail` for production-safe scripts
- User and group administration
- File permissions and SSH key management
- System monitoring and log analysis
- Git branching, pull requests, and issue tracking
- Professional documentation practices

---

## Folder Structure

```
summer-cloud-engineering/
├── projects/       → deliverable scripts
├── labs/           → practice and experimentation
├── notes/          → daily markdown notes and cheat sheets
├── backups/        → backup archives
└── README.md
```

---

## Author

Micah Ade Cedar
Cloud Engineering Accelerator V3 Elite — Summer 2026
