{
  pkgs,
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
      set -gx EDITOR nvim
      set -gx VISUAL nvim

      mise activate fish | source
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

    functions = {
      block = {
        description = "Prevent idle (screen sleep/lock)";
        body = ''
          set -l pidfile /run/user/(id -u)/manual-block.pid

          if test -f $pidfile
              set -l pid (cat $pidfile)
              if kill -0 $pid 2>/dev/null
                  echo "Already blocked (PID $pid)"
                  return
              else
                  rm -f $pidfile
              end
          end

          systemd-inhibit --what=idle:sleep \
            --who="manual-block" \
            --why="user requested inhibit" \
            bash -c "sleep infinity" &

          set -l pid $last_pid
          echo $pid > $pidfile
          disown $pid

          echo "Idle inhibited (PID $pid)"
        '';
      };

      unblock = {
        description = "Restore idle";
        body = ''
          set -l pidfile /run/user/(id -u)/manual-block.pid

          if not test -f $pidfile
              echo "Not blocked"
              return
          end

          set -l pid (cat $pidfile)

          if kill $pid 2>/dev/null
              echo "Idle restored"
              rm -f $pidfile
          else
              echo "Failed to kill PID $pid"
          end
        '';
      };

      block-status = {
        description = "Show current inhibitors";
        body = ''
          systemd-inhibit --list
        '';
      };

      unblock-all = {
        description = "Kill manual-block inhibitor and cleanup pidfile";
        body = ''
          pkill -f 'systemd-inhibit.*--who=manual-block' 2>/dev/null
          rm -f /run/user/(id -u)/manual-block.pid 2>/dev/null
          echo "Done"
        '';
      };
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$all\${custom.block_idle}$character";

      custom.block_idle = {
        shell = [
          "bash"
        ];
        when = "test -f /run/user/$(id -u)/manual-block.pid";
        command = ''
          PIDFILE="/run/user/$(id -u)/manual-block.pid"
          if [ -f "$PIDFILE" ]; then
            PID="$(cat "$PIDFILE" 2>/dev/null)"
            if [ -n "$PID" ] && kill -0 "$PID" 2>/dev/null; then
              echo "🌞"
            fi
          fi
        '';
        style = "bold red";
      };
    };
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
