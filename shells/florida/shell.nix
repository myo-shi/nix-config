{ pkgs ? import <nixpkgs> {}}:

pkgs.mkShell {
  packages = with pkgs; [ 
    asdf-vm
    libffi 
    libyaml 
    openssl 
    zlib
  ];

  shellHook = ''
    . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"

    export EDITOR=nvim
  '';
}
