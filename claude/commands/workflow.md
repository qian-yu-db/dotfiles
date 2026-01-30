# Claude Code + Tmux + Neovim Workflow Reference

Print this quick reference guide for the user. Format it clearly for terminal display.

---

## TMUX SHORTCUTS (prefix: Ctrl+b)

### Pane Management
| Shortcut | Action |
|----------|--------|
| `Ctrl+b %` | Split pane vertically |
| `Ctrl+b "` | Split pane horizontally |
| `Ctrl+b arrow` | Navigate between panes |
| `Ctrl+b z` | Zoom/unzoom current pane |
| `Ctrl+b x` | Close current pane |
| `Ctrl+b {` / `}` | Swap pane left/right |
| `Ctrl+b Ctrl+arrow` | Resize pane |

### Window Management
| Shortcut | Action |
|----------|--------|
| `Ctrl+b c` | Create new window |
| `Ctrl+b n` / `p` | Next/previous window |
| `Ctrl+b 0-9` | Switch to window by number |
| `Ctrl+b ,` | Rename current window |
| `Ctrl+b &` | Close current window |

### Session Management
| Shortcut | Action |
|----------|--------|
| `Ctrl+b d` | Detach from session |
| `Ctrl+b s` | List sessions |
| `Ctrl+b $` | Rename session |
| `tmux ls` | List sessions (from shell) |
| `tmux a -t name` | Attach to session |

### Copy Mode (scrollback)
| Shortcut | Action |
|----------|--------|
| `Ctrl+b [` | Enter copy mode |
| `q` | Exit copy mode |
| `arrows` / `PgUp/PgDn` | Navigate |
| `Space` | Start selection (vi mode) |
| `Enter` | Copy selection |
| `Ctrl+b ]` | Paste |

---

## NEOVIM SHORTCUTS (leader = Space)

### File Navigation
| Shortcut | Action |
|----------|--------|
| `Space ff` | Find files (Telescope) |
| `Space fw` | Live grep (search text) |
| `Space fb` | Find open buffers |
| `Space fo` | Recent files |
| `Ctrl+n` | Toggle file tree |
| `Space e` | Focus file tree |

### Buffer Management
| Shortcut | Action |
|----------|--------|
| `Tab` | Next buffer |
| `Shift+Tab` | Previous buffer |
| `Space x` | Close buffer |
| `Space b` | New buffer |

### LSP (Code Intelligence)
| Shortcut | Action |
|----------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `K` | Hover documentation |
| `Space ra` | Rename symbol |
| `Space ca` | Code action |
| `Space fm` | Format document |
| `[d` / `]d` | Prev/next diagnostic |

### Git (Gitsigns)
| Shortcut | Action |
|----------|--------|
| `]c` / `[c` | Next/prev hunk |
| `Space ph` | Preview hunk |
| `Space rh` | Reset hunk |
| `Space gb` | Blame line |

### Misc
| Shortcut | Action |
|----------|--------|
| `Space /` | Toggle comment |
| `Space th` | Switch theme |
| `Space ch` | Show cheatsheet |
| `Ctrl+s` | Save file |
| `:e` | Reload current file |
| `:checktime` | Reload all changed files |

---

## RECOMMENDED WORKFLOW

### Layout Setup
```
tmux new -s dev
# Then split: Ctrl+b % for vertical split
```

```
+------------------+------------------+
|                  |                  |
|     NEOVIM       |   CLAUDE CODE    |
|                  |                  |
|  - editing       |  - generation    |
|  - navigation    |  - refactoring   |
|  - LSP features  |  - explanations  |
|                  |                  |
+------------------+------------------+
```

### Task Division

**Use Neovim for:**
- Quick edits and navigation
- LSP features (go to def, rename, references)
- Reviewing git changes hunk by hunk
- File tree browsing

**Use Claude Code for:**
- Multi-file refactoring
- Generating new code/tests
- Complex debugging
- Understanding unfamiliar codebases
- Writing commit messages (`/commit`)

### After Claude Edits Files
1. Switch to Neovim pane: `Ctrl+b arrow`
2. Reload files: `:checktime` or `:e`
3. Review changes: `Space ph` (preview hunk)
4. Undo if needed: `Space rh` (reset hunk)

### Quick Pane Workflow
- `Ctrl+b z` - Zoom Neovim when editing
- `Ctrl+b z` - Unzoom, navigate to Claude pane
- `Ctrl+b z` - Zoom Claude for longer conversations

---

## TIPS

1. **Commit often** - Use git as safety net between Claude sessions
2. **Let Claude explore** - Say "look at src/auth.py" instead of pasting code
3. **Use Neovim for precision** - Small edits, renames, navigation
4. **Use Claude for scope** - Multi-file changes, new features
5. **Zoom liberally** - `Ctrl+b z` is your friend
6. **Name tmux sessions** - `tmux new -s projectname` for easy reattach
