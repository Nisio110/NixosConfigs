{
  services = {
    seerr.enable = true;
    radarr.enable = true;
    sonarr.enable = true;
    prowlarr.enable = true;
    qbittorrent.enable = true;
};
  services = {
    seerr = {
      port = 5055;
      # intended to mismatch with other arr config schemas
    };
    radarr = {
      settings = { server.port = 6767; };
    };
    sonarr = {
      settings = { server.port = 5656; };
    };
    prowlarr = {
      settings = { server.port = 4545; };
    };
    qbittorrent = {
      webuiPort = 3434;
    };
  };

  systemd.services.seerr.serviceConfig.Slice = "teto-media.slice";
  systemd.services.radarr.serviceConfig.Slice = "teto-media.slice";
  systemd.services.sonarr.serviceConfig.Slice = "teto-media.slice";
  systemd.services.prowlarr.serviceConfig.Slice = "teto-media.slice";
}
