{
  pkgs,
  inputs,
  theme,
  ...
}:
{
  imports = [ ./brew.nix ];

  # Determinate owns Nix itself; nix-darwin must not manage it.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;

  # Needed for user-scoped options (homebrew, system defaults).
  system.primaryUser = "guy";
  users.users.guy = {
    name = "guy";
    home = "/Users/guy";
  };

  # Weekly GC, deleting anything older than 30 days (nix.gc is unavailable under Determinate).
  launchd.daemons.nix-gc.serviceConfig = {
    ProgramArguments = [
      "/nix/var/nix/profiles/default/bin/nix-collect-garbage"
      "--delete-older-than"
      "30d"
    ];
    StartCalendarInterval = [
      {
        Weekday = 0;
        Hour = 3;
        Minute = 0;
      }
    ];
    StandardOutPath = "/var/log/nix-gc.log";
    StandardErrorPath = "/var/log/nix-gc.log";
  };

  # Fira Code (ligatures) + Nerd Font glyphs, system-wide.
  fonts.packages = [
    pkgs.fira-code
    pkgs.nerd-fonts.fira-code
  ];

  # Fallback system build/debug toolchain.
  environment.systemPackages = [
    pkgs.llvm
    pkgs.lldb
  ];

  system.defaults = {
    NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true; # time-based dark mode
    NSGlobalDomain.AppleShowAllExtensions = true;
    finder.AppleShowAllExtensions = true;
    finder.AppleShowAllFiles = true; # show hidden files
    finder.FXPreferredViewStyle = "clmv"; # column view
    screencapture.location = "/Users/guy/Pictures/screenshots";
  };

  # Touch ID for sudo.
  security.pam.services.sudo_local.touchIdAuth = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs theme; };
    users.guy = import ../home;
  };

  system.stateVersion = 6;
}
