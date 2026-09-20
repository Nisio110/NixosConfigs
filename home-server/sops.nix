{secretsDir, ...}: {
  sops.defaultSopsFile = ../secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "${secretsDir}/sops/age/keys.txt";
}
