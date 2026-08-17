{homeDir, user, ...}:
{
  services.suwayomi-server = {
    enable = true;

    user = "oisin";
    group = "users";
    dataDir = "${homeDir}";

    settings.server = {
      ip = "127.0.0.1";
      port = 9090;
      localSourcePath = "${homeDir}/Documents/Manga/Sources";
      extensionRepos = [
        "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.pb"
        "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json"
      ];
      flareSolverrEnabled = true;
      #flareSolverrUrl = "http://127.0.0.1:9009";
      flareSolverrUrl = "http://cloudflare-bypass.tetocorp.ie";
    };
  };

  systemd.tmpfiles.rules = [
    "d /home/oisin/Documents/Manga 0755 ${user} users -"
    "d /home/oisin/Documents/Manga/Sources 0755 ${user} users -"
  ];
  systemd.services.suwayomi-server.serviceConfig.Slice = "teto-manga.slice";
  systemd.services.docker-flaresolverr.serviceConfig.Slice = "teto-manga.slice";

  virtualisation.oci-containers.containers.flaresolverr = {
    image = "ghcr.io/flaresolverr/flaresolverr:latest";
    autoStart = true;
    user = "1000:1000";
    ports = [ "9009:8191" ];
    volumes = [ "/var/lib/flaresolver:/config" ];
    environment = {
      TZ = "Europe/London";
    };
    extraOptions = [ "--cgroup-parent=teto-manga.slice" ];
  };

}
