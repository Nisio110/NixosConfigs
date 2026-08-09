
{ inputs, secretsDir,  ... }:
{
  imports = [ inputs.sops-nix.homeModules.sops ];

  sops.defaultSopsFile = ../../secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "${secretsDir}/sops/age/keys.txt";

  sops.secrets = {
    github_token.path = "${secretsDir}/github_token";
    brave_api_key.path = "${secretsDir}/brave_api_key";
    openrouter_api_key.path = "${secretsDir}/openrouter_api_key";
    openai_api_key.path = "${secretsDir}/openai_api_key";
    joplin_postgres.path = "${secretsDir}/joplin_postgres";
  };
}
