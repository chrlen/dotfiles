# Ghostty config for macOS. Ghostty is installed via Homebrew cask, so only the config is managed here.
# Do not import on NixOS hosts: programs.ghostty writes the same path.
{ ... }:

{
  home.file.".config/ghostty/config".text = ''
    font-family = monospace
    font-size = 14
    theme = dark:Black Metal (Nile),light:Catppuccin Latte
    window-padding-x = 8
    window-padding-y = 8
    window-decoration = true
    keybind = shift+grave_accent=text:~
    keybind = global:alt+x=toggle_quick_terminal
    keybind = super+ctrl+h=goto_split:left
    keybind = super+ctrl+j=goto_split:down
    keybind = super+ctrl+k=goto_split:up
    keybind = super+ctrl+l=goto_split:right
    quick-terminal-size = 100%
    quick-terminal-animation-duration = 0
    quick-terminal-autohide = false
    background-opacity = 0.8
  '';
}
