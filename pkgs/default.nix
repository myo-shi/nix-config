pkgs: {
  hello_nix = pkgs.callPackage ./example/simple.nix { };
  better-adb-sync = pkgs.callPackage ./better-adb-sync.nix { };
}
