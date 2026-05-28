{ pkgs, ... }:

{
  # Bootloader
  boot.loader = {
  # Using GRUB for BIOS systems
#    grub = {
#      enable = true;
#      useOSProber = false;
#      efiSupport = true;
#      device = "nodev";
#    };
    limine = {
      enable = true;
      efiSupport = true;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };

  # Kernel
  boot.kernelModules = [ "nft_queue" "nfnetlink_queue" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.loader.timeout = 0;

  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];

  # Disk
  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-uuid/74762bf2-2f76-47ef-a3f1-adc34549cced";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.initrd.kernelModules = [ "amdgpu" ];
}
