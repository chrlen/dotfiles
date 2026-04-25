# Shared Homebrew config — imported by all darwin machines.
{ ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "none";
      autoUpdate = false;
      upgrade = false;
    };
    brews = [
      "age"
      "ansible"
      "fd"
      "gnupg"
      "jenv"
      "ncdu"
      "nvm"
      "openjdk"
      "poetry"
      "pyenv"
      "sops"
      "tldr"
      "tmux"
      "tree"
      "watch"
      "wget"
    ];
  };
}
