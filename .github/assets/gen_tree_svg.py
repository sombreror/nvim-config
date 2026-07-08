#!/usr/bin/env python3
"""Generate the colored structure tree SVG (tokyonight palette, terminal-window style)."""

import os
import re

# (line, kind) — kind decides the color of the NAME part
# name column is padded so every '#' comment starts at the same column
LINES = [
    (".", "root", ""),
    ("├── init.lua", "entry", "Entry point — loads everything below"),
    ("├── nvim-pack-lock.json", "json", "Pinned plugin versions (reproducible installs)"),
    ("├── snippets/", "dir", "Custom snippets, loaded by blink.cmp"),
    ("└── lua/", "dir", ""),
    ("    ├── config/", "dir", ""),
    ("    │   ├── options.lua", "lua", "Editor options"),
    ("    │   ├── keymaps.lua", "lua", "All keyboard shortcuts"),
    ("    │   ├── autocmd.lua", "lua", "Automatic editor behavior"),
    ("    │   └── commands.lua", "lua", "Custom user commands (:ConfigUpdate)"),
    ("    └── plugins/", "dir", ""),
    ("        ├── init.lua", "entry", "Plugin list (vim.pack) — loads the modules below"),
    ("        ├── completion.lua", "lua", "blink.cmp + lazydev source"),
    ("        ├── treesitter.lua", "lua", "Treesitter parsers (tree-sitter-manager)"),
    ("        ├── editing.lua", "lua", "conform, autopairs, mini.*, todo-comments, grug-far"),
    ("        ├── git.lua", "lua", "gitsigns + hunk keymaps"),
    ("        ├── telescope.lua", "lua", "Telescope + fzf + file browser"),
    ("        ├── navigation.lua", "lua", "flash, harpoon, which-key"),
    ("        ├── ui.lua", "lua", "tokyonight, lualine, nvim-notify, highlight-colors"),
    ("        └── lsp.lua", "lua", "Mason + servers + formatters + lazydev (loaded last)"),
]

# tokyonight night palette
COL = {
    "bg": "#1a1b26",
    "border": "#2f334d",
    "branch": "#3b4261",   # tree glyphs
    "comment": "#565f89",  # descriptions + window title
    "root": "#565f89",
    "dir": "#7aa2f7",      # blue, bold
    "lua": "#c0caf5",      # foreground
    "entry": "#bb9af7",    # purple: the two init.lua entry points
    "json": "#e0af68",     # orange: the lockfile
    "dot_r": "#f7768e", "dot_y": "#e0af68", "dot_g": "#9ece6a",
}

FONT = "ui-monospace,SFMono-Regular,'JetBrains Mono',Menlo,Consolas,monospace"
FS = 13.5          # font size
CW = FS * 0.602    # monospace advance width estimate (used only for panel sizing)
X0, Y0, LH = 30, 78, 23
COMMENT_COL = 34   # column where '# ' starts

def esc(s: str) -> str:
    return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")

def split_branch(line: str):
    """Split leading tree glyphs/indent from the name."""
    m = re.match(r"^([\s│├└─]*)(.*)$", line)
    return m.group(1), m.group(2)

body = []
for i, (line, kind, comment) in enumerate(LINES):
    y = Y0 + i * LH
    branch, name = split_branch(line)
    bold = ' font-weight="bold"' if kind in ("dir", "entry") else ""
    tspans = ""
    if branch:
        tspans += f'<tspan fill="{COL["branch"]}">{esc(branch)}</tspan>'
    tspans += f'<tspan fill="{COL[kind]}"{bold}>{esc(name)}</tspan>'
    if comment:
        pad = " " * max(1, COMMENT_COL - len(line))
        tspans += f'<tspan fill="{COL["comment"]}">{esc(pad)}# {esc(comment)}</tspan>'
    body.append(
        f'<text x="{X0}" y="{y}" xml:space="preserve" font-family="{FONT}" '
        f'font-size="{FS}">{tspans}</text>'
    )

max_chars = max(len(l) + (len(" " * max(1, COMMENT_COL - len(l))) + 2 + len(c) if c else 0)
                for l, _, c in LINES)
W = int(X0 * 2 + max_chars * CW)
H = Y0 + len(LINES) * LH + 4

svg = f'''<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}" role="img" aria-label="File structure of the config">
  <rect x="1" y="1" width="{W - 2}" height="{H - 2}" rx="12" fill="{COL['bg']}" stroke="{COL['border']}" stroke-width="2"/>
  <circle cx="26" cy="26" r="6.5" fill="{COL['dot_r']}"/>
  <circle cx="48" cy="26" r="6.5" fill="{COL['dot_y']}"/>
  <circle cx="70" cy="26" r="6.5" fill="{COL['dot_g']}"/>
  <text x="{W // 2}" y="31" text-anchor="middle" font-family="{FONT}" font-size="13" fill="{COL['comment']}">~/.config/nvim</text>
  <line x1="1" y1="48" x2="{W - 1}" y2="48" stroke="{COL['border']}" stroke-width="1.5"/>
{chr(10).join('  ' + t for t in body)}
</svg>
'''

out = os.path.join(os.path.dirname(os.path.abspath(__file__)), "structure.svg")
os.makedirs(os.path.dirname(out), exist_ok=True)
with open(out, "w") as f:
    f.write(svg)
print(f"written: {out}  ({W}x{H}, {len(LINES)} lines)")
