{ ... }: {
  # CachyOS-inspired performance tweaks (manual implementation since cachy-tweaks-flake is incompatible)

  boot.plymouth.enable = true;
  catppuccin.plymouth.enable = true;
  catppuccin.plymouth.flavor = "mocha";

  boot.kernelParams = [
    "preempt=voluntary"
    "nowatchdog"
    "psi=1"
    "quiet"
    "splash"
    "randomize_kstack_offset=on"
    "slab_nomerge"
    "page_poison=1"
  ];

  boot.kernel.sysctl = {
    # Memory
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 10;

    # Security
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    "net.core.bpf_jit_harden" = 2;

    # TCP optimization
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_fastopen" = 3;
    "net.core.rmem_max" = 134217728;
    "net.core.wmem_max" = 134217728;
  };

  boot.blacklistedKernelModules = [
    # Protocols
    "appletalk"
    "ipx"
    "ax25"
    "netrom"
    "x25"
    "rose"
    "decnet"
    "econet"
    "rds"
    "tipc"

    # Filesystems
    "cramfs"
    "freevxfs"
    "jffs2"
    "hfs"
    "hfsplus"

    # Buses
    "firewire-core"
    "thunderbolt"
  ];

  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
  };

  security.tpm2.enable = true;
  security.polkit.enable = true;
  security.rtkit.enable = true;
}
