{ config, lib, pkgs, ... }:

let
  # TODO: import or something idk, make it reusable because this has nothing
  # to do with dagster
  # TODO: DNS leak still despite resolve conf being set
  # TODO: link up loopback
  generateServiceVPN = { namespace, interface, myIPv4, myIPv6, wgConf}:
  {
    description = "WireGuard network namespace ${namespace}@${interface}";
    bindsTo = [ "netns@${namespace}.service" ];
    requires = [ "network-online.target" ];
    # require the namespace to exist first
    after = [ "netns@${namespace}.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = with pkgs; writers.writeBash "wg-up" ''
        set -x
        set -e

        cleanup() {
          ${iproute2}/bin/ip -n ${namespace} route del default dev ${interface}
          ${iproute2}/bin/ip -n ${namespace} -6 route del default dev ${interface}
          ${iproute2}/bin/ip -n ${namespace} link del ${interface}
        }

        trap 'cleanup' ERR

        ${iproute2}/bin/ip link add ${interface} type wireguard
        ${iproute2}/bin/ip link set ${interface} netns ${namespace}
        ${iproute2}/bin/ip -n ${namespace} address add ${myIPv4} dev ${interface}
        ${iproute2}/bin/ip -n ${namespace} -6 address add ${myIPv6} dev ${interface}
        ${iproute2}/bin/ip netns exec ${namespace} \
          ${wireguard-tools}/bin/wg setconf ${interface} ${wgConf}
        ${iproute2}/bin/ip -n ${namespace} link set ${interface} up
        ${iproute2}/bin/ip -n ${namespace} route add default dev ${interface}
        ${iproute2}/bin/ip -n ${namespace} -6 route add default dev ${interface}

        ## Make two interfaces and bridge them
        #${iproute2}/bin/ip link add veth0 type veth peer name veth1 netns ${interface}
        ## Give IP addresses to each
        #${iproute2}/bin/ip -n ${interface} addr add 10.0.0.2/24 dev veth1
        #${iproute2}/bin/ip                 addr add 10.0.0.1/24 dev veth0
        ## Bring them up
        #${iproute2}/bin/ip -n ${interface} link set dev veth1 up
        #${iproute2}/bin/ip                 link set dev veth0 up
      '';
      ExecStop = with pkgs; writers.writeBash "wg-down" ''
        ${iproute2}/bin/ip -n ${namespace} route del default dev ${interface}
        ${iproute2}/bin/ip -n ${namespace} -6 route del default dev ${interface}
        ${iproute2}/bin/ip                 link del veth0
        ${iproute2}/bin/ip -n ${namespace} link del ${interface}
      '';
    };
  };
in
{
  imports = [
    /etc/nixos/modules/tailscale.nix
  ];

  # WireGuard
  networking.wireguard.enable = true;

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  # Template for namespacing a wg service
  systemd.services."netns@" = {
    description = "%I network namespace";
    before = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.iproute2}/bin/ip netns add %I";
      ExecStop =  "${pkgs.iproute2}/bin/ip netns del %I";
    };
  };

  systemd.services.dagster-mullvad = generateServiceVPN {
    namespace = "locationns";
    interface = "interface";
    myIPv4 = "ipv4 given to wireguard device";
    myIPv6 = "ipv6 given to wireguard device";
    wgConf = "/root/02/all/us/${mullvad_id}-stripped.conf";
  };
  environment.etc."netns/locationns/resolv.conf".text = ''
    nameserver 1.1.1.1
    nameserver 8.8.8.8
    nameserver 95.85.95.85
    nameserver 77.88.8.8
    nameserver 62.76.62.76
    nameserver 208.67.222.220
    nameserver 9.9.9.9
    options rotate
  '';

  # Resources
  #  - https://docs.dagster.io/deployment/oss/deployment-options/deploying-dagster-as-a-service
  #  - https://notes.rmhogervorst.nl/post/2022/07/17/systemd-and-python-some-things-i-learned/
  #  - systemd-tmpfiles can write arbitrary things https://discourse.nixos.org/t/how-to-declaratively-create-a-file-symlink-at-a-particular-path/65956
  #  - home.file.(path).(source or text) = (./path or ''raw contents'')
}
