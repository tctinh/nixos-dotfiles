{ ... }: {
  # Auto CPU frequency scaling for laptops
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
        scaling_max_freq = 3000000;
      };
      charger = {
        governor = "performance";
        turbo = "auto";
        scaling_max_freq = 4000000;
      };
    };
  };
}
