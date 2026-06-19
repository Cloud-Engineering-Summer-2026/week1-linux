# README.md

# Linux User Administration Toolkit

## Overview

This project contains Linux administration scripts developed as part of my Summer 2026 Cloud Engineering Accelerator.

The first script in this toolkit is:

* create_user.sh

This script automates the process of creating Linux users and granting administrative privileges.

---

## Features

* Creates a Linux user
* Creates a home directory automatically
* Assigns Bash as the login shell
* Prompts for password creation
* Adds the user to the sudo group
* Verifies successful account creation
* Prevents duplicate user creation

---

## Technologies Used

* Linux
* Bash
* Ubuntu
* WSL

---

## Installation

Clone the repository:

```bash
git clone <repository-url>
```

Navigate to the project:

```bash
cd linux-admin
```

Make the script executable:

```bash
chmod +x create_user.sh
```

---

## Usage

```bash
sudo ./create_user.sh username
```

Example:

```bash
sudo ./create_user.sh testuser
```

---

## Example Output

```text
User created successfully with administrative privileges

uid=1002(testuser)
gid=1002(testuser)
groups=1002(testuser),27(sudo)
```

---

## Future Improvements

Planned additions:

* Backup automation
* Log monitoring
* User auditing
* Disk usage reporting
* System health checks

---

## Author

Micah Ade Cedar

Cloud Engineering Accelerator — Summer 2026
