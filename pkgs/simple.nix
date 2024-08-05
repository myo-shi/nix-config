{ stdenv }:
stdenv.mkDerivation {
  name = "hello-nix";

  src = ./.;

  # Use $CC as it allows for stdenv to reference the correct C compiler
  buildPhase = ''
    $CC simple.c -o hello_nix
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp hello_nix  $out/bin/hello_nix
  '';
}
