{ pkgs, ... }:

{
  # codecompanion is in nixpkgs.vimPlugins. We could use plugins.codecompanion
  # but the custom adapter extension is a function — easier to write the whole
  # setup() call in raw lua.
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    codecompanion-nvim
  ];

  programs.nixvim.extraConfigLua = ''
    require("codecompanion").setup({
      strategies = {
        chat   = { adapter = "anthropic" },
        inline = { adapter = "anthropic" },
        cmd    = { adapter = "anthropic" },
      },
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            schema = {
              model = { default = "claude-sonnet-4.6" },
            },
          })
        end,
      },
    })
  '';

  programs.nixvim.keymaps = [
    { mode = [ "n" "v" ]; key = "<leader>aa"; action = "<cmd>CodeCompanionActions<cr>";     options.desc = "AI actions"; }
    { mode = [ "n" "v" ]; key = "<leader>ac"; action = "<cmd>CodeCompanionChat Toggle<cr>"; options.desc = "AI chat toggle"; }
    { mode = "v";          key = "<leader>aA"; action = "<cmd>CodeCompanionChat Add<cr>";   options.desc = "Add selection to chat"; }
    { mode = [ "n" "v" ]; key = "<leader>ai"; action = ":CodeCompanion ";                    options.desc = "AI inline (cmd)"; }
  ];
}
