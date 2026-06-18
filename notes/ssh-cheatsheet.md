# SSH Quick Reference

## Generate Key
ssh-keygen -t ed25519 -C "email"

## Start Agent
eval "$(ssh-agent -s)"

## Add Key to Agent
ssh-add ~/.ssh/id_ed25519

## Connect to Server
ssh user@host

## Connect Using Key File Explicitly
ssh -i ~/.ssh/id_ed25519 ubuntu@SERVER_IP

## Test GitHub
ssh -T git@github.com

## View Public Key
cat ~/.ssh/id_ed25519.pub

## Check SSH Service on Server
sudo systemctl status ssh

## Common Troubleshooting
# Permission denied → check authorized_keys and chmod
# Connection timed out → check IP and firewall
# Host key failed → ssh-keygen -R hostname
