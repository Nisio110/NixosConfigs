{ pkgs, ... }:
{
  systemd.services.ensure-nixos-efi-entry = {
    description = "Ensure NixOS Lanzaboote-signed systemd-boot EFI entry exists";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];

    unitConfig.ConditionPathExists = "/sys/firmware/efi/efivars";

    path = [
      pkgs.efibootmgr
      pkgs.gnugrep
    ];

    serviceConfig.Type = "oneshot";

    script = ''
      if ! efibootmgr -v \
        | grep -Fq '\EFI\systemd\systemd-bootx64.efi'
      then
        efibootmgr \
          --create \
          --disk /dev/nvme0n1 \
          --part 5 \
          --label "SystemD-Boot" \
          --loader '\EFI\systemd\systemd-bootx64.efi'
      fi
    '';
  };
}
