{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."github.com" = {
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/github-auth-key";
      identitiesOnly = true;
    };
  };
}
