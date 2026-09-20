# Custom vim-plugin derivations for plugins that either aren't in
# nixpkgs.vimPlugins, or that we want pinned to the exact commit from
# the original lazy-lock.json.
#
# Each entry uses `pkgs.vimUtils.buildVimPlugin` with `pkgs.fetchFromGitHub`.
# To bump a plugin: change the `rev`, run:
#   nix-prefetch-url --unpack --type sha256 https://github.com/OWNER/REPO/archive/NEW-REV.tar.gz
#   nix hash convert --hash-algo sha256 --to sri <base32>
# then paste the result into `hash`.

{ pkgs, ...}:

let
  inherit (pkgs) fetchFromGitHub;
  inherit (pkgs.vimUtils) buildVimPlugin;

  # Convenience builder.
  fromGH = { name, owner, repo, rev, hash }:
    buildVimPlugin {
      pname = name;
      version = rev;
      src = fetchFromGitHub { inherit owner repo rev hash; };
      doCheck = false;
    };
in
{
  evergarden = fromGH {
    name = "evergarden";
    owner = "everviolet"; repo = "nvim";
    rev = "6296e20b9ea3da19c34b008d05f29efd00f3c0bf";
    hash = "sha256-xDAoR6aIygYNI9Ek9IYnZhdAO8nRpuY9+mpRQnfMFfA=";
  };

  bg-nvim = fromGH {
    name = "bg.nvim";
    owner = "typicode"; repo = "bg.nvim";
    rev = "85da2c68409820466753b50c2e6f699517778a17";
    hash = "sha256-s9m5OgQpehrkIU6bWj70RDEqvSzlxzpih8sRuQrtdC0=";
  };

  nvim-file-watch = fromGH {
    name = "nvim-file-watch";
    owner = "awalland"; repo = "nvim-file-watch";
    rev = "db03ec9c4f6d91f74ddb230165b46ef14b4a1172";
    hash = "sha256-N+DPGnatXwnf3bUIg+JaeEPHGSWyFJ/IKjO350Nagvs=";
  };

  lastplace-nvim = fromGH {
    name = "lastplace.nvim";
    owner = "nxhung2304"; repo = "lastplace.nvim";
    rev = "d1f1ec30fc639864bd71dd7c28a2164bc423ef40";
    hash = "sha256-PvSOzQ1wnU/hPmD/HJ3i2X7vkKdhFsOMwioUiy9pVOU=";
  };

  numb-nvim = fromGH {
    name = "numb.nvim";
    owner = "nacro90"; repo = "numb.nvim";
    rev = "12ef3913dea8727d4632c6f2ed47957a993de627";
    hash = "sha256-RisbKK1mTrYnIFfsODx7zdy76lYsHXpWWPrM6wpO9Ds=";
  };

  yankbank-nvim = fromGH {
    name = "yankbank-nvim";
    owner = "ptdewey"; repo = "yankbank-nvim";
    rev = "a0706a44103c189f090a6ae1f029117d02b647a6";
    hash = "sha256-/SJ0eVWxgWQ7eLTc7B6Sw72DfROXJxXDVl2UGhrxIpQ=";
  };

  select-undo-nvim = fromGH {
    name = "select-undo.nvim";
    owner = "SunnyTamang"; repo = "select-undo.nvim";
    rev = "d5aa1f0dbef93b7ed4219ef8c7bfae9691264ef7";
    hash = "sha256-DQcUwuHRfpFuab7Gx6vIgOHGI2HJ4WMSvOqMtXnej6U=";
  };

  hypersonic-nvim = fromGH {
    name = "Hypersonic.nvim";
    owner = "tomiis4"; repo = "Hypersonic.nvim";
    rev = "734dfbfbe51952f102a9b439d53d4267bb0024cd";
    hash = "sha256-V9dBAadK4tx+M+adWxKZ+7t6wKdA0ojIgBd+sNysZJ8=";
  };

  remote-ssh-nvim = fromGH {
    name = "remote-ssh.nvim";
    owner = "inhesrom"; repo = "remote-ssh.nvim";
    rev = "b0fc5c8452b83a81bdf9bf19db3afacb26e41720";
    hash = "sha256-sLUZd8zBdLpZwvZAbNzsZLakhDPdgqxLUXZVGBpgLew=";
  };

  telescope-remote-buffer = fromGH {
    name = "telescope-remote-buffer";
    owner = "inhesrom"; repo = "telescope-remote-buffer";
    rev = "341bd7abae5f46d08d2af99d24ed05247311207e";
    hash = "sha256-fuUJG77fxR5PHc1Mig+ExlP9L6f6uvJvv2JqTb1ClJk=";
  };

  switchboard-nvim = fromGH {
    name = "switchboard.nvim";
    owner = "karshPrime"; repo = "switchboard.nvim";
    rev = "1640fd68d917bea531a4073765b388f85ebc5979";
    hash = "sha256-dfYULSnym/mbXIOXUvx1wC+kJD9zpTUDEEjRVwgPz4A=";
  };

  tabman-nvim = fromGH {
    name = "tabman.nvim";
    owner = "wsdjeg"; repo = "tabman.nvim";
    rev = "6469911cf079de28c376ae56ace0a4cedfd8b2fe";
    hash = "sha256-FMuUQR+Dhd0l7BSYkdYgkD0P2an65LeF/hmGlctxmMY=";
  };

  nvim-foldsign = fromGH {
    name = "nvim-foldsign";
    owner = "yaocccc"; repo = "nvim-foldsign";
    rev = "cd45e684ccfdd4fb7d92c64101794917d172078f";
    hash = "sha256-9zdV9U8Wgx9Y8Nq/B6F06KII32zfSids4DcxXuebguQ=";
  };

  nvim-hlchunk = fromGH {
    name = "nvim-hlchunk";
    owner = "yaocccc"; repo = "nvim-hlchunk";
    rev = "f089ae4446357bfaa8c7c718eae7fdf62315a7f8";
    hash = "sha256-TS3i+qGdDS//Z/GfZGdSCTLO7pKyBoO3ws3TMbmiXcU=";
  };

  smooth-resize-nvim = fromGH {
    name = "smooth-resize.nvim";
    owner = "aronjohanns"; repo = "smooth-resize.nvim";
    rev = "5218aedc1dedb9c0c0f105b73f46e601f712a786";
    hash = "sha256-urDPO0d+WGCaDJzyp3D6u48Fi0W/qs+OhqUtJiW3irc=";
  };

  wrapped-nvim = fromGH {
    name = "wrapped.nvim";
    owner = "aikhe"; repo = "wrapped.nvim";
    rev = "d475a9380a8d642d2844b47db292fb63c5f0fae3";
    hash = "sha256-6Mx1i47hQqgOGIas4fIOz0gorz9Lcsu2Zuj/c+6mnJY=";
  };

  volt = fromGH {
    name = "volt";
    owner = "nvzone"; repo = "volt";
    rev = "620de1321f275ec9d80028c68d1b88b409c0c8b1";
    hash = "sha256-5Xao1+QXZOvqwCXL6zWpckJPO1LDb8I7wtikMRFQ3Jk=";
  };
}
