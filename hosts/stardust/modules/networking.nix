{ pkgs, ... }:

{
  # Network
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];
  networking.enableIPv6 = false;

  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ 1111 ];
    allowedUDPPorts = [ 1111 ];
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    settings = {
      Resolve = {
        DNSOverTLS = "yes";
      };
    };
  };

  # Configure zapret if desired
  services.zapret = {
    enable = true;
    configureFirewall = false;
    params = [
      #"--dpi-desync=disorder2"
      #"--dpi-desync-split-pos=midsld"
      #"--dpi-desync-ttl=3"
      #"--dpi-desync-fool-dns"
      #"--dpi-desync-fool-ts"
      #"--dpi-desync-split-pos=3"
      #"--dpi-desync-any-protocol=yes"
      #"--dpi-desync-repeats=6"

      "--dpi-desync=fake,multisplit"
      "--dpi-desync-ttl=3"
      "--orig-ttl=1"
      "--orig-mod-start=s1"
      "--orig-mod-cutoff=d1"
      "--dpi-desync-split-pos=1"
      "--filter-tcp=80" "--dpi-desync=fake,fakedsplit" "--dpi-desync-fooling=md5sig"
      "--new"
      "--filter-tcp=443" "--dpi-desync=fake,multidisorder" "--dpi-desync-fooling=badseq"
    ];
  };

  networking.nftables.enable = true;
  networking.nftables.ruleset = ''
    table inet zapret {
      chain preamble {
        type filter hook output priority mangle; policy accept;
        # Перехватываем HTTP, HTTPS и QUIC (UDP 443)
        tcp dport { 80, 443 } counter queue num 0 bypass
        udp dport 443 counter queue num 0 bypass
      }
    }
  '';

  # Cloudflare warp
  #services.cloudflare-warp.enable = true;
  #systemd.packages = [ pkgs.cloudflare-warp ];
  #systemd.targets.multi-user.wants = [ "warp-svc.service" ];
}
