{pkgs,...}: 
{
  environment.systemPackages = with pkgs; [
    qemu 
    quickemu
    linuxKernel.packages.linux_7_2.virtualbox
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
