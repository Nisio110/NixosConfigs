{pkgs, ...}: 
{
  environment.systemPackages = with pkgs; [
    qemu quickemu
  ];

  boot = {
    #initrd.kernelModules = [
    #  "ip_tables"
    #];
    kernelModules = [
      "ip_tables"
    ];
  };

  programs = {
    virt-manager.enable = true;
  };

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  virtualisation.virtualbox.host.enable = true;
}
