{
  description = "Shared home-manager modules";

  outputs = { self }: {
    hmModules.common = import ./home/common.nix;
  };
}
