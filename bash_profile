
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/q.yu/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/q.yu/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/q.yu/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/q.yu/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


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

# Make UV the default pip installer
alias pip="uv pip"
alias python="python"  # Ensure python command works

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

# Source .bashrc if it exists (common practice)
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
