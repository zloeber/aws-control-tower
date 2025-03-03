# AWS Control Tower

This repo aggregates a handful of aws control tower notes and code snippets.

To use this one should have mise installed and perhaps zsh as the default shell.

In cloudshell:

```bash
git clone https://github.com/zloeber/aws-control-tower.git
cd aws-control-tower
```

# Configure

```bash
# In AWS CloudShell
./scripts/setup-aws-cloudshell.sh

# Then
./configure.sh
```

Be aware that this updates your cloudshell to zsh and will prompt you to configure the prompt when you restart cloudshell again (or manually just hop into zsh using the cli)
