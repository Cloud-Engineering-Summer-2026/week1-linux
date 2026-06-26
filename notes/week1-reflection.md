# Week 1 Reflection — Linux Administration
**Date:** June 26, 2026

## What I Built
- create-user.sh
- backup.sh
- users.sh
- monitor.sh
- server-audit.sh

## Concepts I Now Understand Deeply
- navigating linux filesytem
- writing bash scripts
- permissions and users in linux
- github workflow
- git branching
- ssh key generation and use

## Concepts That Still Feel Shaky
- managing line endings between OS's when using WSL.

## Bugs I Hit and Fixed
- Broken shebang: #!bin/bash/ → #!/bin/bash
- Spaces in variable assignment: USERNAME = $1 → USERNAME=$1
- Missing space in brackets: [-z → [ -z
- CRLF line endings breaking shebang on Linux
- Double /mnt/mnt/ in file path
- git remote origin already exists error

## What Surprised Me
A lot of issues arise with line endings when working with WSL. Switching files between operating systems tend to make ghost alterations that can trick GitHub and developer alike but configuration fixes can be made to automate the change.

## What I'd Do Differently
Nothing really, i have enjoyed the week and feel its been productive
## Metrics
- Days completed: 7/7
- Scripts built: 5
- Git commits: 22
- Bugs debugged: 30+

## Week 2 Goals
- OSI model — understand all 7 layers and what happens at each
- Subnetting — be able to subnet confidently without a calculator
- Build a working enterprise network in Packet Tracer
- Complete 3 LeetCode strings problems
