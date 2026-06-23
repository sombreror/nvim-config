# nvim-config

La mia configurazione personale di [Neovim](https://neovim.io/).

Usa il package manager nativo **`vim.pack`** — i plugin sono pinnati in
[`nvim-pack-lock.json`](./nvim-pack-lock.json), così ottieni le stesse versioni
su ogni dispositivo.

## Requisiti

- **Neovim 0.12+** (nightly), necessario per `vim.pack` e l'UI sperimentale
  `vim._core.ui2`.
- `git`

## Installazione

Clona la repo nella cartella di config di Neovim:

```bash
git clone git@github.com:sombreror/nvim-config.git ~/.config/nvim
```

> Se la cartella `~/.config/nvim` esiste già, fanne prima un backup:
> ```bash
> mv ~/.config/nvim ~/.config/nvim.bak
> ```

Al primo avvio di `nvim`, `vim.pack` scaricherà automaticamente i plugin
secondo il lock file.

## Struttura

```
.
├── init.lua                 # Punto d'ingresso
├── nvim-pack-lock.json      # Versioni pinnate dei plugin
└── lua/
    ├── config/
    │   ├── options.lua       # Opzioni di Neovim
    │   └── keymaps.lua       # Scorciatoie da tastiera
    └── plugins/
        └── init.lua          # Definizione dei plugin
```

Il leader è impostato su `<Spazio>`.

## Sincronizzare le modifiche

Dopo aver modificato il config:

```bash
git add -A
git commit -m "descrizione delle modifiche"
git push
```

Su un altro dispositivo, prima di lavorare aggiorna con:

```bash
git pull
```
