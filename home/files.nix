{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    settings.mgr = {
      show_hidden = true;
      sort_dir_first = true;
    };
  };

  # Ergonomic disk-usage tools.
  home.packages = [ pkgs.dust pkgs.duf ];
}
