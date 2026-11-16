# Neovim Config

Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim)

---

## Active Plugins

### Colorscheme
| Plugin | Description |
|--------|-------------|
| [everviolet/nvim](https://github.com/everviolet/nvim) | Active colorscheme (`evergarden`, `fall` variant) |

### LSP & Completion
| Plugin | Description |
|--------|-------------|
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configurations |
| [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) | LSP server / tool installer |
| [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Bridge between mason and lspconfig |
| [saghen/blink.cmp](https://github.com/saghen/blink.cmp) | Completion engine (Rust-powered fuzzy) |
| [folke/lazydev.nvim](https://github.com/folke/lazydev.nvim) | Lua LSP completions for Neovim config |

### Formatting & Linting
| Plugin | Description |
|--------|-------------|
| [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) | Auto-formatter (format-on-save) |
| [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint) | Async linter |
| [WhoIsSethDaniel/mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Auto-install formatters/linters via mason |

### Treesitter
| Plugin | Description |
|--------|-------------|
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting and code parsing |

### Navigation & Search
| Plugin | Description |
|--------|-------------|
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder (`<C-p>` files, `<leader>fg` grep) |
| [nvim-telescope/telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim) | Telescope-powered `vim.ui.select` |
| [folke/flash.nvim](https://github.com/folke/flash.nvim) | Fast jump navigation (`s`/`S`) |
| [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon) | Quick file switching (harpoon2) |
| [stevearc/aerial.nvim](https://github.com/stevearc/aerial.nvim) | Symbol outline panel |
| [folke/persistence.nvim](https://github.com/folke/persistence.nvim) | Session save/restore |
| [wsdjeg/tabman.nvim](https://github.com/wsdjeg/tabman.nvim) | Interactive tab/window manager (`<leader>wt`) |

### File Management
| Plugin | Description |
|--------|-------------|
| [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File tree explorer (`<C-n>`) |
| [mikavilpas/yazi.nvim](https://github.com/mikavilpas/yazi.nvim) | Yazi terminal file manager integration |

### Remote Editing
| Plugin | Description |
|--------|-------------|
| [inhesrom/remote-ssh.nvim](https://github.com/inhesrom/remote-ssh.nvim) | Edit, browse, and run TUIs over SSH (`:RemoteOpen`, `<leader>uR`) |

### Git
| Plugin | Description |
|--------|-------------|
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs in gutter, hunk staging/reset |
| [NeogitOrg/neogit](https://github.com/NeogitOrg/neogit) | Magit-style git porcelain (`<leader>gg`) |

### Debugging
| Plugin | Description |
|--------|-------------|
| [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol client |
| [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | DAP UI (auto-opens on debug start) |
| [mfussenegger/nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Python DAP adapter (debugpy) |

### Testing
| Plugin | Description |
|--------|-------------|
| [nvim-neotest/neotest](https://github.com/nvim-neotest/neotest) | Test runner framework |
| [nvim-neotest/neotest-python](https://github.com/nvim-neotest/neotest-python) | Python adapter for neotest |
| [rouge8/neotest-rust](https://github.com/rouge8/neotest-rust) | Rust adapter for neotest |
| [marilari88/neotest-vitest](https://github.com/marilari88/neotest-vitest) | Vitest adapter for neotest |
| [stevearc/overseer.nvim](https://github.com/stevearc/overseer.nvim) | Task runner / build system integration |

### Terminal
| Plugin | Description |
|--------|-------------|
| [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Toggle floating/split terminals (`<C-\>`) |

### Tmux Integration
Loaded only when nvim runs inside a tmux session (`$TMUX` set).

| Plugin | Description |
|--------|-------------|
| [aserowy/tmux.nvim](https://github.com/aserowy/tmux.nvim) | Vim↔tmux pane navigation (`<C-h/j/k/l>`), clipboard sync |
| [karshPrime/switchboard.nvim](https://github.com/karshPrime/switchboard.nvim) | Run build/run commands in tmux pane or float (`<leader>rb`/`<leader>rr`) |

### Language Support
| Plugin | Description |
|--------|-------------|
| [mrcjkb/rustaceanvim](https://github.com/mrcjkb/rustaceanvim) | Rust (rust-analyzer, inlay hints, clippy) |
| [pmizio/typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim) | TypeScript/JavaScript LSP tools |
| [p00f/clangd_extensions.nvim](https://github.com/p00f/clangd_extensions.nvim) | C/C++ clangd extensions (AST, inlay hints) |
| [linux-cultist/venv-selector.nvim](https://github.com/linux-cultist/venv-selector.nvim) | Python venv picker |

### Editing
| Plugin | Description |
|--------|-------------|
| [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets/quotes |
| [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround) | Surround text objects (add/change/delete) |
| [echasnovski/mini.ai](https://github.com/echasnovski/mini.ai) | Enhanced `a`/`i` text objects |
| [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) | Comment toggling (`gcc` line, `gc` operator, `gbc` block) |
| [nxhung2304/lastplace.nvim](https://github.com/nxhung2304/lastplace.nvim) | Restore cursor to last edit position on file open |
| [nacro90/numb.nvim](https://github.com/nacro90/numb.nvim) | Peek line preview while typing `:NN` jump |
| [ptdewey/yankbank-nvim](https://github.com/ptdewey/yankbank-nvim) | Yank history picker (`<leader>uy`) |
| [SunnyTamang/select-undo.nvim](https://github.com/SunnyTamang/select-undo.nvim) | Undo within a visual selection (`<leader>us` v, `<leader>uS` line) |
| [tomiis4/Hypersonic.nvim](https://github.com/tomiis4/Hypersonic.nvim) | Regex explainer — `:Hypersonic` or visual `<leader>uh` |
| [willothy/moveline.nvim](https://github.com/willothy/moveline.nvim) | Move lines/blocks up/down (`<M-j>`/`<M-k>`, requires `cargo`) |

### UI
| Plugin | Description |
|--------|-------------|
| [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim) | Start screen / dashboard |
| [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs (`<S-h>`/`<S-l>` to cycle) |
| [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line |
| [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) | Notification popups |
| [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) | Improved `vim.ui.input` / `vim.ui.select` |
| [folke/which-key.nvim](https://github.com/folke/which-key.nvim) | Key binding hints popup |
| [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight and search `TODO`/`FIXME`/etc. |
| [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Rendered markdown in-editor |
| [folke/trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics, quickfix, LSP refs panel |
| [yaocccc/nvim-hlchunk](https://github.com/yaocccc/nvim-hlchunk) | Highlight chunk/scope around cursor |
| [yaocccc/nvim-foldsign](https://github.com/yaocccc/nvim-foldsign) | Sign-column indicators for open/closed folds |
| [folke/zen-mode.nvim](https://github.com/folke/zen-mode.nvim) | Distraction-free single-window mode (`<leader>zz`) |
| [aronjohanns/smooth-resize.nvim](https://github.com/aronjohanns/smooth-resize.nvim) | Animate `<C-w>` window resize keys |
| [aikhe/wrapped.nvim](https://github.com/aikhe/wrapped.nvim) | "Spotify Wrapped"-style stats dashboard (`:WrappedNvim`) |

### AI
| Plugin | Description |
|--------|-------------|
| [olimorris/codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) | AI coding assistant (Claude / Anthropic) |

### Miscellaneous
| Plugin | Description |
|--------|-------------|
| [typicode/bg.nvim](https://github.com/typicode/bg.nvim) | Terminal background image passthrough |

### Dependencies
Plugins used only as dependencies of the above:

| Plugin | Required by |
|--------|-------------|
| [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | telescope, harpoon, neo-tree, todo-comments, yazi, codecompanion |
| [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | alpha, neo-tree, bufferline, render-markdown |
| [saghen/blink.lib](https://github.com/saghen/blink.lib) | blink.cmp (Rust binary) |
| [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | blink.cmp |
| [nvim-neotest/nvim-nio](https://github.com/nvim-neotest/nvim-nio) | neotest, nvim-dap-ui |
| [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim) | neo-tree |
| [antoinemadec/FixCursorHold.nvim](https://github.com/antoinemadec/FixCursorHold.nvim) | neotest |
| [nvzone/volt](https://github.com/nvzone/volt) | wrapped.nvim |
| [inhesrom/telescope-remote-buffer](https://github.com/inhesrom/telescope-remote-buffer) | remote-ssh |

---

## Plugin Integration Notes

### nvim-autopairs + blink.cmp (`<CR>` conflict)

nvim-autopairs maps `<CR>` in insert mode by default, which intercepts blink.cmp's confirm binding before it fires. To fix this:

- Set `map_cr = false` in autopairs opts to stop it owning `<CR>`
- Call `blink.cmp.on_confirm_done(autopairs.autopairs_cr())` so autopairs still adds closing pairs after a completion is accepted

This is configured in `lua/plugins/editing.lua`.

---

## Notes on the nixvim / Nix port

This config is being ported to a home-manager setup using [nixvim](https://github.com/nix-community/nixvim). After the port, the day-to-day editor experience is largely identical — same plugins, same keymaps, same colorscheme — but a number of things change in how the config is managed and how new tools enter the editor.

### What stays the same

- Every keymap, including `<leader>` groupings and the which-key descriptions
- The full plugin set (with a couple of niche exceptions noted in the migration commit)
- The look: evergarden `fall`, the alpha dashboard, lualine, bufferline
- LSP, formatter, linter, and DAP behaviour from your point of view
- The kitty padding tweaks, the codecompanion adapter, the autocmds in `vim-options.lua`

### What changes mechanically

**Plugin manager.** lazy.nvim is gone. Nixvim wires plugins straight into nvim's runtime path at build time, so there is no plugin manager UI inside the editor. No `:Lazy sync`, no `:Lazy update`, no `lazy-lock.json`. Plugin versions are pinned by nixpkgs (or by flake inputs for plugins you override manually).

**Config language.** Each plugin's `opts = { ... }` table moves into a Nix attribute set:

```lua
-- before (lua/plugins/git.lua)
{ "lewis6991/gitsigns.nvim", opts = { signs = { add = { text = "│" } } } }
```

```nix
# after (nixvim)
plugins.gitsigns = {
  enable = true;
  settings.signs.add.text = "│";
};
```

Anything that does not fit cleanly into nix — a function for `on_attach`, a config block that calls multiple Lua APIs, a complex closure — goes inside `extraConfigLua = '' ... ''` or a per-plugin `extraConfigLua`. So the final config is a mix of nix attribute sets and lua heredocs, weighted heavily toward nix.

**Mason is gone.** mason / mason-lspconfig / mason-tool-installer were the previous way to install clangd, clang-format, ruff, prettierd, codelldb, debugpy, shellcheck, markdownlint, etc. None of that works on NixOS — mason fetches prebuilt binaries that fail at runtime because the standard FHS dynamic linker is not where they expect it. The replacement mapping is:

| Was installed by mason                              | Now comes from                                                                                |
|-----------------------------------------------------|-----------------------------------------------------------------------------------------------|
| LSP servers (clangd, pyright, lua-ls, ts_ls, etc.)  | `plugins.lsp.servers.<name>.enable = true;` — nixvim pulls the package from nixpkgs           |
| Formatters (stylua, clang-format, prettierd, ruff)  | `home.packages = [ pkgs.stylua pkgs.clang-tools ... ]` — installed alongside nvim             |
| Linters (cppcheck, eslint_d, shellcheck, markdownlint) | `home.packages = [ ... ]` — same idea                                                       |
| DAP adapters (codelldb, debugpy)                    | Nix store paths, referenced directly in the DAP config (no more `vim.fn.stdpath("data") .. "/mason/bin/codelldb"`) |

The `:Mason`, `:MasonInstall`, and `:MasonToolsUpdate` commands stop existing. There is nothing to manage from inside nvim — it is all in the nix config.

**Treesitter parsers.** No more `:TSInstall <lang>`. Parsers are listed in nixvim's `plugins.treesitter` settings, which map to grammar derivations in nixpkgs and are built at home-manager switch time. `auto_install = true` becomes a no-op.

**Lazy loading.** lazy.nvim's `event = "VeryLazy"`, `ft = "rust"`, `cmd = "..."` get translated to nixvim's equivalent options where supported. Plugins added through `extraPlugins` (the escape hatch for plugins without first-class nixvim support) load eagerly by default. In practice this costs a little startup time but is rarely noticeable; specific plugins can be opted into lazy loading if startup gets sluggish.

### What changes in workflow

**Adding or removing a plugin.** Before: edit a `.lua` file, save, `:Lazy sync`. After: edit a `.nix` file, save, `home-manager switch`, restart nvim. The rebuild is a few seconds for a config-only change and longer if a plugin has to be built from source.

**Updating plugins.** Before: `:Lazy update`. After: `nix flake update` (which updates nixpkgs and therefore every plugin pinned to it), then `home-manager switch`. Per-plugin granularity requires pinning that one plugin to a specific commit as its own flake input and updating just that input.

**Iterating on a config change.** lazy.nvim let you `:source %` a plugin file to reload it. Nixvim requires the switch-and-restart cycle. For exploratory Lua tweaks you can still drop into `:lua` interactively, but anything you want to keep goes through nix. Practical effect: a bit more upfront thinking, fewer hot-reloads.

**Trying out a new plugin.** No `:Lazy install <repo>` to test in place. Either add it to the nix config and rebuild (the nixvim way), or temporarily clone it and `:packadd` it by hand (escape hatch, not recommended long-term).

### Plugins that need extra plumbing

A few of the plugins in this config don't have first-class nixvim options. They get added via `extraPlugins` and configured in Lua heredocs rather than nix attribute sets — same behaviour, same keymaps, just configured Lua-side. The notable cases:

- **`moveline.nvim`** — needs `cargo build` at install time, so it's wrapped in a `rustPlatform.buildRustPackage` derivation. You won't see the build; nix handles it.
- **`blink.cmp`** — also has a rust component, but nixpkgs already packages it correctly with the prebuilt fuzzy matcher.
- **Niche plugins** (yankbank, select-undo, Hypersonic, switchboard, wrapped, bg.nvim, hlchunk, foldsign, smooth-resize, lastplace, numb, tabman, file-watch, remote-ssh, evergarden, clangd_extensions, etc.) are added the same way — declared once in a nix list, their `setup()` calls go in a single `extraConfigLua` block.

### Files that disappear

- `lazy-lock.json` — replaced by `flake.lock`
- `init.lua` — nixvim generates the init script itself
- `lua/vim-options.lua` — folded into `opts`, `globals`, and `autoCmd` attributes in nix
- `lua/plugins.lua` — empty in the current config, not carried over
- `lua/plugins/*.lua` — replaced by the nix module(s) for each plugin group
