# .scripts

One-shot Mac dev environment setup. Run a single `curl` command on a fresh Mac and walk away with Homebrew, GitHub auth, Zsh + Oh My Zsh, Neovim + LazyVim, Cursor, Node (nvm), Bun, and a curated set of CLI tools installed and wired together.

## Quick setup

```sh
curl --silent -o- https://raw.githubusercontent.com/NothinButTreys/.scripts/main/setup.sh | bash
```

That's it. The script is idempotent — safe to re-run on a machine that already has some of the tools installed; it'll skip what exists and finish what doesn't.

## What it installs

The bootstrap (`setup.sh`) clones this repo to `~/.scripts` and then runs everything under [`setup/`](setup/) in the order defined by [`setup/scripts-order.sh`](setup/scripts-order.sh):

| Step | Installs |
|------|----------|
| `brew.sh` | Homebrew (macOS or Linux) |
| `git.sh` | Git + prompts for `user.name` / `user.email` |
| `gh.sh` | GitHub CLI |
| `gh-auth.sh` | Interactive `gh auth login` (choose SSH) |
| `clone-scripts.sh` | Clones this repo to `~/.scripts` |
| `zsh.sh` | Zsh (Linux only; macOS ships with it) |
| `ohmyzsh.sh` | Oh My Zsh + sources [`zsh/.myzshrc`](zsh/.myzshrc) from `~/.zshrc` |
| `nvm.sh` | nvm + latest LTS Node, with `.nvmrc` auto-switching |
| `bun.sh` | Bun |
| `nvim.sh` | Neovim (>= 0.11.2, required for LazyVim) |
| `lazyvim-deps.sh` | `fd`, `ripgrep`, `fzf` |
| `lazygit.sh` | lazygit |
| `tree-sitter-deps.sh` | `tree-sitter-cli` + C compiler for nvim-treesitter |
| `cursor.sh` | Cursor app + Cursor Agent CLI |
| `lazyvim.sh` | Symlinks [`lazyvim/`](lazyvim/) → `~/.config/nvim` and bootstraps plugins |

## What's in this repo

- **`setup.sh`** — bootstrap entry point used by the curl one-liner. Fetches the first few setup scripts from GitHub raw, clones the repo, then hands off to `run-setup-scripts.sh`.
- **`setup/`** — individual, idempotent install scripts. Each one checks for the tool before installing.
- **`setup/run-setup-scripts.sh`** — runs every script in `scripts-order.sh`. Used by both initial setup and update.
- **`setup/update.sh`** — `git pull` + re-run all setup scripts. Wired to the `update` alias.
- **`zsh/.myzshrc`** — custom Zsh config sourced from `~/.zshrc`. Adds aliases, NVM auto-switching on `.nvmrc`, Bun path, and a daily auto-`git pull` of `~/.scripts`.
- **`lazyvim/`** — full LazyVim config. Symlinked into `~/.config/nvim` so edits in the repo are live.
- **`nvim/`** — older vim/nvim configs (legacy, kept for reference).
- **`ahk/`** — AutoHotkey scripts (Windows-side keybindings).

## Day-to-day

Aliases set up by `zsh/.myzshrc`:

| Alias | Does |
|-------|------|
| `update` | `bash ~/.scripts/setup/update.sh` — pull latest and re-apply setup |
| `scripts` | Open `~/.scripts` in Neovim |
| `config` | Edit `~/.scripts/zsh/.myzshrc` |
| `configzsh` | Edit `~/.zshrc` |
| `reset` | `source ~/.zshrc` |
| `vim` / `vi` | Aliased to `nvim` |
| `vimrc` | Jump into `~/.scripts/nvim` |

The shell also auto-pulls `~/.scripts` once every 24 hours in the background, so machines stay in sync without manual intervention.

## Updating an existing machine

```sh
update
```

Or directly: `bash ~/.scripts/setup/update.sh`. Same effect as re-running setup — pulls latest, re-runs every install script, syncs LazyVim plugins.
