# Day 2 — SSH Administration
**Date:** June 17, 2026

## SSH Session — First Server Connection

### Command: hostname

DESKTOP-P40UIRU
**What it means:** This is the name of the machine I connected to.
On AWS EC2 this will show something like ip-172-31-xx-xx.

### Command: whoami
micah
**What it means:** I am logged in as the user micah.
On AWS EC2 the default user is ubuntu.

### Command: pwd
/home/micah
**What it means:** SSH dropped me into the home directory automatically.
This is standard behaviour on any Linux server.

### Command: ls
ics2305_assignment  malloc_lab  malloc_lab.zip  memory_manager
**What it means:** These are the files currently in the home directory.
On a fresh EC2 instance this would be empty.

## What I Learned From This
- SSH connected me to a remote machine using just an IP and password
- The workflow is identical to what I will do on AWS EC2 in Week 3
- Cloud engineers run these four commands first on every new server
  to orient themselves before doing any real work

