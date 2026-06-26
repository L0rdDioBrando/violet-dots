{ pkgs, ... }:

{
  # Network
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  networking.nameservers = [
    "8.8.8.8"
    "8.8.4.4"
  ];

  networking.firewall = {
    enable = false;
    allowedTCPPorts = [
      1111
      4533
    ];
    allowedUDPPorts = [
      1111
      4533
    ];
  };

  /*
    services.zapret = {
      enable = true;
      configureFirewall = false;
      params = [
        "--dpi-desync=fake,multisplit"
        "--dpi-desync-ttl=3"
        "--orig-ttl=1"
        "--orig-mod-start=s1"
        "--orig-mod-cutoff=d1"
        "--dpi-desync-split-pos=1"
        "--filter-tcp=80"
        "--dpi-desync=fake,fakedsplit"
        "--dpi-desync-fooling=md5sig"
        "--new"
        "--filter-tcp=443"
        "--dpi-desync=fake,multidisorder"
        "--dpi-desync-fooling=badseq"
      ];
    };
  */

  networking.nftables.enable = true;

  # Cloudflare warp
  services.cloudflare-warp.enable = true;
  systemd.packages = [ pkgs.cloudflare-warp ];
  systemd.targets.multi-user.wants = [ "warp-svc.service" ];
}
