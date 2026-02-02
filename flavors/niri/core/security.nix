{ ... }:
{
  security = {
    rtkit.enable = true;
    sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };
  };

  # Basic hardening defaults
  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    "net.core.bpf_jit_enable" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
  };
}
