{
  network.description = "Web server";
  network.enableRollback = true;

  webserver = import ./webserver.nix;
}
