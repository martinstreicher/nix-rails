let
  nixpkgs =
    import (builtins.fetchTarball {
      url = https://github.com/NixOS/nixpkgs/archive/ee4a6e0f566fe5ec79968c57a9c2c3c25f2cf41d.tar.gz;
    }) { };

  targetRuby = nixpkgs.ruby_3_2;

  myBundler = nixpkgs.bundler.override {
    ruby = targetRuby;
  };

  gems =
    nixpkgs.bundlerEnv {
      inherit (nixpkgs) ruby_3_2;

      name     = "rails-gems";
      bundler  = myBundler;
      gemfile  = ./Gemfile;
      lockfile = ./Gemfile.lock;
      gemset   = ./gemset.nix;
    };

in
  nixpkgs.mkShell {
    buildInputs = [
      targetRuby
      gems
      gems.wrappedRuby
      nixpkgs.bundler
      nixpkgs.bundix
      nixpkgs.nodejs
      nixpkgs.yarn
      nixpkgs.postgresql
    ];
  }
