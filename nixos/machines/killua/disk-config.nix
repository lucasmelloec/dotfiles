{
  disko.devices = {
    disk = {
      one = {
        device = "/dev/disk/by-id/ata-KINGSTON_SA400S37120G_50026B778255270B";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "defaults" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                settings = { allowDiscards = true; };
                content = {
                  type = "luks";
                  name = "cryptroot";
                  settings = { allowDiscards = true; };
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" ];
                    subvolumes = {
                      "@" = {
                        mountpoint = "/";
                        mountOptions =
                          [ "compress=zstd" "noatime" "discard=async" ];
                      };
                      "@cache" = {
                        mountpoint = "/var/cache";
                        mountOptions =
                          [ "compress=zstd" "noatime" "discard=async" ];
                      };
                      "@log" = {
                        mountpoint = "/var/log";
                        mountOptions =
                          [ "compress=zstd" "noatime" "discard=async" ];
                      };
                      "@lib" = {
                        mountpoint = "/var/lib";
                        mountOptions =
                          [ "compress=zstd" "noatime" "discard=async" ];
                      };
                      "@home" = {
                        mountpoint = "/home";
                        mountOptions =
                          [ "compress=zstd" "noatime" "discard=async" ];
                      };
                      "@nix" = {
                        mountpoint = "/nix";
                        mountOptions =
                          [ "compress=zstd" "noatime" "discard=async" ];
                      };
                      "@swap" = {
                        mountpoint = "/.swapvol";
                        mountOptions = [ "noatime" "discard=async" ];
                        swap.swapfile.size = "4G";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
