{ lib, pkgs, ... }: {
  # Vanilla stable kernel (non-rc) for stability
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages;

  boot.plymouth.enable = true;
  catppuccin.plymouth.enable = true;
  catppuccin.plymouth.flavor = "mocha";

  boot.kernelParams = [
    "preempt=voluntary"
    "nowatchdog"
    "psi=1"
    "quiet"
    "splash"
    # Security hardening (balanced - keeps mitigations enabled)
    "randomize_kstack_offset=on"
    "slab_nomerge"
    "page_poison=1"
    "page_alloc.shuffle=1"
    "init_on_alloc=1"
    "init_on_free=1"
    "vsyscall=none"
    "lockdown=confidentiality"
    "module.sig_enforce=1"
    "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
  ];

  boot.kernel.sysctl = {
    # Memory optimization
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;

    # Security hardening
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    "kernel.sysrq" = 0;
    "kernel.ftrace_enabled" = false;
    "kernel.core_uses_pid" = 1;
    "kernel.randomize_va_space" = 2;
    "kernel.nmi_watchdog" = 0;
    "net.core.bpf_jit_harden" = 2;
    "fs.protected_fifos" = 2;
    "fs.protected_regular" = 2;
    "fs.suid_dumpable" = 0;
    "dev.tty.ldisc_autoload" = 0;
    "vm.unprivileged_userfaultfd" = 0;
    "vm.mmap_rnd_bits" = 32;
    "vm.mmap_rnd_compat_bits" = 16;

    # TCP/Network optimization
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_fastopen" = 3;
    "net.core.rmem_max" = 134217728;
    "net.core.wmem_max" = 134217728;
    "net.core.netdev_budget" = 600;
    "net.core.netdev_max_backlog" = 16384;
    "net.ipv4.tcp_no_metrics_save" = 1;
    "net.ipv4.tcp_moderate_rcvbuf" = 1;
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
  security.forcePageTableIsolation = true;
  security.protectKernelImage = true;

  # Disable core dumps
  systemd.coredump.extraConfig = ''
    Storage=none
    ProcessSizeMax=0
  '';
}
