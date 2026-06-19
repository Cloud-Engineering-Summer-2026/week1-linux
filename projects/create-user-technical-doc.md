# create_user-technical-documentation.md

# Technical Documentation

## Project Goal

The objective of create_user.sh is to automate repetitive Linux user administration tasks while enforcing basic validation and security practices.

---

## Script Workflow

### Step 1: Root Privilege Check

```bash
if [ "$EUID" -ne 0 ]
```

Purpose:

User management operations require administrative privileges.

If the script is not executed with sudo, it exits immediately.

---

### Step 2: Username Validation

```bash
if [ -z "$USERNAME" ]
```

Purpose:

Ensures the user supplies a username argument.

Example:

```bash
sudo ./create_user.sh alice
```

---

### Step 3: Duplicate User Check

```bash
if id "$USERNAME" &>/dev/null
```

Purpose:

Prevents attempts to create users that already exist.

---

### Step 4: User Creation

```bash
useradd -m -s /bin/bash "$USERNAME"
```

Options:

* -m → Create home directory
* -s → Specify login shell

Result:

```text
/home/USERNAME
```

is automatically created.

---

### Step 5: Password Configuration

```bash
passwd "$USERNAME"
```

Purpose:

Assigns a password to the new account.

---

### Step 6: Group Membership Assignment

```bash
usermod -aG sudo "$USERNAME"
```

Purpose:

Adds the user to the sudo group.

Result:

The user can perform administrative actions using sudo.

---

### Step 7: Verification

```bash
id "$USERNAME"
```

Purpose:

Displays:

* UID
* GID
* Group memberships

Used to verify successful creation.

---

## Linux Concepts Demonstrated

### User

A Linux identity used for authentication and authorization.

### UID

Unique numerical identifier for a user account.

### Group

Collection of users sharing permissions.

### Home Directory

Personal workspace assigned to a user.

### Shell

Command interpreter used after login.

### Sudo

Mechanism allowing temporary administrative privileges.

---

## Security Considerations

Implemented:

* Root privilege verification
* Duplicate account prevention

Future Enhancements:

* Password complexity enforcement
* Audit logging
* Account expiration support
* Least-privilege role assignment

---

## Testing Performed

Test Case 1:

Create a valid user.

Expected:
User created successfully.

Result:
Pass

---

Test Case 2:

Attempt duplicate user creation.

Expected:
Script exits with warning.

Result:
Pass

---

Test Case 3:

Run without sudo.

Expected:
Script exits.

Result:
Pass
