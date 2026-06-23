## Line Ending Issues (Windows/Linux — CRLF vs LF)

### The Problem
Windows uses CRLF (\r\n) for line endings.
Linux uses LF (\n) only.

When a Windows program (VS Code, Notepad) opens files from WSL,
it silently converts every line ending to CRLF. Git sees this as
every single line being modified — even if no actual content changed.
The symptom is ^M symbols appearing at the end of lines in git diff.

### How to spot it
git diff will show ^M at the end of every line, and hundreds of
"changes" in a file you never touched.

### The Fix — run this once, applies globally forever
git config --global core.autocrlf true

### What this does
- On commit → Git converts CRLF to LF (cleans up Windows line endings)
- On checkout → Git converts LF back to CRLF for Windows compatibility
- Result → your repo always stores clean LF line endings regardless
  of which platform edited the files

### Why this matters as a cloud engineer
Linux servers only use LF. If you deploy a bash script with CRLF
line endings to an EC2 instance, it will fail with cryptic errors
because the \r character breaks the shebang line and command parsing.
This setting prevents that entire class of problem.

## Auto-Pruning Stale Remote Branches

### The Problem
When a branch is deleted on GitHub (e.g. after merging a PR),
your local Git still remembers it. Over time your local list of
"remote branches" fills up with dead references that no longer
exist on GitHub — cluttering your workspace.

### How to spot stale branches
git branch -r
If you see branches listed that were already merged and deleted
on GitHub, those are stale references.

### The Fix — run this once, applies globally forever
git config --global fetch.prune true

### What this does
Every time you run git fetch or git pull, Git automatically
removes any local references to branches that no longer exist
on GitHub. Your local branch list stays in sync with reality.

### Why this matters as a cloud engineer
On a real team, branches get created and deleted constantly —
features, hotfixes, releases. Without pruning, your local Git
accumulates hundreds of dead branch references over months.
Auto-pruning keeps your workspace clean without any extra steps.
