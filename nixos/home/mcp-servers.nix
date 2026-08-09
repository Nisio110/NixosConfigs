# ==========================================
# MCP SERVERS — single source for every Nix-managed MCP server
# ==========================================
# Registered with Oh My Pi in ./oh-my-pi.nix (ompMcp); binaries land in the
# per-user profile. Secret-reading servers use runtime wrappers so tokens
# never enter the world-readable nix store: each wrapper cats
# ~/.local/secrets/<name> (decrypted by sops-nix, see ./secrets.nix) at launch.
# kwin-mcp and computer-use-linux are bespoke ~/.local/bin tools — registry
# entries only in oh-my-pi.nix, nothing to package here.
{ pkgs, ... }:
let
  zen-mcp = pkgs.buildNpmPackage rec {
    pname = "zen-mcp";
    version = "1.2.3";

    src = pkgs.fetchFromGitHub {
      owner = "sh6drack";
      repo = "zen-mcp";
      rev = "76aa1e7140d6ae2b9400fd6d95eb8ee666facfd7"; # v1.2.3
      hash = "sha256-TppTNWrU19uL+ATQqXJIZNb8E51rlj1Hdl+FMiu0qGg=";
    };

    npmDepsHash = "sha256-LPz9uX+y5IiJXxxERgMKL1UpJc5WN1/WfQnS+ZF+yQ0=";

    nodejs = pkgs.nodejs_22; # package.json requires node >=20

    # No "build" script in package.json (only start/test/launch-zen).
    dontNpmBuild = true;

    nativeBuildInputs = [ pkgs.makeWrapper ];

    # Single-file ESM server + 2 runtime deps. Ship both; wrap node like
    # browser-control-mcp does. server.mjs is ESM (package.json type=module),
    # so `node server.mjs` runs it directly.
    installPhase = ''
      runHook preInstall
      mkdir -p "$out/lib/zen-mcp" "$out/bin"
      cp -r server.mjs node_modules "$out/lib/zen-mcp/"
      makeWrapper ${pkgs.nodejs_22}/bin/node "$out/bin/zen-mcp" \
        --add-flags "$out/lib/zen-mcp/server.mjs"
      runHook postInstall
    '';

    meta = {
      description = "MCP server for Zen Browser automation via WebDriver BiDi";
      homepage = "https://github.com/sh6drack/zen-mcp";
      license = pkgs.lib.licenses.mit;
      mainProgram = "zen-mcp";
    };
  };

  # @modelcontextprotocol/server-brave-search — npm-deprecated; source frozen in
  # the archived monorepo (repo archived 2025-05-28, immutable pin). Built from
  # the workspace exactly like nixpkgs' own mcp-server-filesystem
  # (pkgs/by-name/mc/mcp-server-filesystem/package.nix): npmWorkspace +
  # dontNpmPrune + sibling-symlink cleanup.
  mcp-server-brave-search = pkgs.buildNpmPackage {
    pname = "mcp-server-brave-search";
    version = "0.6.2";

    src = pkgs.fetchFromGitHub {
      owner = "modelcontextprotocol";
      repo = "servers-archived";
      rev = "9be4674d1ddf8c469e6461a27a337eeb65f76c2e"; # HEAD of main; repo is archived
      hash = "sha256-GD0MIgh+vxI65vUb8UKWn5eD970ICbi2Mnr26O3+fRk=";
    };

    npmDepsHash = "sha256-tUc8O2KmoGhSA9gVS2YMUPWvpJxEM6iD8gf/oIoTqk4=";
    npmDepsFetcherVersion = 2; # workspace support: enables packument caching so
      # @modelcontextprotocol/sdk (a shared workspace dep) is resolvable offline.
    npmWorkspace = "src/brave-search";
    dontNpmPrune = true;

    # dontNpmPrune keeps devDependencies of sibling workspaces around too;
    # one sibling server (puppeteer) tries to download Chrome on install,
    # which fails offline in the build sandbox. brave-search never uses it.
    env.PUPPETEER_SKIP_DOWNLOAD = true;

    nativeBuildInputs = [ pkgs.typescript ];

    # npm workspaces symlink every monorepo member into node_modules —
    # servers-archived has 14 (aws-kb-retrieval-server, brave-search,
    # everart, gdrive, git, github, gitlab, google-maps, postgres,
    # puppeteer, redis, sentry, slack, sqlite), both under the
    # @modelcontextprotocol/ scope and, for deps like `redis`, unscoped.
    # $out only ships the servers-archived workspace root, not every
    # sibling's src/ dir, so those symlinks resolve during the build (full
    # monorepo present) but are left dangling in $out. Same class of
    # workaround as nixpkgs' mcp-server-filesystem, generalized to a sweep
    # since servers-archived has far more siblings than the pruned `servers`
    # repo that package hand-enumerates.
    postInstall = ''
      find $out/lib/node_modules/@modelcontextprotocol/servers/node_modules -maxdepth 2 -xtype l -delete
      rm -rf $out/lib/node_modules/@modelcontextprotocol/servers/node_modules/.bin
    '';

    meta = {
      description = "MCP server for Brave Search API integration";
      homepage = "https://github.com/modelcontextprotocol/servers-archived";
      license = pkgs.lib.licenses.mit;
      mainProgram = "mcp-server-brave-search";
    };
  };

  # Upstream github.com/k-krawczyk/proxmox-mcp-server was deleted (noticed
  # 2026-08; no fork or archive survives), so the author's npm release is the
  # only remaining distribution. The tarball ships prebuilt dist/
  # (prepublishOnly ran tsc) but, like all npm tarballs, no lockfile — so a
  # devDependencies-free package.json + generated lock are vendored in ./mcp.
  # Tarball verified against the registry integrity for 0.2.0
  # (sha512-ERKK37kMCtFJpKZOr0GV75zoacwSlQTSK+eFV8hTK1zERZfoicQfVQfZFk8QqVyf7THb2MtI+zpGL4mbWaTBkg==).

  # ── Secret wrappers ─────────────────────────────────────────────
  # Declare-then-export (two lines) is required: `export FOO=$(...)` fails
  # writeShellApplication's shellcheck (SC2155).

  mcp-github = pkgs.writeShellApplication {
    name = "mcp-github";
    runtimeInputs = [ pkgs.github-mcp-server ];
    text = ''
      GITHUB_PERSONAL_ACCESS_TOKEN=$(cat "$HOME/.local/secrets/github_token")
      export GITHUB_PERSONAL_ACCESS_TOKEN
      exec github-mcp-server stdio
    '';
  };

  mcp-brave-search = pkgs.writeShellApplication {
    name = "mcp-brave-search";
    runtimeInputs = [ mcp-server-brave-search ];
    text = ''
      BRAVE_API_KEY=$(cat "$HOME/.local/secrets/brave_api_key")
      export BRAVE_API_KEY
      exec mcp-server-brave-search
    '';
  };
