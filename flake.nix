{
  description = "Shared home-manager modules";

  outputs =
    { self }:
    {
      hmModules.common = import ./home/common.nix;
      hmModules.ghostty = import ./home/ghostty.nix;
      darwinModules.homebrew = import ./darwin/homebrew.nix;
    };
}
