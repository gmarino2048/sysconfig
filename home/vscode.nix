{
  pkgs,
  config,
  theme,
  ...
}:
let
  vt = (import ../themes).${theme}.vscode;

  # Single source of settings; reused by stable + insiders (read-only).
  userSettings = {
    "update.mode" = "none";
    "extensions.autoUpdate" = false;
    "extensions.autoCheckUpdates" = false;
    "telemetry.telemetryLevel" = "off";
    "security.workspace.trust.enabled" = false;
    "workbench.enableExperiments" = false;
    "files.autoSave" = "afterDelay";
    "files.autoSaveDelay" = 1000;
    "window.autoDetectColorScheme" = true;
    "workbench.preferredLightColorTheme" = vt.light;
    "workbench.preferredDarkColorTheme" = vt.dark;
    "editor.fontFamily" = "'Fira Code', 'FiraCode Nerd Font', monospace";
    "editor.fontLigatures" = true;
    "rust-analyzer.check.command" = "clippy";
  };

  # nixpkgs builds for the ones with patched binaries; rest from the marketplace overlay.
  extensions =
    (with pkgs.vscode-extensions; [
      vadimcn.vscode-lldb # lldb debugger (patched adapter)
      rust-lang.rust-analyzer
    ])
    ++ (with pkgs.vscode-marketplace; [
      tamasfe.even-better-toml
      yzhang.markdown-all-in-one
      davidanson.vscode-markdownlint
      anthropic.claude-code
      andreilucaci.everforest-pro
      arcticicestudio.nord-visual-studio-code
    ]);
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    # Extensions are nix-managed and immutable; VSCode must not self-update.
    mutableExtensionsDir = false;
    profiles.default = {
      inherit userSettings extensions;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
    };
  };
}
