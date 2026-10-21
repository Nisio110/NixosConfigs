{pkgs,...}: 
{
  environment.systemPackages = with pkgs; [
    qemu 
    quickemu
  ];

  virtualisation.libvirtd.enable = true;
  virtualisation.virtualbox.host.enable = true;


  programs.virt-manager.enable = true;

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  virtualisation.libvirtd = {
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
}
