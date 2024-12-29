{
  inputs,
  pkgs,
  outputs,
  ...
}:
{
  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
  };

  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins; [
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
    ];
    interactiveShellInit = ''
      bind --erase \cr
      bind --preset --erase \cr
      bind -M insert --erase \cr
      bind \cr _fzf_search_history
      bind -M insert \cr _fzf_search_history

      set -x LS_COLORS (vivid generate catppuccin-macchiato)
    '';
    shellAbbrs = {
      b = "bat";
      l = "ls";
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gd = "git diff";
      gl = "git log";
      gr = "git rebase";
      gm = "git merge";
      gb = "git branch";
      gco = "git checkout";
      gcl = "git clone";
      gcp = "git cherry-pick";
      gsh = "git stash";
      gshp = "git stash pop";
      gshl = "git stash list";
      gshd = "git stash drop";
      gshc = "git stash clear";
      gshs = "git stash show";
    };
  };

  programs.starship = {
    enable = true;
    settings = { };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.eza = {
    enable = true;
  };
}
