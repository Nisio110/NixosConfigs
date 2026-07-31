{
  services.unbound = {
    enable = true;
    resolveLocalQueries = false;

    settings = {
      server = {
        ip-freebind  = true; 
        interface    = [ "127.0.0.1" "192.168.0.19"];
        local-zone = [ ''"ie.tetocorp." static'' ];

        access-control = [
          "127.0.0.0/8 allow"
          "192.168.0.0/24 allow"
          "100.90.0.0/16 allow"
        ];

        local-data  = [
          ''"tetocorp.ie.         IN A 192.168.0.19"''
          ''"watch.tetocorp.ie.   IN A 192.168.0.19"''
          ''"vpn.tetocorp.ie.     IN A 192.168.0.19"''
          ''"notes.tetocorp.ie.   IN A 192.168.0.19"''
          ''"manga.tetocorp.ie.   IN A 192.168.0.19"''
          ''"cloudflare-bypass.tetocorp.ie IN A 192.168.0.19"''
          ''"stream.tetocorp.ie.  IN A 192.168.0.19"''
        ];
      };

      forward-zone = [{
        name = ".";
        forward-tls-upstream = true;
        forward-addr = [
          "1.1.1.1@853#cloudflare-dns.com"
          "1.0.0.1@853#cloudflare-dns.com"
        ];
      }];
    };
  };
}
