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
      serverConfig = {
        LegalNotice.Accepted = true;
        Preferences = {
          General.Locale = "en";
          WebUI = {
            Username = "oisin";
            Password_PBKDF2 = "y40DZYeMOtFc7AUYFjJ1VA==:1+yXpCOrGLjzFuzZJ7NgoUQEoszQyW8s59n8OBbWyx1yP+q5620wKI6yMFhvYABmd1+UJu6Dla0rWhFtpjE18g==";
          };
        };
      };

    };
  };

  systemd.services.seerr.serviceConfig.Slice = "teto-media.slice";
  systemd.services.radarr.serviceConfig.Slice = "teto-media.slice";
  systemd.services.sonarr.serviceConfig.Slice = "teto-media.slice";
  systemd.services.prowlarr.serviceConfig.Slice = "teto-media.slice";
  systemd.services.qbittorrent.serviceConfig.Slice = "teto-media.slice";
}
