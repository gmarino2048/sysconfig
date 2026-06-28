{ theme, ... }:
let
  t = (import ../themes).${theme};
  p = t.palette;
in
{
  programs.zellij = {
    enable = true;
    settings = {
      theme = t.zellij;
      default_mode = "locked"; # unlock-first / non-colliding: keys pass through until Ctrl-g
      pane_frames = false;

      themes.${t.zellij} = {
        fg = p.fg;
        bg = p.bg;
        black = p.black;
        red = p.red;
        green = p.green;
        yellow = p.yellow;
        blue = p.blue;
        magenta = p.magenta;
        cyan = p.cyan;
        white = p.white;
        orange = p.orange;
      };
    };
  };
}
