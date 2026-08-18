{
  services.unbound = {
    enable = true;
    resolveLocalQueries = true;

    settings = {
      server = {
        ip-freebind  = true; 
        interface    = [ "127.0.0.1" "192.168.0.19" ];
        local-zone = [ ''"tetocorp.ie." redirect'' ];

        access-control = [
          "127.0.0.0/8 allow"
          "192.168.0.0/24 allow"
          "100.90.0.0/16 allow"
        ];

        local-data  = [
          ''"tetocorp.ie.         IN A 192.168.0.19"''
        ];
      };

      forward-zone = [{
        name = ".";
        forward-tls-upstream = false;
        forward-addr = [
          "1.1.1.1@853#cloudflare-dns.com"
          "1.0.0.1@853#cloudflare-dns.com"
          "8.8.8.8"
          "1.1.1.1"
        ];
      }];
    };
  };

  systemd.services.unbound.serviceConfig.Slice = "teto-infra.slice";
}
