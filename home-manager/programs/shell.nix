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

      set -gx PATH $HOME/.local/bin $PATH
    '';
    shellAbbrs = {
      b = "bat";
      l = "ls";
      g = "git";
      gw = "git switch";
      gwd = "git switch develop";
      gw- = "git switch -";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git pull";
      gpp = "git push";
      gd = "git diff";
      gl = "git log";
      gr = "git rebase";
      gm = "git merge";
      gb = "git branch";
      gco = "git checkout";
      gcl = "git clone";
      gcp = "git cherry-pick";
      gt = "git stash";
      gtp = "git stash pop";
      gtl = "git stash list";
      gtd = "git stash drop";
      gtc = "git stash clear";
      gts = "git stash show";
      gfp = "git fetch --prune";
      # florida
      ty = "npm run typecheck";
      co = "npm run commit";
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
