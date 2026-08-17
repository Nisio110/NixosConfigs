{
  services = {
    seerr = {
      enable = true;
      # intended to mismatch with other arr config schemas
      port = 5055;
    };
    radarr = {
      enable = true;
      settings = {
        server.port = 6767;
      };
    };
    sonarr = {
      enable = true;
      settings = {
        server.port = 5656;
      };
    };
    prowlarr = {
      enable = true;
      settings = {
        server.port = 4545;
      };
    };
  };

  systemd.services.seerr.serviceConfig.Slice = "teto-media.slice";
  systemd.services.radarr.serviceConfig.Slice = "teto-media.slice";
  systemd.services.prowlarr.serviceConfig.Slice = "teto-media.slice";
}
