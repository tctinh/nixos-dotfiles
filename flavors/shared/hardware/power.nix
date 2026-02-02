{ ... }: {
  # Disable power-profiles-daemon (conflicts with auto-cpufreq)
  services.power-profiles-daemon.enable = true;

  # Auto CPU frequency scaling for laptops
  # services.power-profiles-daemon.enable = false;
  # services.auto-cpufreq = {
  #   enable = true;
  #   settings = {
  #     battery = {
  #       governor = "powersave";
  #       turbo = "never";
  #     };
  #     charger = {
  #       governor = "performance";
  #       turbo = "auto";
  #     };
  #   };
  # };
}
