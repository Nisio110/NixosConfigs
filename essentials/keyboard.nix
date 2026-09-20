{
  services.xserver = {
    enable = true;
    xkb = {
      layout = "gb";
      variant = "mac";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
}
