# nvim-config

My personal [Neovim](https://neovim.io/) configuration — fast, native, and
reproducible.

It is built around Neovim's native package manager **`vim.pack`**. Every plugin
is pinned in [`nvim-pack-lock.json`](./nvim-pack-lock.json), so the exact same
versions are restored on any machine. The leader key is `<Space>`.

> Big thanks to [**kickstart.nvim**](https://github.com/nvim-lua/kickstart.nvim) —
> it was an invaluable guide for learning how a Neovim config is structured and
> where a lot of the ideas here come from. A great starting point if you want to
> build your own.

## Learning Neovim

Before reaching for the internet, use Neovim's **built-in documentation** — it is
excellent, always matches the version you are running, and is the single best way
to learn the editor. It is highly recommended.

**Help system** — every option, command and function is documented:

| Command | What it does |
| --- | --- |
| `:help` | Open the main help page |
| `:help <topic>` | Help for a specific topic, e.g. `:help vim.pack` |
| `:help <keys>` | What a key does, e.g. `:help <C-w>` or `:help :w` |
| `:helpgrep <text>` | Search the full text of all help files |
| `K` | Open help (or LSP hover docs) for the word under the cursor |
| `<C-]>` / `<C-o>` | Jump to a tag link in help / jump back |

> Inside a help buffer, links are the words wrapped in `|bars|`. Put the cursor on
> one and press `<C-]>` to follow it, `<C-o>` to go back.

**Interactive tutorial** — the fastest way to get the fundamentals into your
fingers:

```vim
:Tutor
```

`:Tutor` opens a ~30-minute hands-on lesson (movement, editing, search,
saving…). Work through it directly inside Neovim — it is the recommended starting
point for anyone new to the editor.

## Requirements

| Tool | Why |
| --- | --- |
| **Neovim 0.12+** | Required for `vim.pack` and the experimental `vim._core.ui2` UI |
| `git` | Plugin downloads and version control |
| [`lazygit`](https://github.com/jesseduffield/lazygit) | In-editor git UI (`<leader>gg`) |
| **Nerd Font** | Statusline and file-type icons |
| `ripgrep` | Telescope text search (`live_grep`) |
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

> **Neovim 0.12+ is required** (for `vim.pack` and the native `vim._core.ui2`
> UI). If your package manager ships an older version, install a newer build
> from <https://github.com/neovim/neovim/releases>.

Also install a **[Nerd Font](https://www.nerdfonts.com/)** and select it in your
terminal, otherwise the statusline and file-type icons render as boxes.

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
pinned in [`nvim-pack-lock.json`](./nvim-pack-lock.json). Wait for it to finish,
then quit with `:qa`.

The language servers ([listed below](#language-servers)) and Treesitter parsers
are installed **automatically** by Mason and `tree-sitter-manager` on this first
run.

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

```
.
├── init.lua                  # Entry point — loads the modules below
├── nvim-pack-lock.json       # Pinned plugin versions
├── snippets/                 # Custom snippets, loaded by blink.cmp (html.json, …)
└── lua/
    ├── config/
    │   ├── options.lua        # Neovim options
    │   ├── keymaps.lua        # Keyboard shortcuts
    │   ├── autocmd.lua        # Automatic editor behavior
    │   └── commands.lua       # Custom user commands (:ConfigUpdate)
    └── plugins/
        ├── init.lua           # Plugin list (vim.pack) — loads the modules below
        ├── completion.lua     # blink.cmp
        ├── treesitter.lua     # Treesitter parsers (tree-sitter-manager)
        ├── editing.lua        # conform, autopairs, mini.move/surround, todo-comments
        ├── git.lua            # gitsigns
        ├── telescope.lua      # Telescope + fzf + file browser
        ├── ui.lua             # tokyonight + lualine
        └── lsp.lua            # Mason + language servers (loaded last)
```

## Plugins

**LSP & completion**
- **nvim-lspconfig** + **mason** + **mason-lspconfig** — install and enable the
  language servers.
- **blink.cmp** + **friendly-snippets** — autocompletion and snippets.

**Editing**
- **tree-sitter-manager** — Treesitter parsers (auto-installed).
- **nvim-autopairs** — auto-closes brackets and quotes.
- **conform.nvim** — code formatting, one formatter per language (triggered
  manually — see [Formatting](#formatting)).
- **mini.surround** — add / change / delete surrounding pairs (`sa` / `sd` /
  `sr`).
- **mini.move** — move lines and visual selections with `Alt+hjkl`.
- **todo-comments.nvim** — highlights `TODO` / `FIXME` / `HACK` / `WARN` /
  `NOTE` and lists them with Telescope (`<leader>ft`).

**Search & navigation**
- **telescope** + **telescope-fzf-native** — fuzzy finder for files, text and
  git, with a native (C) sorter for faster, smarter matching.
- **telescope-file-browser** — browse *and* edit the filesystem from Telescope:
  navigate directories and create / rename / move / delete files
  (`<leader>fe`).

**Git**
- **gitsigns** — git signs in the gutter + blame.
- **lazygit.nvim** — opens lazygit inside Neovim.

**Appearance**
- **tokyonight** — color scheme (`night` style, matched to the terminal).
- **lualine** + **nvim-web-devicons** — statusline with mode, git branch,
  diagnostics, selection/search counters and file icons.

> `noice.nvim` must **not** be added — it conflicts with the native
> `vim._core.ui2` UI already enabled in `init.lua`.

## Language servers

Auto-installed via Mason: `lua_ls`, `pyright`, `ts_ls`, `intelephense`,
`html`, `cssls`, `emmet_language_server`, `eslint`, `jsonls`.

> The `html` and `emmet_language_server` servers are also attached to `.php`
> files, so HTML completion and Emmet abbreviations (e.g. `!`) work inside PHP
> files with embedded HTML. PHP itself is still handled by `intelephense`.

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

> `biome` is a Rust formatter (no Node.js) — it formats JS/TS/JSON near-instantly.
> `prettierd` keeps a daemon running so HTML/CSS stay fast after the first call.

Formatters are not auto-installed — install them once via Mason:

```vim
:MasonInstall stylua black prettierd biome php-cs-fixer
```

## Editor behavior

Automatic behavior configured in `autocmd.lua`:

- Yanked (copied) text is briefly highlighted.
- The cursor returns to its last position when you reopen a file.
- Trailing whitespace is trimmed on save.
- Comment leaders are **not** auto-continued when you start a new line.

## Keymaps

Leader is `<Space>`.

**Find & navigate (Telescope)**

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files (project root) |
| `<leader>fe` | File browser — current file's directory |
| `<leader>fb` | Buffers |
| `<leader>fr` | Resume last picker |
| `<leader>ft` | TODO comments |

**Git**

| Key | Action |
| --- | --- |
| `<leader>gg` | Open LazyGit |
| `<leader>gs` | Telescope — git status |
| `<leader>gc` | Telescope — git commits |
| `<leader>gb` | Telescope — git branches |

**LSP & code**

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `<leader>e` | Show diagnostic under cursor |
| `<leader>cf` | Format buffer / selection, then save |

**Windows & editing**

| Key | Action |
| --- | --- |
| `<leader>r` | Vertical split |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move to the split left / down / up / right |
| `<Esc>` | Clear search highlight |
| `p` *(visual)* | Paste without overwriting the register |

## Commands

Custom commands defined in `commands.lua`:

| Command | What it does |
| --- | --- |
| `:ConfigUpdate` | Pull the latest config from git, right from inside Neovim |

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
  git error, decided by comparing the commit hash before/after (so it works
  whatever language git is set to).

> After an update Neovim is still running the **old** config it loaded at
> startup. **Restart Neovim** to apply the new version — `:restart` on Neovim
> 0.11+, otherwise `:qa` and reopen.

The equivalent from a terminal, if you prefer:

```bash
git -C ~/.config/nvim pull
```
