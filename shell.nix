let
  nixpkgs =
    import (builtins.fetchTarball {
      url = https://github.com/NixOS/nixpkgs/archive/ee4a6e0f566fe5ec79968c57a9c2c3c25f2cf41d.tar.gz;
    }) { };

  gems =
    nixpkgs.bundlerEnv {
      name = "rails-gems";
      inherit (nixpkgs) ruby;
      gemfile = ./Gemfile;
      lockfile = ./Gemfile.lock;
      gemset = ./gemset.nix;
    };
in
  nixpkgs.mkShell {
    buildInputs = [
      nixpkgs.ruby_3_2
      gems
      gems.wrappedRuby
      nixpkgs.bundler
      nixpkgs.bundix
      nixpkgs.nodejs
      nixpkgs.yarn
      nixpkgs.postgresql
    ];
  }
