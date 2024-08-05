pkgs: {
  hello_nix = pkgs.callPackage ./simple.nix { };
  better-adb-sync = pkgs.callPackage ./better-adb-sync.nix { };
}
