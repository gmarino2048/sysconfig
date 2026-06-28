{ pkgs, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Guy Marino";
        email = "gmarino2048@gmail.com";
      };

      # Sign my own commits with the GPG key.
      signing = {
        behavior = "own";
        backend = "gpg";
        key = "46675F9E4FA08376C97053B2B47B313750A29156";
        backends.gpg.program = "${pkgs.gnupg}/bin/gpg";
      };

      git = {
        # Auto-create local bookmarks tracking the remote (closest to auto-tracking main/master/guy/*/gmarino/*).
        auto-local-bookmark = true;
      };
    };
  };
}
