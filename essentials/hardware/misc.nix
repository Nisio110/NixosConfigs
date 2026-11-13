{ pkgs, ... }:
{
  # === Disable Sleep
  # Sleep is broken on my motherboard
  systemd.sleep.settings.Sleep = {
    AllowSuspend = "no";
    AllowHibernation = "no";
    AllowSuspendThenHibernate = "no";
    AllowHybridSleep = "no";
  };
  # ---

}
