# ==========================================
# SECRETS CONFIGURATION (sops-nix, home-manager)
# ==========================================
# Decrypts secrets via the sops-nix user service / HM activation.
# Secrets land at ~/.local/secrets/<name>.
#
# PREREQUISITE:
#   1. Age private key at ~/.local/secrets/sops/age/keys.txt
#      (must match the recipient listed in secrets/secrets.yaml)
#   2. Edit secrets with:  sops secrets/secrets.yaml
{ inputs, secretsDir,  ... }:
{
  imports = [ inputs.sops-nix.homeModules.sops ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "${secretsDir}/sops/age/keys.txt";

  sops.secrets = {
    github_token.path = "${secretsDir}/github_token";
    brave_api_key.path = "${secretsDir}/brave_api_key";
    kimi_api_key.path = "${secretsDir}/kimi_api_key";
    openrouter_api_key.path = "${secretsDir}/openrouter_api_key";
    openai_api_key.path = "${secretsDir}/openai_api_key";
    proxmox_host.path = "${secretsDir}/proxmox_host";
    proxmox_token_id.path = "${secretsDir}/proxmox_token_id";
    proxmox_token_secret.path = "${secretsDir}/proxmox_token_secret";
    browser_control.path = "${secretsDir}/browser_control";
    joplin_postgres.path = "${secretsDir}/joplin_postgres";
  };
}
