<div align="center">

# ⚡ nvim-config

**A personal [Neovim](https://neovim.io/) configuration — fast, native, reproducible.**

[![Neovim](https://img.shields.io/badge/Neovim-0.12%2B-57A143?style=flat-square&logo=neovim&logoColor=white)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Made%20with-Lua-2C2D72?style=flat-square&logo=lua&logoColor=white)](https://www.lua.org)
[![vim.pack](https://img.shields.io/badge/plugins-vim.pack%20(native)-blue?style=flat-square)](https://neovim.io/doc/user/pack.html)

*Built on Neovim's native plugin manager `vim.pack` — every plugin pinned in a
lockfile, the exact same setup restored on any machine with one `git clone`.*

</div>

---

## Table of contents

- [Highlights](#highlights)
- [Learning Neovim](#learning-neovim)
- [Requirements](#requirements)
- [Installation](#installation)
- [Structure](#structure)
- [Plugins](#plugins)
- [Language servers](#language-servers)
- [Formatting](#formatting)
- [Editor behavior](#editor-behavior)
- [Keymaps](#keymaps)
- [Commands](#commands)
- [Syncing changes](#syncing-changes)

## Highlights

- **100% native foundations** — `vim.pack` for plugins, `vim.lsp` for language
  servers, the experimental `vim._core.ui2` for a redesigned cmdline. No
  plugin-manager framework to learn.
- **Reproducible** — [`nvim-pack-lock.json`](./nvim-pack-lock.json) pins every
  plugin version; `:ConfigUpdate` pulls the latest config from git without
  leaving the editor.
- **Web-dev ready** — LSP, Emmet, snippets and formatters for PHP, JS/TS,
  HTML, CSS and Python, live browser preview included.
- **Keyboard-first, no VS Code cosplay** — no sidebar, no breadcrumbs:
  Telescope to find things, Harpoon to switch between hot files, Flash to jump
  anywhere on screen.
- **Discoverable** — press `<Space>` and *wait*: which-key pops up every
  keymap with its description. The config teaches itself.

> Big thanks to [**kickstart.nvim**](https://github.com/nvim-lua/kickstart.nvim) —
> an invaluable guide for learning how a Neovim config is structured, and where
> a lot of the ideas here come from.

## Learning Neovim

Before reaching for the internet, use Neovim's **built-in documentation** — it is
excellent, always matches the version you are running, and is the single best
way to learn the editor.

**Help system** — every option, command and function is documented:

| Command | What it does |
| --- | --- |
| `:help` | Open the main help page |
| `:help <topic>` | Help for a specific topic, e.g. `:help vim.pack` |
| `:help <keys>` | What a key does, e.g. `:help <C-w>` or `:help :w` |
| `:helpgrep <text>` | Search the full text of all help files |
| `K` | Open help (or LSP hover docs) for the word under the cursor |
| `<C-]>` / `<C-o>` | Jump to a tag link in help / jump back |

> Inside a help buffer, links are the words wrapped in `|bars|`. Put the cursor
> on one and press `<C-]>` to follow it, `<C-o>` to go back.

**Interactive tutorial** — the fastest way to get the fundamentals into your
fingers:

```vim
:Tutor
```

`:Tutor` opens a ~30-minute hands-on lesson (movement, editing, search,
saving…). Work through it directly inside Neovim — it is the recommended
starting point for anyone new to the editor.

## Requirements

| Tool | Why |
| --- | --- |
| **Neovim 0.12+** | Required for `vim.pack` and the experimental `vim._core.ui2` UI |
| `git` | Plugin downloads and version control |
| [`lazygit`](https://github.com/jesseduffield/lazygit) | In-editor git UI (`<leader>gg`) |
| **Nerd Font** | Statusline and file-type icons |
| `ripgrep` | Text search: Telescope `live_grep` and grug-far |
| `make` + `gcc` | Build `telescope-fzf-native` once on install |
| **Node.js** | Required by `prettierd` and the JS/TS/JSON/HTML/CSS language servers |
| `fd` *(optional)* | Faster file finding for Telescope |

## Installation

Follow the steps in order. Every command you need is listed here.

### 1. Install the system dependencies

These must be on your `PATH` **before** launching Neovim.

**Fedora** (this is the machine the config is used on):

```bash
sudo dnf install neovim git lazygit ripgrep fd-find gcc make nodejs
```

<details>
<summary>Other systems</summary>

```bash
# Debian / Ubuntu
sudo apt install neovim git ripgrep fd-find gcc make nodejs
#   lazygit: see https://github.com/jesseduffield/lazygit#installation

# Arch / Manjaro
sudo pacman -S neovim git lazygit ripgrep fd gcc make nodejs

# openSUSE
sudo zypper install neovim git lazygit ripgrep fd gcc make nodejs

# Void Linux
sudo xbps-install -S neovim git lazygit ripgrep fd gcc make nodejs

# Alpine
sudo apk add neovim git lazygit ripgrep fd gcc make nodejs

# Gentoo
sudo emerge app-editors/neovim dev-vcs/git dev-tools/lazygit sys-apps/ripgrep sys-apps/fd gcc make nodejs

# Nix (any distro)
nix-env -iA nixpkgs.neovim nixpkgs.git nixpkgs.lazygit nixpkgs.ripgrep nixpkgs.fd nixpkgs.gcc nixpkgs.gnumake nixpkgs.nodejs

# macOS (Homebrew)
brew install neovim git lazygit ripgrep fd gcc make node
```
</details>

> **Neovim 0.12+ is required**. If your package manager ships an older version,
> install a newer build from <https://github.com/neovim/neovim/releases>.

Also install a **[Nerd Font](https://www.nerdfonts.com/)** and select it in
your terminal, otherwise the statusline and file-type icons render as boxes.

### 2. Clone the repo

```bash
git clone git@github.com:sombreror/nvim-config.git ~/.config/nvim
```

> If `~/.config/nvim` already exists, back it up first:
> ```bash
> mv ~/.config/nvim ~/.config/nvim.bak
> ```

### 3. First launch — let plugins download

```bash
nvim
```

On the first launch `vim.pack` downloads every plugin at the exact versions
pinned in [`nvim-pack-lock.json`](./nvim-pack-lock.json). Wait for it to
finish, then quit with `:qa`.

The [language servers](#language-servers) and Treesitter parsers are installed
**automatically** by Mason and `tree-sitter-manager` on this first run.

### 4. Build the Telescope native sorter (once)

```bash
make -C ~/.local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim
```

> Re-run this whenever `telescope-fzf-native` is updated.

### 5. Install the formatters

The formatters are **not** auto-installed. Open Neovim and run:

```vim
:MasonInstall stylua black prettierd biome php-cs-fixer
```

(See [Formatting](#formatting) for which language uses which.)

### 6. Done

Restart Neovim. Everything should now work — verify with `:checkhealth` if
something looks off.

## Structure

One file per area: options, keymaps and autocmds live under `config/`, every
plugin is set up in its own themed module under `plugins/`.

```
.
├── init.lua                  # Entry point — loads everything below
├── nvim-pack-lock.json       # Pinned plugin versions (reproducible installs)
├── snippets/                 # Custom snippets, loaded by blink.cmp
└── lua/
    ├── config/
    │   ├── options.lua        # Editor options
    │   ├── keymaps.lua        # All keyboard shortcuts
    │   ├── autocmd.lua        # Automatic editor behavior
    │   └── commands.lua       # Custom user commands (:ConfigUpdate)
    └── plugins/
        ├── init.lua           # Plugin list (vim.pack) — loads the modules below
        ├── completion.lua     # blink.cmp + lazydev source
        ├── treesitter.lua     # Treesitter parsers (tree-sitter-manager)
        ├── editing.lua        # conform, autopairs, mini.*, todo-comments, grug-far
        ├── git.lua            # gitsigns + hunk keymaps
        ├── telescope.lua      # Telescope + fzf + file browser
        ├── navigation.lua     # flash, harpoon, which-key
        ├── ui.lua             # tokyonight, lualine, nvim-notify, highlight-colors
        └── lsp.lua            # Mason + language servers + lazydev (loaded last)
```

## Plugins

**LSP & completion**
- **nvim-lspconfig** + **mason** + **mason-lspconfig** — install and enable the
  language servers.
- **blink.cmp** + **friendly-snippets** — autocompletion and snippets
  (`super-tab`: accept with `Tab`).
- **lazydev.nvim** — completion and docs for the Neovim API (`vim.*`) when
  editing this very config.

**Editing**
- **tree-sitter-manager** — Treesitter parsers, auto-installed.
- **nvim-autopairs** — auto-closes brackets and quotes (treesitter-aware).
- **conform.nvim** — code formatting, one formatter per language (manual —
  see [Formatting](#formatting)).
- **mini.ai** — smarter textobjects: `vif` = inside function, `via` = inside
  argument, `viq` = inside quotes.
- **mini.surround** — add / change / delete surrounding pairs (`sa` / `sd` /
  `sr`).
- **mini.move** — move lines and selections with `Alt+hjkl`.
- **mini.trailspace** — highlights trailing whitespace; trim it on demand with
  `<leader>cw` (no silent edits on save).
- **todo-comments.nvim** — highlights `TODO` / `FIXME` / `HACK` / `WARN` /
  `NOTE` and lists them with Telescope (`<leader>ft`).

**Search & navigation**
- **telescope** + **telescope-fzf-native** — fuzzy finder for files, text and
  git, with a native (C) sorter.
- **telescope-file-browser** — browse *and* edit the filesystem: create /
  rename / move / delete files (`<leader>fe`).
- **flash.nvim** — jump anywhere on screen with 2 characters + a label
  (`<leader>j`); also upgrades `f`/`F`/`t`/`T` with labels.
- **harpoon** — bookmark the 3-4 files you are working on and switch with one
  key (`<leader>a` / `<leader>1..4`).
- **grug-far.nvim** — project-wide search & replace powered by ripgrep, with a
  live editable preview (`<leader>sr`).
- **which-key.nvim** — press `<Space>` and wait: popup with every keymap and
  what it does.

**Git**
- **gitsigns** — change markers in the gutter + hunk actions: jump (`]c` /
  `[c`), preview, stage and reset hunks without leaving the file.
- **lazygit.nvim** — full git UI inside Neovim (`<leader>gg`).

**Web development**
- **live-preview.nvim** — `:LivePreview start` serves the current HTML/CSS/JS
  or Markdown file in the browser and hot-reloads it on every save. No Node,
  no extensions. *(Static files only — PHP still needs `php -S localhost:8000`.)*
- **nvim-highlight-colors** — shows `#ff5500`, `rgb()`, `hsl()`… as the actual
  color, inline.

**Appearance**
- **tokyonight** — color scheme (`night` style, matched to the terminal).
- **lualine** + **nvim-web-devicons** — statusline with mode, git branch,
  diagnostics, selection/search counters and file icons.
- **nvim-notify** — `vim.notify()` as compact popups in the top-right corner,
  border colored by level: red = error, yellow = warning, green = ok
  (`:Notifications` shows the history).

> `noice.nvim` must **not** be added — it conflicts with the native
> `vim._core.ui2` UI already enabled in `init.lua`.

## Language servers

Auto-installed via Mason: `lua_ls`, `pyright`, `ts_ls`, `intelephense`,
`html`, `cssls`, `emmet_language_server`, `eslint`, `jsonls`.

> The `html` and `emmet_language_server` servers are also attached to `.php`
> files, so HTML completion and Emmet abbreviations (e.g. `!` + `Tab`) work
> inside PHP files with embedded HTML. PHP itself is still handled by
> `intelephense`.

## Formatting

Handled by **conform.nvim** (formatters installed via Mason). Formatting is
**not run on save** — it is triggered manually with `<leader>cf`, which formats
the buffer (or the visual selection) and then writes the file. This keeps `:w`
instant and lets you save without reformatting when you don't want to.

| Language | Formatter |
| --- | --- |
| Lua | `stylua` |
| Python | `black` |
| JS / TS / JSON | `biome` *(falls back to `prettierd`)* |
| HTML / CSS / SCSS | `prettierd` |
| PHP | `php-cs-fixer` *(needs a `composer.json` in the project)* |

> `biome` is a Rust formatter (no Node.js) — it formats JS/TS/JSON
> near-instantly. `prettierd` keeps a daemon running so HTML/CSS stay fast
> after the first call.

Formatters are not auto-installed — install them once via Mason:

```vim
:MasonInstall stylua black prettierd biome php-cs-fixer
```

## Editor behavior

Automatic behavior configured in `autocmd.lua`:

- Yanked (copied) text is briefly highlighted.
- The cursor returns to its last position when you reopen a file.
- Files changed outside Neovim (lazygit, `git checkout`…) are reloaded
  automatically.
- The terminal opens with no line numbers, already in insert mode.
- Splits are re-balanced when the terminal window is resized.
- Comment leaders are **not** auto-continued when you start a new line.
- Trailing whitespace is highlighted (mini.trailspace) and trimmed manually
  with `<leader>cw` — never silently on save.

## Keymaps

Leader is `<Space>`. **Press `<Space>` and wait** — which-key shows everything
below, live.

**Find (Telescope)**

| Key | Action |
| --- | --- |
| `<leader>ff` | Find **files** (project root) |
| `<leader>fg` | Live grep — search **text** in the whole project |
| `<leader>fe` | File browser — current file's directory |
| `<leader>fb` | Open buffers |
| `<leader>fr` | Resume the last picker |
| `<leader>ft` | TODO comments |
| `<leader>fs` | Symbols in the current file (functions, classes…) |

**Jump & switch**

| Key | Action |
| --- | --- |
| `<leader>j` | Flash — type 2 chars, jump anywhere on screen |
| `<leader>J` | Flash — select the treesitter node under the cursor |
| `f` / `t` (+ char) | Native motions, upgraded by Flash with jump labels |
| `<leader>a` | Harpoon — add the current file |
| `<leader>h` | Harpoon — open the menu (edit / reorder the list) |
| `<leader>1..4` | Harpoon — jump straight to file 1..4 |

**Git**

| Key | Action |
| --- | --- |
| `<leader>gg` | Open LazyGit |
| `]c` / `[c` | Next / previous change (hunk) in the file |
| `<leader>gp` | Preview the hunk under the cursor (see the diff) |
| `<leader>ga` | Stage the hunk (`git add` just that change) |
| `<leader>gr` | Reset the hunk (discard that change) |
| `<leader>gs` | Telescope — git status |
| `<leader>gc` | Telescope — git commits |
| `<leader>gb` | Telescope — git branches |

**LSP & code**

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `K` | Hover documentation *(native)* |
| `grr` | References of the symbol, in a Telescope picker |
| `<leader>cr` | Rename the symbol in the whole project |
| `<leader>ca` | Code action — fix, refactor… *(also in visual)* |
| `<leader>e` | Show diagnostic under cursor |
| `<leader>cf` | Format buffer / selection, then save |
| `<leader>cw` | Trim trailing whitespace + empty last lines |
| `<leader>sr` | Search & replace in the whole project (grug-far) |

**Editing**

| Key | Action |
| --- | --- |
| `sa` / `sd` / `sr` | Add / delete / replace surrounding pair (mini.surround) |
| `vif` / `via` / `viq` | Select inside function / argument / quotes (mini.ai) |
| `Alt+h/j/k/l` | Move line or selection (mini.move) |
| `p` *(visual)* | Paste without overwriting the register |
| `<Esc>` | Clear search highlight |

**Windows & terminal**

| Key | Action |
| --- | --- |
| `<leader>r` | Vertical split |
| `<C-h/j/k/l>` | Move to the split left / down / up / right |
| `<leader>t` | Open the terminal inside Neovim |
| `<Esc><Esc>` *(terminal)* | Back to normal mode |

## Commands

| Command | What it does |
| --- | --- |
| `:ConfigUpdate` | Pull the latest config from git, right from inside Neovim |
| `:LivePreview start` / `close` | Live browser preview of the current HTML/MD file |
| `:GrugFar` | Project-wide search & replace panel |
| `:Notifications` | History of the notification popups |
| `:Mason` | Manage language servers and formatters |
| `:TSInstall <lang>` | Install an extra Treesitter parser |

## Syncing changes

The whole point of this repo is that the config is the same on every machine.

**After editing on one machine**, push your changes:

```bash
git add -A
git commit -m "describe your changes"
git push
```

**On any other machine**, just run `:ConfigUpdate` from inside Neovim — no need
to leave the editor or remember git commands:

```vim
:ConfigUpdate
```

It runs `git pull --rebase --autostash` against this repo, so it:

- **never freezes the editor** — git runs asynchronously in the background;
- **keeps your local edits safe** — uncommitted changes are auto-stashed before
  the pull and restored after it (`--autostash`);
- **tells you exactly what happened** — *already up to date*, *updated*, or the
  git error, as a notification popup (green / yellow / red).

> After an update Neovim is still running the **old** config it loaded at
> startup. **Restart Neovim** to apply the new version — `:restart` on Neovim
> 0.11+, otherwise `:qa` and reopen.

The equivalent from a terminal, if you prefer:

```bash
git -C ~/.config/nvim pull
```
