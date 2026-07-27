{ ... }:

{
  programs.nixvim.plugins.which-key = {
    enable = true;
    settings = {
      preset = "modern";
      delay = 1000;
      spec = [
        { __unkeyed-1 = "<leader>f";  group = "find"; }
        { __unkeyed-1 = "<leader>g";  group = "git / format"; }
        { __unkeyed-1 = "<leader>gh"; group = "hunks"; }
        { __unkeyed-1 = "<leader>c";  group = "code"; }
        { __unkeyed-1 = "<leader>d";  group = "debug"; }
        { __unkeyed-1 = "<leader>ds"; group = "step"; }
        { __unkeyed-1 = "<leader>x";  group = "diagnostics / trouble"; }
        { __unkeyed-1 = "<leader>b";  group = "buffers"; }
        { __unkeyed-1 = "<leader>h";  group = "harpoon"; }
        { __unkeyed-1 = "<leader>t";  group = "terminal"; }
        { __unkeyed-1 = "<leader>q";  group = "session"; }
        { __unkeyed-1 = "<leader>r";  group = "run / tests"; }
        { __unkeyed-1 = "<leader>o";  group = "overseer / tasks"; }
        { __unkeyed-1 = "<leader>a";  group = "ai"; }
        { __unkeyed-1 = "<leader>u";  group = "utility"; }
        { __unkeyed-1 = "<leader>z";  group = "zen"; }
        { __unkeyed-1 = "<leader>w";  group = "window / tabs"; }
      ];
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>?";
      action.__raw = ''function() require("which-key").show({ global = false }) end'';
      options.desc = "Buffer-local keymaps (which-key)";
    }
  ];
}
