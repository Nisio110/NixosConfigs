{
  description = "My home desktop system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";
    import-tree.url = "github:vic/import-tree";
    sops-nix.url = "github:mic92/sops-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    plasma-manager.url = "github:nix-community/plasma-manager";
    compose2nix.url = "github:aksiksi/compose2nix";
    niri-config.url = "github:sodiboo/niri-flake";

    bun-bin = {
      url = "https://github.com/oven-sh/bun/releases/latest/download/bun-linux-x64.zip";
      type = "file";
      flake = false;
    };

  };

  outputs = inputs @ { nixpkgs, home-manager, ... }: let

    system = "x86_64-linux";
    user = "oisin";
    hostname = "hdesktop";

    homeDir = "/home/${user}";
    secretsDir = "${homeDir}/.local/secrets";

    mkSystem = { system, modulePath, homePath, overlayPath, extraPaths }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs user homeDir secretsDir hostname; };
        modules = [ 
          (inputs.import-tree ([ modulePath overlayPath ] ++ extraPaths)) 
          (mkHomeManager homePath)
        ];
      };

    mkHomeManager = hmDir: {
      imports = [home-manager.nixosModules.home-manager];
      home-manager = {
        users.oisin.imports = [ (inputs.import-tree hmDir) ];
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs user homeDir secretsDir hostname; };
      };
    };

  in {
    nixosConfigurations.${hostname} = mkSystem {
      inherit system;
      modulePath = ./essentials;
      homePath = ./home;
      overlayPath = ./overlays;
      extraPaths = [
        ./home-server
      ];
    };
  };
}
