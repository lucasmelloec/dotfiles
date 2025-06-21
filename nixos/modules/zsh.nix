{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ zsh ];

  programs.zsh.enable = true;
  # For zsh autocompletion to work
  environment.pathsToLink = [ "/share/zsh" ];

}
