{ config, lib, pkgs, ... }:
let
  agentDir = "${config.home.homeDirectory}/.omp/agent";

  # Mirrors the current ~/.omp/agent/config.yml (settings source of truth).
  ompConfig = {
    symbolPreset = "nerd";
    theme = { dark = "dark-reef"; light = "light"; };
    setupVersion = 1;
    modelRoles = {
      default = "openai/gpt-5.6-terra:high";
      #plan = "openai/gpt-5.6-sol:high";
      #advisor = "openai/gpt-5.6-sol:high";
    };
    images = { blockImages = false; };
    display = { shimmer = "classic"; showTokenUsage = true; };
    tui = { hyperlinks = "auto"; textSizing = false; };
    browser = { headless = true; };
    tools = { approvalMode = "yolo"; };
    memory = { backend = "local"; };
    web_search = { provider = "brave"; };
    providers = { webSearch = "brave"; openrouterVariant = "default"; };
    statusLine = {
      transparent = true;
      separator = "powerline";
      sessionAccent = true;
      preset = "default";
    };
    hideThinkingBlock = false;
    personality = "pragmatic";
    emojiAutocomplete = false;
    features = { unexpectedStopDetection = true; };
    branchSummary = { enabled = true; };
    autolearn = { enabled = true; };
    edit = { mode = "hashline"; };
    read = { toolResultPreview = true; summarize = { prose = true; }; };
    renderMermaid = { enabled = true; };
    checkpoint = { enabled = true; };
    advisor = { enabled = true; };
  };

  # Mirrors the current ~/.omp/agent/mcp.json.
  # All nix-managed server binaries come from ./mcp-servers.nix.
  # kwin-mcp and computer-use-linux remain bespoke ~/.local/bin wrappers
  # (Python venv / cargo binary); their registry entries are preserved verbatim.
  ompMcp = {
    "$schema" = "https://raw.githubusercontent.com/can1357/oh-my-pi/main/packages/coding-agent/src/config/mcp-schema.json";
    mcpServers = {
      "kwin-mcp" = {
        command = "${config.home.homeDirectory}/.local/bin/kwin-mcp";
        args = [ ];
      };
      "computer-use-linux" = {
        command = "${config.home.homeDirectory}/.local/bin/computer-use-linux";
        args = [ "mcp" ];
      };
      "nixos" = {
        command = "${config.home.profileDirectory}/bin/mcp-nixos";
        args = [ ];
      };
      "browser-control" = {
        command = "${config.home.profileDirectory}/bin/mcp-browser-control";
        args = [ ];
      };
      "zen-browser" = {
        command = "${config.home.profileDirectory}/bin/zen-mcp";
        args = [ ];
      };
      # ── Ported from the Macbook opencode setup (packages: ./mcp-servers.nix) ──
      # Secret-dependent servers go through mcp-* wrappers; keys must NOT be
      # put in this attrset's env (the generated json source lives in the
      # world-readable nix store).
      "github" = {
        command = "${config.home.profileDirectory}/bin/mcp-github";
        args = [ ];
      };
      "filesystem" = {
        command = "${config.home.profileDirectory}/bin/mcp-server-filesystem";
        args = [ config.home.homeDirectory ];
      };
      "memory" = {
        command = "${config.home.profileDirectory}/bin/mcp-server-memory";
        args = [ ];
      };
      "fetch" = {
        command = "${config.home.profileDirectory}/bin/mcp-server-fetch";
        args = [ ];
      };
      "brave-search" = {
        command = "${config.home.profileDirectory}/bin/mcp-brave-search";
        args = [ ];
      };
      "sequential-thinking" = {
        command = "${config.home.profileDirectory}/bin/mcp-server-sequential-thinking";
        args = [ ];
      };
      "context7" = {
        command = "${config.home.profileDirectory}/bin/context7-mcp";
        args = [ ];
      };
      "proxmox" = {
        command = "${config.home.profileDirectory}/bin/mcp-proxmox";
        args = [ ];
      };
    };
  };

  configYml = (pkgs.formats.yaml { }).generate "omp-config.yml" ompConfig;
  mcpJson = (pkgs.formats.json { }).generate "omp-mcp.json" ompMcp;
in
{
  # Writable seed (not a read-only home.file symlink): install the Nix-declared
  # content over the target on every activation. Runtime edits persist between
  # rebuilds; each switch re-seeds and overwrites drift. mode 600 matches the
  # current files.
  home.activation.ompConfigSeed = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p ${lib.escapeShellArg agentDir}
    run install -m600 ${configYml} ${lib.escapeShellArg "${agentDir}/config.yml"}
    run install -m600 ${mcpJson} ${lib.escapeShellArg "${agentDir}/mcp.json"}
  '';
}
