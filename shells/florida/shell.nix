{
  pkgs ? import <nixpkgs> { },
}:

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
    EDITOR=nvim

    asdf_plugin_list=$(asdf plugin list)

    echo $asdf_plugin_list | grep -q -w ruby
    if [ $? -eq 1 ]; then
      asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
    fi

    echo $asdf_plugin_list | grep -q -w nodejs
    if [ $? -eq 1 ]; then
      asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    fi;
  '';
}
