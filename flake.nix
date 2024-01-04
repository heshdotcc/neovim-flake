{
  description = "A flake for LunarVim with custom config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    lunarvimPkg = nixpkgs.legacyPackages.x86_64-linux.lunarvim;
  in {
    packages.x86_64-linux.lunarvim = lunarvimPkg;

    defaultPackage.x86_64-linux = lunarvimPkg;

    # Add a custom app that sets up lunarvim with your configuration
    apps.x86_64-linux.lunar = {
      type = "app";
      program = "${lunarvimPkg}/bin/lvim";
      configure = ''
        mkdir -p ~/.config/lvim
        cp ${self}/configs/config.lua ~/.config/lvim/config.lua
      '';
    };
  };
}

