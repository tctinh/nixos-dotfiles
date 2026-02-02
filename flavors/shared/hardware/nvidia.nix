{ config, lib, pkgs, ... }: {
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power manageycment. Turns off GPU when not in use.
    powerManagement.finegrained = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # nouveau open source driver). Support is limited to the Turing and later
    # architectures. Full list of supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # DISABLED: Less stable with multi-monitor USB-C setups
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Make sure to use the correct Bus ID values for your system!
      amdgpuBusId = "PCI:06:00:0";
      nvidiaBusId = "PCI:01:00:0";
    };
  };
}