in {
  home.packages = [
    # standalone bespoke npm build
    zen-mcp
    # secret wrappers (each pulls its pinned server in as a dependency)
    mcp-github
    mcp-brave-search
    pkgs.mcp-nixos
    (pkgs.lib.setPrio 4 pkgs.mcp-server-filesystem)
    (pkgs.lib.setPrio 5 pkgs.mcp-server-memory)
    (pkgs.lib.setPrio 6 pkgs.mcp-server-sequential-thinking)
    pkgs.mcp-server-fetch
    pkgs.context7-mcp
  ];

  # zen-mcp connects over WebDriver BiDi to a Zen instance started with the
  # remote-debugging port open. Zen is Firefox-based: launching the normal
  # profile while a Zen instance is already running just forwards to it and the
  # port never opens. So use a dedicated, auto-created profile dir + MOZ_NO_REMOTE
  # to force a separate instance that runs ALONGSIDE the daily browser.
  # Binary is `zen-beta` (zen-browser-flake beta module installs only
  # bin/zen-beta; there is no bare `zen` on PATH). Tilde expands at alias-use
  # time (same as the existing `reload` alias), so ~ is correct here.
  # Note: `--profile <path>` requires the directory to exist; `mkdir -p` ensures
  # it is created on first run (Zen does not auto-create the directory).
  home.shellAliases.zen-debug =
    "mkdir -p ~/.zen-mcp-profile && MOZ_NO_REMOTE=1 zen-beta --profile ~/.zen-mcp-profile --remote-debugging-port 9222";
}
