# Netdata — historical per-cgroup charts. The teto-* slices show up
# as named chart families automatically. Proxied at status.tetocorp.ie
# (vhost lives in nginx.nix with the rest).
{
  services.netdata = {
    enable = true;
    config = {
      web."bind to" = "127.0.0.1";
    };
  };

  systemd.services.netdata.serviceConfig.Slice = "teto-infra.slice";
}
