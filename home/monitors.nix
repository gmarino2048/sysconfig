{ pkgs, theme, ... }:
let
  t = (import ../themes).${theme};
  p = t.palette;
in
{
  home.packages = [ pkgs.fastfetch ];

  programs.htop.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      color_theme = t.btop;
      theme_background = false; # transparent
      vim_keys = true;
    };
  };

  # btop theme generated from the shared palette.
  xdg.configFile."btop/themes/${t.btop}.theme".text = ''
    theme[main_bg]="${p.bg}"
    theme[main_fg]="${p.fg}"
    theme[title]="${p.fg}"
    theme[hi_fg]="${p.green}"
    theme[selected_bg]="${p.selectionBg}"
    theme[selected_fg]="${p.green}"
    theme[inactive_fg]="${p.brightBlack}"
    theme[graph_text]="${p.fg}"
    theme[meter_bg]="${p.selectionBg}"
    theme[proc_misc]="${p.cyan}"
    theme[cpu_box]="${p.brightBlack}"
    theme[mem_box]="${p.brightBlack}"
    theme[net_box]="${p.brightBlack}"
    theme[proc_box]="${p.brightBlack}"
    theme[div_line]="${p.selectionBg}"
    theme[temp_start]="${p.green}"
    theme[temp_mid]="${p.yellow}"
    theme[temp_end]="${p.red}"
    theme[cpu_start]="${p.green}"
    theme[cpu_mid]="${p.cyan}"
    theme[cpu_end]="${p.blue}"
    theme[free_start]="${p.blue}"
    theme[free_mid]="${p.cyan}"
    theme[free_end]="${p.green}"
    theme[cached_start]="${p.yellow}"
    theme[cached_mid]="${p.orange}"
    theme[cached_end]="${p.red}"
    theme[available_start]="${p.magenta}"
    theme[available_mid]="${p.blue}"
    theme[available_end]="${p.blue}"
    theme[used_start]="${p.green}"
    theme[used_mid]="${p.yellow}"
    theme[used_end]="${p.red}"
    theme[download_start]="${p.blue}"
    theme[download_mid]="${p.cyan}"
    theme[download_end]="${p.green}"
    theme[upload_start]="${p.red}"
    theme[upload_mid]="${p.orange}"
    theme[upload_end]="${p.yellow}"
  '';
}
