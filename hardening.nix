{ config, pkgs, ... }:

{
  boot.blacklistedKernelModules = [
    # Unused protocols
    ## DCCP
    "dccp"
    "dccp_ipv4"
    "xt_dccp"

    ## SCTP
    "sctp"
    "sctp_diag"
    "xt_sctp"

    ## RDS
    "rds"

    ## TIPC
    "tipc"
    "tipc_diag"
  ];

  boot.kernel.sysctl = {
    "dev.tty.ldisc_autoload" = 0;
    "fs.protected_fifos" = 2;
    "fs.suid_dumpable" = 0;
    # Kernel pointers printed will be zero'd out
    "kernel.kptr_restrict" = 2;
    # Unneeded
    "kernel.sysrq" = 0;
    # Disable use of eBPF by unprivleged users
    "kernel.unprivileged_bpf_disabled" = 1;
    # Harden BPF JIT
    "net.core.bpf_jit_harden" = 2;
    # Do not accept ICMP redirects, preventing MITM attacks
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    # Log martians
    "net.ipv4.conf.all.log_martians" = 1;
    "net.ipv4.conf.default.log_martians" = 1;
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    # https://www.tenable.com/audits/items/CIS_Rocky_Linux_8_v1.0.0_L1_Server.audit:42c6410b61aac791e839c0e40ff8277c
    "net.ipv4.conf.all.rp_filter" = 1;
    # https://www.tenable.com/audits/items/CIS_Debian_Linux_7_v1.0.0_L1.audit:c120d5af44f5fbed18c683f4c56f12e2
    "net.ipv4.conf.all.send_redirects" = 0;
    # https://www.tenable.com/audits/items/CIS_Red_Hat_EL7_STIG_v2.0.0_L1_Server.audit:49b06dfc4a80bbf7356c47b846ac51e5
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
  };
}
