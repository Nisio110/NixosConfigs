{
  description = "Declarative NixOS config for my devices";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager    = {url = "github:nix-community/home-manager";     inputs.nixpkgs.follows = "nixpkgs";};
    winapps         = {url = "github:winapps-org/winapps";            inputs.nixpkgs.follows = "nixpkgs";};
    nixvim          = {url = "github:nix-community/nixvim";           inputs.nixpkgs.follows = "nixpkgs";};
    zen-browser     = {url = "github:0xc000022070/zen-browser-flake"; inputs.nixpkgs.follows = "nixpkgs";};
    plasma-manager  = {url = "github:nix-community/plasma-manager";   inputs.nixpkgs.follows = "nixpkgs";};

    nixos-hardware.url  = "github:NixOS/nixos-hardware/master";
    lanzaboote.url      = "github:nix-community/lanzaboote/v1.2.0";
    import-tree.url     = "github:vic/import-tree";
    sops-nix.url        = "github:mic92/sops-nix";
    compose2nix.url     = "github:aksiksi/compose2nix";
    niri-config.url     = "github:sodiboo/niri-flake";
    llm-agents.url      = "github:numtide/llm-agents.nix";
  };

  outputs = inputs @ { nixpkgs, home-manager, import-tree, ... }:
  let
    user = "oisin";

    homeDir = "/home/${user}";
    secretsDir = "${homeDir}/.local/secrets";

    mkSystem = hostname:
    { 
      system ? "x86_64-linux", 
      moduleDir, 
      hardwareDir, 
      hmMgrDir, 
      overlayDir, 
      extraDirs ? [] 
    }: 
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs user homeDir secretsDir hostname system; };
      modules = [
        (import-tree ([ 
          moduleDir 
          hardwareDir 
          overlayDir 
        ] ++ extraDirs))

        (mkHomeManager { inherit hostname hmMgrDir;})
      ];
    };

    mkHomeManager = { hmMgrDir, hostname }: {
      imports = [ home-manager.nixosModules.home-manager ];
      home-manager = {
        users.oisin.imports = [ (inputs.import-tree hmMgrDir) ];
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs user homeDir secretsDir hostname; };
      };
    };
  in 
  {
    nixosConfigurations.hdesktop = mkSystem "hdesktop" {
      moduleDir    = ./essentials;
      hardwareDir  = ./hardware/hdesktop;
      hmMgrDir     = ./home-mgr;
      overlayDir   = ./overlays;
      extraDirs    = [ ./home-server ];
    };

    nixosConfigurations.olaptop = mkSystem "olaptop" {
      moduleDir    = ./essentials;
      hardwareDir  = ./hardware/olaptop;
      hmMgrDir     = ./home-mgr;
      overlayDir   = ./overlays;
    };
  };
}
