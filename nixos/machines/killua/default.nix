{ inputs, ... }:

{
  imports = with inputs; [ ../../roles/server.nix ];

  # Options
  custom.audio.enable = true;
  custom.defaultShell = "zsh";
  custom.homeManager.enable = true;
  custom.gpu = "nvidia";
  custom.nvidia.open = false;
  custom.tpm.enable = true;

  networking.hostName = "killua";
}
