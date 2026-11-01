{pkgs,...}:{
  services.xserver.enable = true;
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
  services.xserver.xkb = {
      layout = "gb-tilde";
      variant = "";

      extraLayouts."gb-tilde" = {
        description = "British Mac with section key mapped to tilde";
        languages = [ "eng" ];

        symbolsFile = pkgs.writeText "gb-tilde" ''
          default partial alphanumeric_keys
          xkb_symbols "basic" {
            include "gb(mac)"
            replace key <TLDE> {
              type[Group1] = "ONE_LEVEL",
              symbols[Group1] = [ asciitilde ]
            };
          };
        '';
      };
    };
}
