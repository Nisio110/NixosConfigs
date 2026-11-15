{
  description = "Declarative NixOS config for my devices";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    lanzaboote.url = "github:nix-community/lanzaboote/v1.2.0";
    nixvim.url = "github:nix-community/nixvim";
    import-tree.url = "github:vic/import-tree";
    sops-nix.url = "github:mic92/sops-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    plasma-manager.url = "github:nix-community/plasma-manager";
    compose2nix.url = "github:aksiksi/compose2nix";
    niri-config.url = "github:sodiboo/niri-flake";
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  outputs = inputs @ { nixpkgs, home-manager, ... }: let
    system = "x86_64-linux";
    user = "oisin";

    homeDir = "/home/${user}";
    secretsDir = "${homeDir}/.local/secrets";

    mkSystem = { system, hostname, modulePath, hardwarePath, homePath, overlayPath, extraPaths ? [] }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs user homeDir secretsDir hostname system; };
        modules = [
          (inputs.import-tree ([ modulePath hardwarePath overlayPath ] ++ extraPaths))
          (mkHomeManager { hmDir = homePath; inherit hostname; })
        ];
      };

    mkHomeManager = { hmDir, hostname }: {
      imports = [ home-manager.nixosModules.home-manager ];
      home-manager = {
        users.oisin.imports = [ (inputs.import-tree hmDir) ];
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs user homeDir secretsDir hostname; };
      };
    };
  in {
    nixosConfigurations.hdesktop = mkSystem {
      inherit system;
      hostname = "hdesktop";
      modulePath = ./essentials;
      hardwarePath = ./hardware/hdesktop;
      homePath = ./home;
      overlayPath = ./overlays;
      extraPaths = [ ./home-server ];
    };

    nixosConfigurations.olaptop = mkSystem {
      inherit system;
      hostname = "olaptop";
      modulePath = ./essentials;
      hardwarePath = ./hardware/olaptop;
      homePath = ./home;
      overlayPath = ./overlays;
    };
  };
}
