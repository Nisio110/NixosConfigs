{pkgs,...}: 
{
  environment.systemPackages = with pkgs; [
    qemu 
    quickemu
    linuxPackages.virtualbox
    virtualbox
  ];

  virtualisation.libvirtd.enable = true;

  programs.virt-manager.enable = true;

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  virtualisation.libvirtd = {
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
}
