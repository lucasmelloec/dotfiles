{ lib, config, ... }:

let
  inherit (lib.modules) mkIf mkMerge;
  usesNvidia = builtins.elem config.custom.gpu [ "nvidia" "nv-amd" ];
  commonNvidiaConfig = {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = mkIf (config.custom.gpu != "nvidia") true;
      open = config.custom.nvidia.open;
      nvidiaSettings = true;
      prime = mkIf (config.custom.gpu != "nvidia") {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        nvidiaBusId = config.custom.nvidia.busId;
        amdgpuBusId = config.custom.amd.busId;
      };
    };
  };
in {
  config = mkMerge [
    (mkIf (usesNvidia && config.custom.nvidia.specialisation) {
      # Disable nvidia
      services.udev.extraRules = mkIf (config.specialisation != { })
        (lib.mkDefault ''
          # Remove NVIDIA USB xHCI Host Controller devices, if present
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"

          # Remove NVIDIA USB Type-C UCSI devices, if present
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"

          # Remove NVIDIA Audio devices, if present
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"

          # Remove NVIDIA VGA/3D controller devices
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
        '');
      boot = mkIf (config.specialisation != { }) {
        extraModprobeConfig = ''
          blacklist nouveau
          options nouveau modeset=0
        '';
        blacklistedKernelModules =
          [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
      };
      specialisation.nvidia-enabled.configuration = commonNvidiaConfig;
    })

    (mkIf (usesNvidia && !config.custom.nvidia.specialisation)
      commonNvidiaConfig)
  ];
}
