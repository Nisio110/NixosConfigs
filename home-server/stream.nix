# SITS OUTSIDE OF NGINX CONFIGURATION BECAUSE 
# MOONLIGHT IS MADE BY BUMS
# probably fine


{pkgs, homeDir, user, ...}:
let 
  dataDir = "/var/lib/sunshine";
  configDir = "${homeDir}/.config/sunshine";
  startDisplay = pkgs.writeShellScript "sunshine-display-start" ''
    ${pkgs.kdePackages.krfb}/bin/krfb-virtualmonitor \
      --resolution "''${SUNSHINE_CLIENT_WIDTH:-1920}x''${SUNSHINE_CLIENT_HEIGHT:-1080}" \
      --name sunshine \
      --password "$(${pkgs.openssl}/bin/openssl rand -hex 16)" \
      --port 5905 &

    echo $! > /tmp/sunshine-display.pid
    sleep 2
  '';

  stopDisplay = pkgs.writeShellScript "sunshine-display-stop" ''
    kill "$(cat /tmp/sunshine-display.pid)"
    rm -f /tmp/sunshine-display.pid
  '';
in


{
  systemd.tmpfiles.rules = [
    "d ${dataDir} 0755 ${user} users -"
    "d ${configDir} 0755 ${user} users -"

  ];
  environment.systemPackages = with pkgs; [ 
    linuxPackages.evdi # virt display kmod
    kdePackages.krfb # kde headless display cli
    kdePackages.kscreen
    coreutils # provides /bin/sleep
  ];

  services.sunshine = {
    enable = true;
    package = pkgs.sunshine;
    autoStart = true;
    capSysAdmin = false;
    settings = {
      # == general ==
      locale = "en_GB";
      sunshine_name = "Tetocorp HQ";
      min_log_level = "info";
      system_tray = "enabled";

      output_name = "virtual-sunshine";

      global_prep_cmd = builtins.toJSON [
        {
          do = "${startDisplay}";
          undo = "${stopDisplay}";
        }
      ];

      # == audio/video ==
      audio_sink = "alsa_output.pci-0000_08_00.4.analog-stereo";
      # output_name = ""; # fill in after first launch
      max_bitrate = "0";
      minimum_fps_target = "60";

      # == network ==
      bind_address = "192.168.0.19";
      address_family = "ipv4";
      port = 5050;
      origin_web_ui_allowed = "wan";
      csrf_allowed_origins = "https://stream.tetocorp.ie";
      #wan_encryption_mode = "1";
      #lan_envryption_mode = "1";
      ping_timeout = "30000";
      #cert = "/var/lib/ssl/tetocorp.crt";
      #pkey = "/var/lib/ssl/tetocorp.key";

      # == config files ==
      # only set if you have a file you want to drop in here
      #file_apps = "${dataDir}/apps.json";
      #credentials_file = "${dataDir}/sunshine_state.json";
      #log_path = "${dataDir}/sunshine.log";
      #file_state = "${configDir}/sunshine_state.json";

      # == nvidia ==
      encoder = "nvenc";
      hevc_mode = "0";
      av1_mode = "1";
      capture = "kwin";
    };
    
  };

}
