# Dotfiles Project Instructions

This is a personal dotfiles repository managed with Dotbot.

## Project Structure

- `install` - Bootstrap script that runs Dotbot
- `install.conf.yaml` - Dotbot configuration defining symlinks
- Configuration files are symlinked to home directory

## Key Configurations

- **tmux.conf** - Tmux with vi-mode, TPM plugins (yank, resurrect, continuum)
- **zshrc** - Zsh with Powerlevel10k, vi-mode, UV Python integration
- **nvim/** - NvChad-based Neovim configuration
- **claude/** - Claude Code settings, skills, agents, and commands

## Guidelines

- Keep configurations minimal and focused
- Use Dotbot for symlink management (edit `install.conf.yaml`)
- Test changes before committing
- Submodules are used for vim plugins and tmux-themepack

## Common Tasks

- Add new dotfile: Add entry to `install.conf.yaml`, then run `./install`
- Update submodules: `git submodule update --init --recursive`
- Test installation: `./install` (safe to re-run)
