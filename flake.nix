{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    import-tree.url = "github:vic/import-tree";

    bun-bin = {
      url = "https://github.com/oven-sh/bun/releases/latest/download/bun-linux-x64.zip";
      type = "file";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.home-manager.follows = "home-manager";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.home-manager.follows = "home-manager";
    };

    compose2nix = {
      url = "github:aksiksi/compose2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-config = {
      url = "github:sodiboo/niri-flake";
    };
  };

  outputs = inputs @ { nixpkgs, home-manager, ... }: let

    system = "x86_64-linux";
    user = "oisin";

    homeDir = "/home/${user}";
    secretsDir = "${homeDir}/.local/secrets";

    mkSystem = { system, modulePath, homePath}: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs user homeDir secretsDir; };
      modules = [ 
        (inputs.import-tree modulePath) 
        (mkHomeManager homePath)
        inputs.niri-config.nixosModules.niri
      ];
    };

    mkHomeManager = hmDir: {
      imports = [home-manager.nixosModules.home-manager];
      home-manager = {
        users.oisin.imports = [ (inputs.import-tree hmDir) ];
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs user homeDir secretsDir; };
      };
    };

  in {
    nixosConfigurations.nixos = mkSystem {
      inherit system;
      modulePath = ./nixos/modules;
      homePath = ./nixos/home;
    };
  };
}
