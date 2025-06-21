{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.buildFHSEnv {
      name = "nvim";
      targetPkgs = pkgs:
        with pkgs; [
          neovim
          nodejs_22
          lua-language-server
          stylua
        ];
      runScript = "nvim";
    })
  ];

  environment.variables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
  };

}
