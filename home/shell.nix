{ ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    enableCompletion = true;

    history = {
      size = 50000;
      save = 50000;
      ignoreDups = true;
      share = true;
    };

    oh-my-zsh = {
      enable = true;
      theme = "lukerandall";
      plugins = [
        "git"
        "direnv"
        "sudo"
        "macos"
        "extract"
        "colored-man-pages"
      ];
    };

    shellAliases = {
      ll = "eza -la --git --icons";
      ls = "eza --icons";
      cat = "bat";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  };

  # Modern shell kit.
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.eza.enable = true;
  programs.bat.enable = true;

  # Homebrew on PATH for all shells.
  home.sessionPath = [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];
}
