{ pkgs, lib, ... }:
let
  helpers = import ../../helpers.nix {
    inherit pkgs;
    inherit lib;
  };
in
{
  programs.alacritty = {
    enable = true;
    package = (helpers.nixGLMesaWrap pkgs.alacritty);
    settings = {
      env.TERM = "xterm-256color";
      shell = {
        program = "tmux";
      };
      font = {
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
        size = 13;
        offset = {
          x = 1;
          y = 0;
        };
        builtin_box_drawing = true;
      };
      window = {
        padding = {
          x = 1;
          y = 0;
        };
        dynamic_padding = true;
        decorations = "full";
      };
    };
  };
}
