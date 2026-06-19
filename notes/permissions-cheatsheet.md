# Linux Permissions Cheat Sheet — Day 3

## Reading Permissions
```
-rwxr-xr-x
│├──┤├──┤├──┤
│ Owner Group Others
│
└─ File type: - = file, d = directory, l = symlink
```

## chmod Numbers

| Number | Permission | Meaning |
|---|---|---|
| 7 | rwx | Read, write, execute |
| 6 | rw- | Read and write |
| 5 | r-x | Read and execute |
| 4 | r-- | Read only |
| 0 | --- | No permissions |

## Common Permission Sets

```bash
chmod 600 file   # private keys, sensitive files — owner read/write only
chmod 400 file   # private keys, even stricter — owner read only
chmod 644 file   # regular files — owner read/write, everyone else read
chmod 755 file   # scripts, executables — owner full, everyone else read+execute
chmod 700 dir    # private directories — owner only
chmod 777 file   # DANGEROUS — everyone full access, avoid
```

## Symbolic chmod

```bash
chmod +x file       # add execute for everyone
chmod -w file        # remove write for everyone
chmod u+x file       # add execute for owner only
chmod g+w file       # add write for group only
chmod o-r file       # remove read for others only
```

## Files vs Directories

| Permission | On a File | On a Directory |
|---|---|---|
| r | Read contents | List filenames |
| w | Modify contents | Create/delete files inside |
| x | Execute as program | Enter the directory (cd) |

## Ownership

```bash
chown micah file            # change owner
chown micah:micah file      # change owner and group
chown -R micah folder       # change recursively (whole folder tree)
```

## User Management

```bash
useradd -m -s /bin/bash username   # create user with home dir + bash shell
passwd username                     # set password
usermod -aG sudo username           # add user to sudo group
userdel -r username                 # delete user and their home dir
id username                         # check user's UID, GID, groups
groups                              # see your own group membership
cat /etc/passwd                     # list all users on system
cat /etc/shadow                     # password hashes (root only)
```

## Quick Diagnosis

| Symptom | Likely Cause | Check |
|---|---|---|
| `Permission denied` on a file | Missing r/w/x for your identity | `ls -la file` |
| `Permission denied` entering a folder | Missing `x` on directory | `ls -ld folder` |
| SSH key rejected | Key permissions too open | `ls -la ~/.ssh/id_ed25519` → must be 600 or 400 |
| `useradd: user already exists` | User already created | `id username` first |
| `Operation not permitted` | Needs sudo | Prefix command with `sudo` |

## Cloud Reminder

```bash
chmod 600 ~/.ssh/id_ed25519     # private key, AWS will reject if too open
chmod 400 mykey.pem             # common AWS EC2 .pem key permission
```
# Linux Permissions Cheat Sheet — Day 3

## Reading Permissions
```
-rwxr-xr-x
│├──┤├──┤├──┤
│ Owner Group Others
│
└─ File type: - = file, d = directory, l = symlink
```

## chmod Numbers

| Number | Permission | Meaning |
|---|---|---|
| 7 | rwx | Read, write, execute |
| 6 | rw- | Read and write |
| 5 | r-x | Read and execute |
| 4 | r-- | Read only |
| 0 | --- | No permissions |

## Common Permission Sets

```bash
chmod 600 file   # private keys, sensitive files — owner read/write only
chmod 400 file   # private keys, even stricter — owner read only
chmod 644 file   # regular files — owner read/write, everyone else read
chmod 755 file   # scripts, executables — owner full, everyone else read+execute
chmod 700 dir    # private directories — owner only
chmod 777 file   # DANGEROUS — everyone full access, avoid
```

## Symbolic chmod

```bash
chmod +x file       # add execute for everyone
chmod -w file        # remove write for everyone
chmod u+x file       # add execute for owner only
chmod g+w file       # add write for group only
chmod o-r file       # remove read for others only
```

## Files vs Directories

| Permission | On a File | On a Directory |
|---|---|---|
| r | Read contents | List filenames |
| w | Modify contents | Create/delete files inside |
| x | Execute as program | Enter the directory (cd) |

## Ownership

```bash
chown micah file            # change owner
chown micah:micah file      # change owner and group
chown -R micah folder       # change recursively (whole folder tree)
```

## User Management

```bash
useradd -m -s /bin/bash username   # create user with home dir + bash shell
passwd username                     # set password
usermod -aG sudo username           # add user to sudo group
userdel -r username                 # delete user and their home dir
id username                         # check user's UID, GID, groups
groups                              # see your own group membership
cat /etc/passwd                     # list all users on system
cat /etc/shadow                     # password hashes (root only)
```

## Quick Diagnosis

| Symptom | Likely Cause | Check |
|---|---|---|
| `Permission denied` on a file | Missing r/w/x for your identity | `ls -la file` |
| `Permission denied` entering a folder | Missing `x` on directory | `ls -ld folder` |
| SSH key rejected | Key permissions too open | `ls -la ~/.ssh/id_ed25519` → must be 600 or 400 |
| `useradd: user already exists` | User already created | `id username` first |
| `Operation not permitted` | Needs sudo | Prefix command with `sudo` |

## Cloud Reminder

```bash
chmod 600 ~/.ssh/id_ed25519     # private key, AWS will reject if too open
chmod 400 mykey.pem             # common AWS EC2 .pem key permission
```

## Running Scripts: Two Methods

| Command | Needs execute permission? | Needs valid shebang? |
|---|---|---|
| `./script.sh` | Yes | Yes |
| `bash script.sh` | No | No |

```bash
./create-user.sh testuser        # uses shebang + needs chmod +x
bash create-user.sh testuser     # ignores shebang, no chmod needed
```

**Debugging trick:** if `./script.sh` fails but `bash script.sh` works, the problem is either a broken shebang or missing execute permission — not the script logic itself.

## Common Bash Script Bugs

```bash
# WRONG — spaces around = break variable assignment
USERNAME = $1

# CORRECT — no spaces at all
USERNAME=$1
```

```bash
# WRONG — malformed shebang
#!bin/bash/

# CORRECT
#!/bin/bash
```

```bash
# WRONG — missing space inside brackets
if [-z "$USERNAME"]; then

# CORRECT — space after [ and before ]
if [ -z "$USERNAME" ]; then
```

```bash
# WRONG — missing > breaks redirect, runs in background instead
if id "$USERNAME" &/dev/null; then

# CORRECT — &> redirects both stdout and stderr to /dev/null
if id "$USERNAME" &>/dev/null; then
```
