{ config, lib, pkgs, modulesPath, ... }:

# TODO(jakehamilton): Phase most of this out when nixos-hardware
# is updated with Framework support.
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelModules = [ "kvm-intel" ];

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "kvm-intel" "wl" ];
    };

    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" "umask=0077" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/home";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/swap"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.opengl.enable = true;

  hardware.bluetooth.enable = true;

  # Enable DHCP on the wireless link
  networking = {
    # Derived from `head -c 8 /etc/machine-id`
    hostId = "1cad7839";

    useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp0s20f3.useDHCP = true;
  };
}
