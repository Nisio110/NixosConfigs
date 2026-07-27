{ ... }:

{
  # lazydev.nvim — workspace lua type info for editing nvim config.
  # The blink.cmp side of the integration (the `lazydev` source in
  # `sources.default` plus the `providers.lazydev` provider) lives in
  # completion.nix to avoid a list-merge fight between modules.
  programs.nixvim.plugins.lazydev = {
    enable = true;
    settings = {
      library = [
        { path = "$\{3rd}/luv/library"; words = [ "vim%.uv" ]; }
        # The second library entry from the original lua config pointed at
        # lazy.nvim's source — dropped, since lazy.nvim is gone in this port.
      ];
    };
  };
}
