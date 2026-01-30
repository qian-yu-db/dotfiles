# Dotfiles

Personal dotfiles managed with [Dotbot](https://github.com/anishathalye/dotbot).

## Quick Start

```bash
git clone https://github.com/qianyu-berkeley/dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles
./install
```

## What's Included

| Component | Description |
|-----------|-------------|
| **tmux** | Vi-mode, `C-a` prefix, powerline theme, session persistence |
| **zsh** | Powerlevel10k prompt, vi-mode, UV Python integration |
| **neovim** | NvChad v2.0, Python LSP (pyright, ruff, mypy), Telescope |
| **git** | Aliases, diff settings, vimdiff merge tool |
| **claude** | Claude Code settings, custom skills, agents, commands |

## Structure

```
dotfiles/
├── install              # Bootstrap script
├── install.conf.yaml    # Dotbot symlink configuration
├── tmux.conf            # Tmux configuration
├── zshrc                # Zsh configuration
├── aliases              # Shell aliases
├── exports              # Environment variables
├── gitconfig            # Git configuration
├── nvim/                # Neovim configuration (NvChad)
├── claude/              # Claude Code configuration
│   ├── CLAUDE.md        # Global instructions
│   ├── settings.json    # Permissions, hooks, plugins
│   ├── commands/        # Custom slash commands
│   ├── skills/          # Custom skills
│   └── agents/          # Custom agents
├── vim/                 # Legacy Vim plugins (submodules)
└── dotbot/              # Dotbot submodule
```

## Prerequisites

```bash
# macOS with Homebrew
brew install git tmux neovim node uv

# Claude Code
npm install -g @anthropic-ai/claude-code
```

## Post-Install

### Tmux Plugins

```bash
tmux
# Press: prefix + I (Ctrl-a, Shift-i)
```

### Claude Code Plugins

```bash
claude plugins install agent-sdk-dev code-review commit-commands \
  frontend-design hookify plugin-dev ralph-loop
```

### Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
```

## Key Bindings

### Tmux

| Key | Action |
|-----|--------|
| `C-a` | Prefix (instead of `C-b`) |
| `prefix + h/j/k/l` | Navigate panes |
| `prefix + H/J/K/L` | Resize panes |
| `prefix + \|` | Split vertical |
| `prefix + -` | Split horizontal |
| `prefix + C-s` | Save session |
| `prefix + C-r` | Restore session |

### Neovim

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fw` | Live grep |
| `<leader>fb` | Buffers |
| `gd` | Go to definition |
| `K` | Hover docs |
| `<leader>ca` | Code action |
| `<leader>fm` | Format |

## Updating

```bash
cd ~/workspace/dotfiles
git pull
git submodule update --init --recursive
./install
```

## License

MIT
