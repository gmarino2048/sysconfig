{ ... }:
{
  # Host identity only; everything else is common (../default.nix). Theme is set in flake.nix.
  networking.hostName = "pegasus";
  networking.computerName = "pegasus";
  networking.localHostName = "pegasus";
}
