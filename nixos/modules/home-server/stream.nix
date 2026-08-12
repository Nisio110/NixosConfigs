# SITS OUTSIDE OF NGINX CONFIGURATION BECAUSE 
# MOONLIGHT IS MADE BY BUMS


{pkgs, homeDir, user, ...}:
let 
  dataDir = "/var/lib/sunshine";
  configDir = "${homeDir}/.config/sunshine";
in
{
  systemd.tmpfiles.rules = [
    "d ${dataDir} 0755 ${user} users -"
    "d ${configDir} 0755 ${user} users -"

  ];
  environment.systemPackages = with pkgs; [ 
    linuxPackages.evdi # virt display kmod
    kdePackages.krfb # kde headless display cli
    coreutils # provides /bin/sleep
  ];

  services.sunshine = {
    enable = true;
    package = pkgs.sunshine;
    autoStart = true;
    capSysAdmin = true;
    settings = {
      # == general ==
      locale = "en_GB";
      sunshine_name = "Tetocorp HQ";
      min_log_level = "warning";
      system_tray = "enabled";
      global_prep_cmd =
        ''
        [
          {
            "do":"${homeDir}/Projects/Scripts/laptop-mode.sh",
            "undo":"${homeDir}/Projects/Scripts/desktop-mode.sh"
          }
        ]
        '';

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
      csrf_allowed_origins = "https://stream.tetocorp.ie, http://stream.tetocorp.ie, http://192.168.0.19";
      wan_encryption_mode = "0";
      ping_timeout = "30000";

      # == config files ==
      # only set if you have a file you want to drop in here
      #file_apps = "${dataDir}/apps.json";
      #credentials_file = "${dataDir}/sunshine_state.json";
      #log_path = "${dataDir}/sunshine.log";
      #file_state = "${configDir}/sunshine_state.json";

      # == nvidia ==
      hevc_mode = "2";
      capture = "kms";
      encoder = "hevc_vulkan";
    };
    
  };

}
