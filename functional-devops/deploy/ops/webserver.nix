{ ... }: {
  imports = [ ../nix/service-patched.nix ];
  services.blank-me-up.enable = true;
  services.blank-me-up.port = 3001;
}
