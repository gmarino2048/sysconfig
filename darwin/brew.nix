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
      "visual-studio-code@insiders" # stable VSCode comes from nix; Insiders self-updates here
    ];
  };
}
