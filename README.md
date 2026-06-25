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

## Requirements

| Tool | Why |
| --- | --- |
| **Neovim 0.12+** | Required for `vim.pack` and the experimental `vim._core.ui2` UI |
| `git` | Plugin downloads and version control |
| [`lazygit`](https://github.com/jesseduffield/lazygit) | In-editor git UI (`<leader>gg`) |
| **Nerd Font** | Statusline and file-type icons |
| `ripgrep` | Telescope text search (`live_grep`) |
| `make` + `gcc` | Build `telescope-fzf-native` once on install |
| `fd` *(optional)* | Faster file finding for Telescope |

## Installation

Clone the repo into Neovim's config folder:

```bash
git clone git@github.com:sombreror/nvim-config.git ~/.config/nvim
```

> If `~/.config/nvim` already exists, back it up first:
> ```bash
> mv ~/.config/nvim ~/.config/nvim.bak
> ```

On the first launch of `nvim`, `vim.pack` downloads the plugins according to the
lock file. Then build the Telescope C sorter once:

```bash
make -C ~/.local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim
```

> Re-run that command whenever `telescope-fzf-native` is updated.

## Structure

```
.
├── init.lua                  # Entry point — loads the modules below
├── nvim-pack-lock.json       # Pinned plugin versions
└── lua/
    ├── config/
    │   ├── options.lua        # Neovim options
    │   ├── keymaps.lua        # Keyboard shortcuts
    │   └── autocmd.lua        # Automatic editor behavior
    └── plugins/
        └── init.lua           # Plugin list and setup
```

## Plugins

**LSP & completion**
- **nvim-lspconfig** + **mason** + **mason-lspconfig** — install and enable the
  language servers.
- **blink.cmp** + **friendly-snippets** — autocompletion and snippets.

**Editing**
- **tree-sitter-manager** — Treesitter parsers (auto-installed).
- **nvim-autopairs** — auto-closes brackets and quotes.
- **conform.nvim** — formats code on save, one formatter per language.

**Search & navigation**
- **telescope** + **telescope-fzf-native** — fuzzy finder for files, text and
  git, with a native (C) sorter for faster, smarter matching.

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

## Formatters

Run on save by **conform.nvim** (formatters installed via Mason). Fast languages
format synchronously; PHP runs asynchronously so saves stay instant.

| Language | Formatter |
| --- | --- |
| Lua | `stylua` |
| Python | `black` |
| JS / TS / JSON / HTML / CSS | `prettierd` |
| PHP | `php-cs-fixer` *(async — needs a `composer.json` in the project)* |

## Editor behavior

Automatic behavior configured in `autocmd.lua`:

- Yanked (copied) text is briefly highlighted.
- On save, the buffer is formatted by conform (see [Formatters](#formatters)).

## Keymaps

| Key | Action |
| --- | --- |
| `<leader>ff` | Telescope — find files |
| `<leader>fr` | Telescope — resume last picker |
| `<leader>gs` | Telescope — git status |
| `<leader>gc` | Telescope — git commits |
| `<leader>gb` | Telescope — git branches |
| `<leader>gg` | Open LazyGit |
| `<leader>r` | Vertical split |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move to the split left / down / up / right |
| `<Esc>` | Clear search highlight |
| `p` *(visual)* | Paste without overwriting the register |

## Syncing changes

After editing the config:

```bash
git add -A
git commit -m "describe your changes"
git push
```

On another machine, pull before working:

```bash
git pull
```
