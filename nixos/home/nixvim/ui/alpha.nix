{
  programs.nixvim.plugins.alpha = {
    enable = true;
    theme = "startify";

    # The startify theme already wires up sections; we only override the header
    # banner. Each entry below is one line of the ASCII art.
    # iconsEnabled = true;

    settings.layout = [
      { type = "padding"; val = 4; }
      {
        type = "text";
        val = [
          ""
          "       ████ ██████           █████      ██                     "
          "      ███████████             █████                             "
          "      █████████ ███████████████████ ███   ███████████   "
          "     █████████  ███    █████████████ █████ ██████████████   "
          "    █████████ ██████████ █████████ █████ █████ ████ █████   "
          "  ███████████ ███    ███ █████████ █████ █████ ████ █████  "
          " ██████  █████████████████████ ████ █████ █████ ████ ██████ "
          ""
        ];
        opts = { position = "center"; hl = "Type"; };
      }
      { type = "padding"; val = 2; }
    ];
  };
}
