# Cloud Accelerator V3 — Week 1: Linux Administration

8-week self-directed cloud engineering program.
Week 1 focuses on professional Linux server administration —
the foundation every cloud engineer, DevOps engineer, and
SRE builds on.

## What This Week Covers

- Linux filesystem hierarchy and navigation
- SSH key generation and secure remote access
- File permissions, ownership, and access control
- User and group administration
- Bash scripting fundamentals
- Server auditing and documentation practices

## Scripts Built

| Script | Purpose |
|---|---|
| `filesystem-explorer.sh` | Reports system info and disk usage |
| `create-user.sh` | Creates a user with home dir, password, and sudo access |
| `server-audit.sh` | Automated health and security audit of a Linux server |

## Key Concepts

- Every file has an Owner, Group, and Others permission set
- SSH uses public/private key pairs for secure authentication
- `chmod 600`/`400` is required for private keys to be trusted
- `usermod -aG` appends a group without removing existing ones
- `&>/dev/null` redirects both stdout and stderr; `&` alone backgrounds a process
- Scripts should validate inputs and check for conflicts before doing real work
- Server audits catch real issues — e.g. leftover test accounts with lingering sudo access

## Folder Structure

```
summer-cloud-engineering/
├── notes/         → daily markdown notes and cheat sheets
├── projects/       → deliverable scripts
├── labs/           → practice and experimentation
└── README.md
```

## Author

Micah Ade Cedar — SCT 211-0014/2024
Cloud Accelerator V3 Elite — Summer 2026
