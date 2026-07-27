 { pkgs, ... }:
 {
   environment.systemPackages = with pkgs; [ onedriver ];

   systemd.user.services.onedriver = {
     description = "onedriver OneDrive mount";
     after = [ "network-online.target" ];
     wants = [ "network-online.target" ];
     wantedBy = [ "default.target" ];

     serviceConfig = {
       Environment = [
         "PATH=/run/wrappers/bin:/run/current-system/sw/bin" 
         "GDK_BACKEND=x11"
         "WEBKIT_DISABLE_DMABUF_RENDERER=1"
       ];

       ExecStartPre = [ "${pkgs.coreutils}/bin/mkdir -p %h/OneDrive" ];
       ExecStart    = "${pkgs.onedriver}/bin/onedriver %h/OneDrive";
       ExecStopPost = "-/run/wrappers/bin/fusermount3 -uz %h/OneDrive";

       Restart = "on-abnormal";
       RestartSec = 3;
       RestartForceExitStatus = 2;
     };
   };
 }

