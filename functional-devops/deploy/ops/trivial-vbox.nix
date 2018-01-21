{
  webserver =
    { config, pkgs, ... }:
    { deployment.targetEnv = "virtualbox";
      deployment.virtualbox.headless = true; # don't show a display
      deployment.virtualbox.memorySize = 1024; # megabytes
      deployment.virtualbox.vcpu = 2; # number of cpus
    };
}
