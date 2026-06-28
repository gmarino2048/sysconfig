{ pkgs, ... }:
{
  imports = [
    ./shell.nix
    ./editors.nix
    ./ghostty.nix
    ./git.nix
    ./jujutsu.nix
    ./ssh.nix
    ./gpg.nix
    ./direnv.nix
    ./zellij.nix
    ./monitors.nix
    ./files.nix
    ./vscode.nix
  ];

  # username/homeDirectory come from nix-darwin's users.users.guy.
  home.stateVersion = "26.05";

  # Screenshot target dir (system.defaults.screencapture.location).
  home.file."Pictures/screenshots/.keep".text = "";

  home.packages = with pkgs; [
    claude-code
  ];
}
