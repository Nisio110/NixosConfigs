
{ config, inputs, secretsDir, ... }:
{
  imports = [ inputs.sops-nix.homeModules.sops ];

  sops.defaultSopsFile = ../../secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "${secretsDir}/sops/age/keys.txt";

  sops.secrets = {
    github_token = { };
    brave_api_key = { };
    openrouter_api_key.path = "${secretsDir}/openrouter_api_key";
    openai_api_key.path = "${secretsDir}/openai_api_key";
  };

  # Rendered env files for MCP wrapper scripts / interactive shell — see
  # ./mcp.nix and ./shell.nix. Replaces cat-ing the raw decrypted secret
  # file at process launch: the token now only ever exists in the one
  # sops-nix-rendered file, substituted in from a placeholder at
  # activation time (never touches the Nix store).
  sops.templates."github.env".content = ''
    GITHUB_TOKEN=${config.sops.placeholder.github_token}
    GITHUB_PERSONAL_ACCESS_TOKEN=${config.sops.placeholder.github_token}
  '';

  sops.templates."brave.env".content = ''
    BRAVE_API_KEY=${config.sops.placeholder.brave_api_key}
  '';
}
