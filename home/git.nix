{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    # GPG signing with the generated "Main Code Signing Key".
    signing = {
      key = "46675F9E4FA08376C97053B2B47B313750A29156";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Guy Marino";
        email = "gmarino2048@gmail.com";
      };
      init.defaultBranch = "main";
      gpg.program = "${pkgs.gnupg}/bin/gpg";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
