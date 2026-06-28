{ ... }:
{
  homebrew = {
    enable = true;

    # "zap" uninstalls anything not declared here.
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    casks = [
      "google-chrome"
      "firefox"
      "ghostty"
    ];
  };
}
