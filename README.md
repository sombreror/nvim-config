# nvim-config

My personal [Neovim](https://neovim.io/) configuration.

It uses the native package manager **`vim.pack`** — plugins are pinned in
[`nvim-pack-lock.json`](./nvim-pack-lock.json), so you get the exact same
versions on every machine.

## Requirements

- **Neovim 0.12+**, required for `vim.pack` and the experimental
  `vim._core.ui2` UI.
- `git`
- [`lazygit`](https://github.com/jesseduffield/lazygit) — for the in-editor git
  integration (`<leader>gg`).
- A **Nerd Font** in your terminal — for the statusline and file-type icons.
- `ripgrep` — for Telescope's text search (`live_grep`).
- `make` + a C compiler (`gcc`) — to build `telescope-fzf-native` on first
  install.
- `fd` *(optional)* — faster file finding for Telescope.

## Installation

Clone the repo into Neovim's config folder:

```bash
git clone git@github.com:sombreror/nvim-config.git ~/.config/nvim
```

> If `~/.config/nvim` already exists, back it up first:
> ```bash
> mv ~/.config/nvim ~/.config/nvim.bak
> ```

On the first launch of `nvim`, `vim.pack` will automatically download the
plugins according to the lock file.

`telescope-fzf-native` ships a C sorter that must be compiled once. After the
plugins are downloaded, build it with:

```bash
make -C ~/.local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim
```

Re-run this command whenever the plugin is updated.

## Structure

```
.
├── init.lua                 # Entry point
├── nvim-pack-lock.json      # Pinned plugin versions
└── lua/
    ├── config/
    │   ├── options.lua       # Neovim options
    │   └── keymaps.lua       # Keyboard shortcuts
    └── plugins/
        └── init.lua          # Plugin definitions and setup
```

The leader key is set to `<Space>`.

## Features

What is currently configured.

### Plugins

- **nvim-lspconfig** + **mason** + **mason-lspconfig** => install and enable the
  language servers.
- **blink.cmp** + **friendly-snippets** => autocompletion and snippets.
- **tree-sitter-manager** => Treesitter parsers (auto-installed).
- **nvim-autopairs** => auto-closes brackets and quotes.
- **gitsigns** => git signs in the gutter + blame.
- **lazygit.nvim** => opens lazygit inside Neovim.
- **tokyonight** => color scheme (`night` style, matched to the terminal).
- **lualine** + **nvim-web-devicons** => statusline with mode, git branch,
  diagnostics, selection/search counters and file icons.
- **telescope** + **telescope-fzf-native** => fuzzy finder for files, text and
  git, with a native (C) sorter for faster, smarter matching.

### Language servers

Auto-installed via Mason: `lua_ls`, `pyright`, `ts_ls`, `intelephense`,
`html`, `cssls`, `emmet_language_server`, `eslint`, `jsonls`.

### Keymaps

| Key | Action |
| --- | --- |
| `<leader>ff` | Telescope: find files |
| `<leader>fr` | Telescope: resume last picker |
| `<leader>gs` | Telescope: git status |
| `<leader>gc` | Telescope: git commits |
| `<leader>gb` | Telescope: git branches |
| `<leader>gg` | Open LazyGit |
| `<leader>r` | Vertical split |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move to the split left / down / up / right |
| `<Esc>` | Clear search highlight |
| `p` *(visual)* | Paste without overwriting the register |

## Roadmap

Graphics and UX customizations still to add:

- [ ] **bufferline** => tabs for the open files at the top
- [ ] **file explorer** => neo-tree or oil.nvim
- [ ] **which-key** => popup with the available keys
- [ ] **indent-blankline** => indentation guides
- [ ] **rainbow-delimiters** => brackets colored by level
- [ ] **nvim-colorizer** => show `#hex` / `rgb()` colors inline (handy for CSS)
- [ ] **dashboard** => start screen (alpha / snacks)
- [ ] **satellite / scrollbar** => scrollbar with git signs
- [ ] **todo-comments** => highlight `TODO:` / `FIXME:`
- [ ] **trouble** => tidy panel for errors/diagnostics
- [ ] **telescope** => add `live_grep` / `buffers` keymaps
- [ ] **obsidian.nvim** => notes / vault integration (under evaluation)

> Note: `noice.nvim` (redesigned cmdline/notifications) must NOT be added =>
> it conflicts with the native `vim._core.ui2` UI already used in `init.lua`.

## Syncing changes

After editing the config:

```bash
git add -A
git commit -m "describe your changes"
git push
```

On another machine, update before working with:

```bash
git pull
```
