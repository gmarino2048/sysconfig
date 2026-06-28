{ theme, ... }:
let
  p = (import ../themes).${theme}.palette;
in
{
  # Ghostty is installed via Homebrew; its config is managed here.
  xdg.configFile."ghostty/config".text = ''
    font-family = "FiraCode Nerd Font"
    font-size = 13
    background-opacity = 0.9
    background-blur-radius = 20

    background = ${p.bg}
    foreground = ${p.fg}
    cursor-color = ${p.cursor}
    selection-background = ${p.selectionBg}

    palette = 0=${p.black}
    palette = 1=${p.red}
    palette = 2=${p.green}
    palette = 3=${p.yellow}
    palette = 4=${p.blue}
    palette = 5=${p.magenta}
    palette = 6=${p.cyan}
    palette = 7=${p.white}
    palette = 8=${p.brightBlack}
    palette = 9=${p.red}
    palette = 10=${p.green}
    palette = 11=${p.yellow}
    palette = 12=${p.blue}
    palette = 13=${p.magenta}
    palette = 14=${p.cyan}
    palette = 15=${p.brightWhite}
  '';
}
