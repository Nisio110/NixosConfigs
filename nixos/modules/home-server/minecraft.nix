{config, pkgs, ...}:
let
  tetoPlush = pkgs.fetchurl {
    url = "https://tetoplush.com/wp-content/uploads/2025/03/Teto-Plush-2-768x768.png";
    sha256 = "sha256-Cb3MVvjm1EJgs/yADvKiy9mh5VAtCFqsP30+LsOyjMU=";
  };
in
{
  services.minecraft-server.enable = true;
  systemd.tmpfiles.rules = [
    "L+ /var/lib/minecraft/server-icon.png - - - - ${tetoPlush}"
  ];

  sops.secrets.mc-rcon-password = {};

  services.minecraft-server = {
    eula = true;
    dataDir = "/var/lib/minecraft";
    jvmOpts = "-Xmx4096M -Xms1024M";
    whitelist = {
      Flameman110 = "a31c5b36-209e-43af-b8e6-1f3c27d0cc4e";
    };
    serverProperties = {
      server-ip = "127.0.0.1";
      server-port = 6464;
      enable-rcon = true;
      "rcon.password" = config.sops.placeholder.mc-rcon-password;
      prevent-proxy-connections = false;
      "query.port" = 25565;
      rate-limit = 0;
      "rcon.port" = 25575;

      motd = "TetoCraft - A NixOS Minecraft server!";
      difficulty = "medium";
      gamemode = "survival";
      hardcore = false;
      max-players = 5;
      view-distance = 10;

      accepts-transfers = false;
      allow-flight = false;

      broadcast-console-to-ops = true;
      broadcast-rcon-to-ops = true;

      bug-report-link = "";
      chat-spam-threshold-seconds = 10;
      command-spam-threshold-seconds = 10;

      enable-code-of-conduct = false;
      enable-jmx-monitoring = false;
      enable-query = false;
      enable-status = true;

      enforce-secure-profile = true;
      enforce-whitelist = false;

      entity-broadcast-range-percentage = 100;
      force-gamemode = false;
      function-permission-level = 2;

      generate-structures = true;
      generator-settings = "{}";

      hide-online-players = false;

      initial-disabled-packs = "";
      initial-enabled-packs = "vanilla";

      level-name = "world";
      level-seed = "";
      level-type = "minecraft:normal";

      log-ips = true;

      management-server-allowed-origins = "craft.tetocorp.ie 127.0.0.1 192.168.0.19";
      management-server-enabled = true;
      management-server-host = "localhost";
      management-server-port = 4646;
      management-server-secret = "[Random text]";
      management-server-tls-enabled = false;
      management-server-tls-keystore = "";
      management-server-tls-keystore-password = "";

      max-chained-neighbor-updates = 1000000;
      max-tick-time = 60000;
      max-world-size = 29999984;

      network-compression-threshold = 256;
      online-mode = true;
      
      op-permission-level = 4;
      pause-when-empty-seconds = 60;
      player-idle-timeout = 0;

      region-file-compression = "deflate";
      require-resource-pack = false;

      resource-pack = "";
      resource-pack-id = "";
      resource-pack-prompt = "";
      resource-pack-sha1 = "";

      simulation-distance = 10;
      spawn-protection = 16;

      status-heartbeat-interval = 0;
      sync-chunk-writes = true;

      text-filtering-config = "";
      text-filtering-version = 0;

      use-native-transport = true;
      white-list = true;
    };
  };
}

