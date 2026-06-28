{ ... }:
{
  # Manage gnupg; the signing key itself lives in ~/.gnupg (outside this repo).
  programs.gpg.enable = true;
}
