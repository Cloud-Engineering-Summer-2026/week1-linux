# Server Audit Script — Week 1 Day 4
**Date:** June 19, 2026 (built) / June 21, 2026 (tested)

## Purpose
Automates a basic Linux server health and security check —
the kind of report a cloud engineer would run on day one of
managing a new server, and repeatedly afterward.

## What It Checks
1. System info — hostname, user, current path
2. Disk usage — filtered to real disks only (excludes tmpfs/overlay)
3. Human user accounts — UID >= 1000, excluding `nobody` (65534)
4. Sudo group membership — who has admin privileges
5. SSH key permissions — confirms private key is locked to 600/400
6. Recent auth log activity — login attempts, sudo sessions
7. Recent syslog activity — errors, failures, warnings

## Key Techniques Used
- `awk -F':' '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd`
  → filters /etc/passwd to real human accounts only
- `getent group sudo | cut -d':' -f4`
  → lists sudo group members cleanly
- `grep -Ei "accepted|invalid"` on auth.log
  → flags successful vs failed login attempts

## Real Finding From First Run
Audit caught a leftover `developer` test account (created during
Day 3 lab) still present on the system with active sudo access.
Removed with `sudo userdel -r developer` and re-ran the audit to
confirm cleanup — confirms the script actually works as intended.

## Why This Matters
This is a miniature, manual version of what tools like AWS
CloudWatch or Datadog do at scale — automated, repeatable
visibility into server health and security posture.

## Possible Future Improvements
- Schedule with cron to run automatically
- Write output to a timestamped log file instead of just stdout
- Add a check for failed SSH login attempts specifically
- Alert (email/Slack) if something looks wrong instead of just printing
