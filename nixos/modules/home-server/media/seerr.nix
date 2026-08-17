{
  services.seerr = {
    enable = true;
    port = 5055;
    # configDir = /var/lib/private/seerr;
  };
  systemd.services.seerr.serviceConfig.Slice = "teto-media.slice";
}
