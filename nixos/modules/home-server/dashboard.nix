{pkgs, ...}:
let 
  jellyfinLogo = pkgs.fetchurl {
    url = "https://static0.xdaimages.com/wordpress/wp-content/uploads/2024/02/jellyfin-logo.png?q=70&fit=contain&w=320&dpr=1";
    sha256 = "sha256-UCYtBXIx+bATpBmZz6hHV2yl6gFyEsHE5lgP3QAB21w=";
  };
  tetoPlush = pkgs.fetchurl {
    url = "https://tetoplush.com/wp-content/uploads/2025/03/Teto-Plush-2-768x768.png";
    sha256 = "sha256-Cb3MVvjm1EJgs/yADvKiy9mh5VAtCFqsP30+LsOyjMU=";
  };
  netbirdLogo = pkgs.fetchurl {
    url = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/netbird.png";
    sha256 = "sha256-qZUS/1mjsq1tjEUZoQoNYDCXwe/4N50caAVEGt3eEcs=";
  };
  suwayomiLogo = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Suwayomi/Suwayomi-Server/master/server/src/main/resources/icon/faviconlogo.png";
    sha256 = "sha256-dnn1yS3hD9ilgrkq2zNZ3XYG+tPBjWlW0DbReEQwATc=";
  };
  sunshineLogo = pkgs.fetchurl {
    url = "https://docs.lizardbyte.dev/projects/sunshine/latest/sunshine.png";
    sha256 = "sha256-kykm+7c7pxwBs7hH0RIJKyCKIPnwZyTxfvzg0h1AtoQ=";
  };
  joplinLogo = pkgs.fetchurl {
    url = "https://github.com/laurent22/joplin/blob/dev/Assets/SquareIcon512.png?raw=true";
    sha256 = "sha256-yFpnoVqMfUQ8zK4M9C5Oepqk0Mwe7EkaWPF9hinRzBw=";
  };
  flashforgeLogo = pkgs.fetchurl {
    url = "https://cdn.brandfetch.io/idqvEdgp9J/w/400/h/400/theme/dark/icon.jpeg?c=1dxbfHSJFAPEGdCLU4o5B";
    sha256 = "sha256-FlS6M/J5X7ElCoxu9n6/V43Hk0v26T6PuWlQ5Av3Zw4=";
  };

  homerConfig = (pkgs.formats.yaml {}).generate "config.yml" {
    title = "TetoCorp Services :3";
    subtitle = "mash'allah";
    logo = "assets/icons/teto-plush.png";
    header = true;
    footer = "<p>did you know that im diamond one in valorant</p>";
    columns = 2;
    connectivityCheck = true;
    theme = "neon";
    defaults = {
      layout = "list";
      colorTheme = "dark";
    };

    services = [
    {
      name = "My shtuff";
      items = [
        {
          name = "Jellyfin";
          url = "https://watch.tetocorp.ie/";
          logo = "assets/icons/jellyfin-logo.png";
        }
        {
          name = "Manga";
          url = "https://manga.tetocorp.ie";
          logo = "assets/icons/suwayomi-logo.png";
        }
        {
          name = "3D Printer";
          url = "https://print.tetocorp.ie";
          logo = "assets/icons/flashforge-logo.png";
        }
      ];
    }
    {
      name = "Admin Shtuff";
      items = [
      {
        name = "Netbird";
        url = "https://vpn.tetocorp.ie";
        logo = "assets/icons/netbird-logo.png";
      }
      {
        name = "Sunshine";
        url = "https://stream.tetocorp.ie";
        logo = "assets/icons/sunshine-logo.png";
      }
      {
        name = "Joplin";
        url = "https://notes.tetocorp.ie";
        logo = "assets/icons/joplin-logo.png";
      }
      ];
    }
    ];
  };
in 
{
  virtualisation.oci-containers = {
    backend = "docker";
    containers.homer = {
      image = "b4bz/homer:v26.4.2";
      autoStart = true;
      user = "1000:1000";
      ports = [ "8888:8080/tcp" ];
      volumes = [ 
        "/home/oisin/.config/homer:/www/assets"
        "${homerConfig}:/www/assets/config.yml:ro"
        "${jellyfinLogo}:/www/assets/icons/jellyfin-logo.png:ro"
        "${tetoPlush}:/www/assets/icons/teto-plush.png:ro"
        "${tetoPlush}:/www/assets/icons/favicon.ico:ro"
        "${netbirdLogo}:/www/assets/icons/netbird-logo.png:ro"
        "${suwayomiLogo}:/www/assets/icons/suwayomi-logo.png:ro"
        "${sunshineLogo}:/www/assets/icons/sunshine-logo.png:ro"
        "${joplinLogo}:/www/assets/icons/joplin-logo.png:ro"
        "${flashforgeLogo}:/www/assets/icons/flashforge-logo.png:ro"
      ];

      # environment = { };

      extraOptions = [
        "--add-host=host.docker.internal:host-gateway"
        "--cgroup-parent=teto-dash.slice"
      ];
    };
  };

  systemd.services.docker-homer.serviceConfig.Slice = "teto-dash.slice";

  systemd.tmpfiles.rules = [
    "d /home/oisin/.config/homer 0755 1000 1000 -"
  ];

}
