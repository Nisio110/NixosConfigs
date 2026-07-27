{

  services.nginx = {
    enable = true;

    recommendedProxySettings = true;
    recommendedOptimisation  = true;
    recommendedGzipSettings  = true;

    virtualHosts = {
      
      "tetocorp.ie" = {
        locations."/".proxyPass = "http://127.0.0.1:8888";
        default = true;
      };
      
      "watch.tetocorp.ie".locations."/" = {
        proxyPass       = "http://127.0.0.1:8096";
        proxyWebsockets = true;
      };
      
      "vpn.tetocorp.ie".locations."/" = {
        return = "301 https://app.netbird.io$request_uri";
      };

      "notes.tetocorp.ie".locations."/" = {
        proxyPass = "http://127.0.0.1:7878";
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };

      "manga.tetocorp.ie".locations."/" = {
        proxyPass = "http://127.0.0.1:9090";
        proxyWebsockets = true;
      };

      "cloudflare-bypass.tetocorp.ie".locations."/" = {
        proxyPass = "http://127.0.0.1:9009";
      };

      "stream.tetocorp.ie".locations."/" = {
        proxyPass = "https://192.168.0.19:5051";
        proxyWebsockets = true;
        extraConfig = "proxy_set_header Origin $sunshine_ui_origin;";
      };

    };
    appendHttpConfig =
    ''
      # Increase the maximum size of the hash table
      proxy_headers_hash_max_size 1024;

      # Increase the bucket size of the hash table
      proxy_headers_hash_bucket_size 128;

      map $http_origin $sunshine_ui_origin {
        default                            $http_origin;
        "http://stream.tetocorp.ie"  "https://stream.tetocorp.ie";
      }
    '';
  };

  services.nginx.streamConfig = ''
    # DNS needs both UDP (standard queries) and TCP (large/truncated responses).
    server {
      listen 1053 udp;
      proxy_pass 127.0.0.1:53;
      proxy_responses 1;
      proxy_timeout 1s;
    }
    server {
      listen 1053;
      proxy_pass 127.0.0.1:53;
    }
  '';
}
