with (import <nixpkgs> {});

let
  gems = bundlerEnv {
    name = "gems-for-some-project";
    gemdir = ./.;
  };
in mkShell { packages = [ gems gems.wrappedRuby ]; }

