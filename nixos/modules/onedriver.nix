{ pkgs, ... }:
let
  # nixpkgs' onedriver ships no GStreamer plugins, so the embedded WebKit auth
  # window dies with "GStreamer element appsink not found". Feed the plugins to
  # wrapGAppsHook3 (their setup hooks populate GST_PLUGIN_SYSTEM_PATH_1_0) and
  # pin the WebKit DMA-BUF workaround for Wayland (Error 71 protocol error).
  onedriver = pkgs.onedriver.overrideAttrs (old: {
    buildInputs =
      old.buildInputs
      ++ (with pkgs.gst_all_1; [
        gstreamer
        gst-plugins-base
        gst-plugins-good
      ]);
    preFixup =
      (old.preFixup or "")
      + ''
        gappsWrapperArgs+=(--set WEBKIT_DISABLE_DMABUF_RENDERER 1)
      '';
  });
in
{
  environment.systemPackages = [ onedriver ];

   systemd.user.services.onedriver = {
     description = "onedriver OneDrive mount";
     after = [ "network-online.target" ];
     wants = [ "network-online.target" ];
     wantedBy = [ "default.target" ];

     serviceConfig = {
      Environment = [
        "PATH=/run/wrappers/bin:/run/current-system/sw/bin"
      ];

       ExecStartPre = [ "${pkgs.coreutils}/bin/mkdir -p %h/OneDrive" ];
      ExecStart    = "${onedriver}/bin/onedriver %h/OneDrive";
       ExecStopPost = "-/run/wrappers/bin/fusermount3 -uz %h/OneDrive";

       Restart = "on-abnormal";
       RestartSec = 3;
       RestartForceExitStatus = 2;
     };
   };
 }

