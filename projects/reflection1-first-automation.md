# reflection1.md

# &#x20;Reflection 1 — First Automation Script

## Project

create-user.sh

Date: June 2026

---

## Objective

The goal of this project was to automate Linux user creation and gain practical experience with system administration tasks commonly performed by cloud engineers.

---

## What I Learned

### Linux User Management

I learned how Linux stores and manages user accounts using commands such as:

```bash
useradd
passwd
usermod
userdel
```

---

### Groups and Permissions

I learned that users are typically granted access through groups rather than individual permission assignments.

I also learned the difference between:

* User ID (UID)
* Group ID (GID)
* Supplemental/Secondary Groups

---

### Administrative Access

I learned how Linux grants administrative privileges through membership in the sudo group.

I verified this using:

```bash
id username
```

---

### Automation

Before this project, user creation required multiple manual commands.

The script reduced the process to:

```bash
sudo ./create_user.sh username
```

This demonstrated the value of automation in reducing repetitive work and human error.

---

### Defensive Scripting

I implemented validation checks to prevent:

* Missing usernames
* Duplicate users
* Running without administrative privileges

This introduced the concept of defensive programming.

---

## Challenges Encountered

### User Deletion Failure

When attempting to delete a test user, Linux returned:

```text
userdel: user developer2 is currently used by process
```

I learned that Linux prevents deletion of accounts that still have active processes.

---

### WSL Permission Issues

While practicing file permissions, I discovered that files stored under:

```text
/mnt/c/
```

did not behave like native Linux files.

I learned that NTFS permissions differ from Linux permissions and that Linux permission exercises should be performed within the Linux filesystem.

---

## How This Relates to Cloud Engineering

Cloud engineers routinely:

* Create and manage Linux users
* Grant administrative access
* Secure SSH access
* Automate repetitive tasks

This project introduced all four concepts.

---

## Future Improvements

Version 2 could include:

* Automatic password generation
* Logging to audit files
* Custom group assignment
* User expiration dates
* Role-based account creation

---

## Key Takeaway

This project demonstrated that automation is not simply writing scripts.

Automation involves:

* Understanding the system
* Identifying repetitive tasks
* Building reliable solutions
* Validating inputs
* Documenting the process

This was my first step toward developing practical Linux administration and cloud engineering skills.
