{ ... }:

{
  programs.nixvim = {
    # ---- core editor options ----
    opts = {
      # Indentation: 4-space soft tabs everywhere
      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      wrap = false;
      number = true;

      # Hide the command line until you actually need it
      cmdheight = 0;

      # Force 24-bit colour so evergarden's hex palette renders correctly
      # even when COLORTERM isn't propagated (e.g. inside tmux without
      # terminal-features RGB).
      termguicolors = true;
    };

    globals = {
      mapleader = " ";

      # Disable language-host providers we don't use; silences :checkhealth
      # warnings about missing pynvim / npm neovim / Neovim::Ext / neovim-ruby.
      loaded_node_provider = 0;
      loaded_perl_provider = 0;
      loaded_python3_provider = 0;
      loaded_ruby_provider = 0;
    };

    # `eob = " "` hides the `~` end-of-buffer markers. nixvim doesn't expose
    # fillchars as a structured option, so set it via raw lua post-init.
    extraConfigLua = ''
      vim.opt.fillchars:append({ eob = " " })
    '';

    # Kitty padding tweak: kitty remote control over the socket configured in
    # kitty.conf. Removes padding while nvim is focused, restores on exit.
    autoCmd = [
      {
        event = [ "VimEnter" ];
        callback = {
          __raw = ''
            function()
              vim.fn.system("kitty @ --to unix:/tmp/mykitty set-spacing padding=0")
            end
          '';
        };
      }
      {
        event = [ "VimLeave" ];
        callback = {
          __raw = ''
            function()
              vim.fn.system("kitty @ --to unix:/tmp/mykitty set-spacing padding=default")
            end
          '';
        };
      }
    ];
  };
}
