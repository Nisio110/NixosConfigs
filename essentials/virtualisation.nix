{pkgs, ...}: 
{
  environment.systemPackages = with pkgs; [
    qemu quickemu
  ];

  boot = {
    kernelModules = [ "ip_tables" "ip_table_nat" ];
  };

  programs = {
    virt-manager.enable = true;
  };

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };

  virtualisation = {
    virtualbox.host.enable = true;
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };
}
