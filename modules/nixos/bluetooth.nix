{ ... }: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    # NixOS wiki recommended defaults (24.11+)
    settings = {
      General = {
        # Despite the name, this has been stable for a long time upstream.
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
}
