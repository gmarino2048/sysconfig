{ pkgs, theme, ... }:
let
  themes = import ../themes;
in
{
  home.packages = [ pkgs.nano ];

  # Helix — default editor.
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = themes.${theme}.helix;
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        true-color = true;
        bufferline = "multiple";
        indent-guides.render = true;
        soft-wrap.enable = true;
        lsp.display-messages = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };

  # Vim — airline (git + lsp via ALE).
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-airline-themes
      vim-fugitive
      vim-gitgutter
      ale
    ];
    settings = {
      number = true;
      relativenumber = true;
      expandtab = true;
      tabstop = 4;
      shiftwidth = 4;
    };
    extraConfig = builtins.readFile ./dotfiles/vimrc;
  };
}
