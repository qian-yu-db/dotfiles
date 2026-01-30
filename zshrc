# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

bindkey -v
for file in ~/.{path,exports,aliases,functions,extra}; do
		[ -r "$file" ] && [ -f "$file" ] && source "$file"; 
done;
unset file;
source ${ZDOTDIR:-$HOME}/.zprezto/init.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# UV Python environment setup
export UV_PYTHON=3.12  # Set your preferred Python version
export PATH="$HOME/.local/bin:$PATH"  # Add uv to PATH if installed locally

# UV virtual environment
export UV_DEFAULT_VENV="base"
if [ -z "$VIRTUAL_ENV" ]; then
    if [ ! -d "$HOME/.venv/$UV_DEFAULT_VENV" ]; then
        uv venv "$HOME/.venv/$UV_DEFAULT_VENV" --python 3.12
    fi
    source "$HOME/.venv/$UV_DEFAULT_VENV/bin/activate"
fi

# Claude Code - ensure consistent version
export PATH="/opt/homebrew/lib/node_modules/.bin:$PATH"

# Claude Code aliases for quick updates and checks
alias claude-update='sudo npm update -g @anthropic-ai/claude-code'
alias claude-check='claude-check-version'

# Make UV the default pip installer
#alias pip="uv pip"
#alias python="python"  # Ensure python command works

# Helper function to create and activate project environments
function uvenv() {
    if [ -n "$1" ]; then
        uv venv "$1" --python ${2:-3.12}
        source "$1/bin/activate"
    else
        uv venv --python ${1:-3.12}
        source .venv/bin/activate
    fi
}

# uv
eval "$(uv generate-shell-completion zsh)"

# Added by Windsurf
export PATH="/Users/q.yu/.codeium/windsurf/bin:$PATH"

# bun completions
[ -s "/Users/q.yu/.bun/_bun" ] && source "/Users/q.yu/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Added by Antigravity
export PATH="/Users/q.yu/.antigravity/antigravity/bin:$PATH"

# Claude Code sync alias
alias claude-sync='~/claude_sync_all_versions.sh'
alias claude-check-updates='~/claude_check_updates.sh'

# Yazi file manager with cd-on-quit
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Quick markdown preview with mdcat
function md() {
  mdcat "$@" | less -R
}

# PDF text extraction preview
function pdfview() {
  pdftotext "$1" - | less
}
