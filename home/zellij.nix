{ theme, ... }:
let
  t = (import ../themes).${theme};
  p = t.palette;

  # Helpers to build the KDL keybinds tree. home-manager's toKDL generator uses
  # `_args` for node arguments and `_children` for ordered child nodes, which we
  # need here because each mode contains many same-named `bind` nodes (and the
  # config has several `shared_among`/`shared_except` blocks at the same level).
  bind = key: actions: {
    bind = {
      _args = [ key ];
      _children = actions;
    };
  };
  mode = name: binds: {
    ${name} = {
      _children = binds;
    };
  };
  sharedAmong = modes: binds: {
    shared_among = {
      _args = modes;
      _children = binds;
    };
  };
  sharedExcept = modes: binds: {
    shared_except = {
      _args = modes;
      _children = binds;
    };
  };
  plugin = name: {
    LaunchOrFocusPlugin = {
      _args = [ name ];
      floating = true;
      move_to_focused_tab = true;
    };
  };
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

      keybinds = {
        _props.clear-defaults = true;
        _children = [
          (mode "locked" [
            (bind "Ctrl g" [ { SwitchToMode = "normal"; } ])
          ])
          (mode "pane" [
            (bind "left" [ { MoveFocus = "left"; } ])
            (bind "down" [ { MoveFocus = "down"; } ])
            (bind "up" [ { MoveFocus = "up"; } ])
            (bind "right" [ { MoveFocus = "right"; } ])
            (bind "c" [
              { SwitchToMode = "renamepane"; }
              { PaneNameInput = 0; }
            ])
            (bind "d" [
              { NewPane = "down"; }
              { SwitchToMode = "locked"; }
            ])
            (bind "e" [
              { TogglePaneEmbedOrFloating = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "f" [
              { ToggleFocusFullscreen = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "h" [ { MoveFocus = "left"; } ])
            (bind "i" [
              { TogglePanePinned = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "j" [ { MoveFocus = "down"; } ])
            (bind "k" [ { MoveFocus = "up"; } ])
            (bind "l" [ { MoveFocus = "right"; } ])
            (bind "n" [
              { NewPane = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "p" [ { SwitchToMode = "normal"; } ])
            (bind "r" [
              { NewPane = "right"; }
              { SwitchToMode = "locked"; }
            ])
            (bind "s" [
              { NewPane = "stacked"; }
              { SwitchToMode = "locked"; }
            ])
            (bind "w" [
              { ToggleFloatingPanes = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "x" [
              { CloseFocus = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "z" [
              { TogglePaneFrames = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "tab" [ { SwitchFocus = { }; } ])
          ])
          (mode "tab" [
            (bind "left" [ { GoToPreviousTab = { }; } ])
            (bind "down" [ { GoToNextTab = { }; } ])
            (bind "up" [ { GoToPreviousTab = { }; } ])
            (bind "right" [ { GoToNextTab = { }; } ])
            (bind "1" [
              { GoToTab = 1; }
              { SwitchToMode = "locked"; }
            ])
            (bind "2" [
              { GoToTab = 2; }
              { SwitchToMode = "locked"; }
            ])
            (bind "3" [
              { GoToTab = 3; }
              { SwitchToMode = "locked"; }
            ])
            (bind "4" [
              { GoToTab = 4; }
              { SwitchToMode = "locked"; }
            ])
            (bind "5" [
              { GoToTab = 5; }
              { SwitchToMode = "locked"; }
            ])
            (bind "6" [
              { GoToTab = 6; }
              { SwitchToMode = "locked"; }
            ])
            (bind "7" [
              { GoToTab = 7; }
              { SwitchToMode = "locked"; }
            ])
            (bind "8" [
              { GoToTab = 8; }
              { SwitchToMode = "locked"; }
            ])
            (bind "9" [
              { GoToTab = 9; }
              { SwitchToMode = "locked"; }
            ])
            (bind "[" [
              { BreakPaneLeft = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "]" [
              { BreakPaneRight = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "b" [
              { BreakPane = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "h" [ { GoToPreviousTab = { }; } ])
            (bind "j" [ { GoToNextTab = { }; } ])
            (bind "k" [ { GoToPreviousTab = { }; } ])
            (bind "l" [ { GoToNextTab = { }; } ])
            (bind "n" [
              { NewTab = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "r" [
              { SwitchToMode = "renametab"; }
              { TabNameInput = 0; }
            ])
            (bind "s" [
              { ToggleActiveSyncTab = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "t" [ { SwitchToMode = "normal"; } ])
            (bind "x" [
              { CloseTab = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "tab" [ { ToggleTab = { }; } ])
          ])
          (mode "resize" [
            (bind "left" [ { Resize = "Increase left"; } ])
            (bind "down" [ { Resize = "Increase down"; } ])
            (bind "up" [ { Resize = "Increase up"; } ])
            (bind "right" [ { Resize = "Increase right"; } ])
            (bind "+" [ { Resize = "Increase"; } ])
            (bind "-" [ { Resize = "Decrease"; } ])
            (bind "=" [ { Resize = "Increase"; } ])
            (bind "H" [ { Resize = "Decrease left"; } ])
            (bind "J" [ { Resize = "Decrease down"; } ])
            (bind "K" [ { Resize = "Decrease up"; } ])
            (bind "L" [ { Resize = "Decrease right"; } ])
            (bind "h" [ { Resize = "Increase left"; } ])
            (bind "j" [ { Resize = "Increase down"; } ])
            (bind "k" [ { Resize = "Increase up"; } ])
            (bind "l" [ { Resize = "Increase right"; } ])
            (bind "r" [ { SwitchToMode = "normal"; } ])
          ])
          (mode "move" [
            (bind "left" [ { MovePane = "left"; } ])
            (bind "down" [ { MovePane = "down"; } ])
            (bind "up" [ { MovePane = "up"; } ])
            (bind "right" [ { MovePane = "right"; } ])
            (bind "h" [ { MovePane = "left"; } ])
            (bind "j" [ { MovePane = "down"; } ])
            (bind "k" [ { MovePane = "up"; } ])
            (bind "l" [ { MovePane = "right"; } ])
            (bind "m" [ { SwitchToMode = "normal"; } ])
            (bind "n" [ { MovePane = { }; } ])
            (bind "p" [ { MovePaneBackwards = { }; } ])
            (bind "tab" [ { MovePane = { }; } ])
          ])
          (mode "scroll" [
            (bind "Alt left" [
              { MoveFocusOrTab = "left"; }
              { SwitchToMode = "locked"; }
            ])
            (bind "Alt down" [
              { MoveFocus = "down"; }
              { SwitchToMode = "locked"; }
            ])
            (bind "Alt up" [
              { MoveFocus = "up"; }
              { SwitchToMode = "locked"; }
            ])
            (bind "Alt right" [
              { MoveFocusOrTab = "right"; }
              { SwitchToMode = "locked"; }
            ])
            (bind "e" [
              { EditScrollback = { }; }
              { SwitchToMode = "locked"; }
            ])
            (bind "f" [
              { SwitchToMode = "entersearch"; }
              { SearchInput = 0; }
            ])
            (bind "Alt h" [
              { MoveFocusOrTab = "left"; }
              { SwitchToMode = "locked"; }
            ])
            (bind "Alt j" [
              { MoveFocus = "down"; }
              { SwitchToMode = "locked"; }
            ])
            (bind "Alt k" [
              { MoveFocus = "up"; }
              { SwitchToMode = "locked"; }
            ])
            (bind "Alt l" [
              { MoveFocusOrTab = "right"; }
              { SwitchToMode = "locked"; }
            ])
            (bind "s" [ { SwitchToMode = "normal"; } ])
          ])
          (mode "search" [
            (bind "c" [ { SearchToggleOption = "CaseSensitivity"; } ])
            (bind "n" [ { Search = "down"; } ])
            (bind "o" [ { SearchToggleOption = "WholeWord"; } ])
            (bind "p" [ { Search = "up"; } ])
            (bind "w" [ { SearchToggleOption = "Wrap"; } ])
          ])
          (mode "session" [
            (bind "a" [
              (plugin "zellij:about")
              { SwitchToMode = "locked"; }
            ])
            (bind "c" [
              (plugin "configuration")
              { SwitchToMode = "locked"; }
            ])
            (bind "d" [ { Detach = { }; } ])
            (bind "l" [
              (plugin "zellij:layout-manager")
              { SwitchToMode = "locked"; }
            ])
            (bind "o" [ { SwitchToMode = "normal"; } ])
            (bind "p" [
              (plugin "plugin-manager")
              { SwitchToMode = "locked"; }
            ])
            (bind "s" [
              (plugin "zellij:share")
              { SwitchToMode = "locked"; }
            ])
            (bind "w" [
              (plugin "session-manager")
              { SwitchToMode = "locked"; }
            ])
          ])
          (sharedAmong
            [ "normal" "locked" ]
            [
              (bind "Alt left" [ { MoveFocusOrTab = "left"; } ])
              (bind "Alt down" [ { MoveFocus = "down"; } ])
              (bind "Alt up" [ { MoveFocus = "up"; } ])
              (bind "Alt right" [ { MoveFocusOrTab = "right"; } ])
              (bind "Alt +" [ { Resize = "Increase"; } ])
              (bind "Alt -" [ { Resize = "Decrease"; } ])
              (bind "Alt =" [ { Resize = "Increase"; } ])
              (bind "Alt [" [ { PreviousSwapLayout = { }; } ])
              (bind "Alt ]" [ { NextSwapLayout = { }; } ])
              (bind "Alt f" [ { ToggleFloatingPanes = { }; } ])
              (bind "Alt h" [ { MoveFocusOrTab = "left"; } ])
              (bind "Alt i" [ { MoveTab = "left"; } ])
              (bind "Alt j" [ { MoveFocus = "down"; } ])
              (bind "Alt k" [ { MoveFocus = "up"; } ])
              (bind "Alt l" [ { MoveFocusOrTab = "right"; } ])
              (bind "Alt n" [ { NewPane = { }; } ])
              (bind "Alt o" [ { MoveTab = "right"; } ])
              (bind "Alt p" [ { TogglePaneInGroup = { }; } ])
              (bind "Alt Shift p" [ { ToggleGroupMarking = { }; } ])
            ]
          )
          (sharedExcept
            [ "locked" "renametab" "renamepane" ]
            [
              (bind "Ctrl g" [ { SwitchToMode = "locked"; } ])
              (bind "Ctrl q" [ { Quit = { }; } ])
            ]
          )
          (sharedExcept
            [ "locked" "entersearch" ]
            [
              (bind "enter" [ { SwitchToMode = "locked"; } ])
            ]
          )
          (sharedExcept
            [ "locked" "entersearch" "renametab" "renamepane" ]
            [
              (bind "esc" [ { SwitchToMode = "locked"; } ])
            ]
          )
          (sharedExcept
            [ "locked" "entersearch" "renametab" "renamepane" "move" ]
            [
              (bind "m" [ { SwitchToMode = "move"; } ])
            ]
          )
          (sharedExcept
            [ "locked" "entersearch" "search" "renametab" "renamepane" "session" ]
            [
              (bind "o" [ { SwitchToMode = "session"; } ])
            ]
          )
          (sharedExcept
            [ "locked" "tab" "entersearch" "renametab" "renamepane" ]
            [
              (bind "t" [ { SwitchToMode = "tab"; } ])
            ]
          )
          (sharedAmong
            [ "normal" "resize" "tab" "scroll" "prompt" "tmux" ]
            [
              (bind "p" [ { SwitchToMode = "pane"; } ])
            ]
          )
          (sharedAmong
            [ "normal" "resize" "search" "move" "prompt" "tmux" ]
            [
              (bind "s" [ { SwitchToMode = "scroll"; } ])
            ]
          )
          (sharedExcept
            [
              "locked"
              "resize"
              "pane"
              "tab"
              "entersearch"
              "renametab"
              "renamepane"
            ]
            [
              (bind "r" [ { SwitchToMode = "resize"; } ])
            ]
          )
          (sharedAmong
            [ "scroll" "search" ]
            [
              (bind "PageDown" [ { PageScrollDown = { }; } ])
              (bind "PageUp" [ { PageScrollUp = { }; } ])
              (bind "left" [ { PageScrollUp = { }; } ])
              (bind "down" [ { ScrollDown = { }; } ])
              (bind "up" [ { ScrollUp = { }; } ])
              (bind "right" [ { PageScrollDown = { }; } ])
              (bind "Ctrl b" [ { PageScrollUp = { }; } ])
              (bind "Ctrl c" [
                { ScrollToBottom = { }; }
                { SwitchToMode = "locked"; }
              ])
              (bind "d" [ { HalfPageScrollDown = { }; } ])
              (bind "Ctrl f" [ { PageScrollDown = { }; } ])
              (bind "h" [ { PageScrollUp = { }; } ])
              (bind "j" [ { ScrollDown = { }; } ])
              (bind "k" [ { ScrollUp = { }; } ])
              (bind "l" [ { PageScrollDown = { }; } ])
              (bind "u" [ { HalfPageScrollUp = { }; } ])
            ]
          )
          (mode "entersearch" [
            (bind "Ctrl c" [ { SwitchToMode = "scroll"; } ])
            (bind "esc" [ { SwitchToMode = "scroll"; } ])
            (bind "enter" [ { SwitchToMode = "search"; } ])
          ])
          (mode "renametab" [
            (bind "esc" [
              { UndoRenameTab = { }; }
              { SwitchToMode = "tab"; }
            ])
          ])
          (sharedAmong
            [ "renametab" "renamepane" ]
            [
              (bind "Ctrl c" [ { SwitchToMode = "locked"; } ])
            ]
          )
          (mode "renamepane" [
            (bind "esc" [
              { UndoRenamePane = { }; }
              { SwitchToMode = "pane"; }
            ])
          ])
        ];
      };
    };
  };
}
