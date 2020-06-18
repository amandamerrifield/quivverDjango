{... }:
let

in
{
  webserver = {pkgs, ...}: {
    deployment.targetHost = "ec2-52-33-237-150.us-west-2.compute.amazonaws.com";
    imports = [
      # Start from the existing EC2 machine config that we know works
      # This has matt, root user configs, ssh keys, debugging tools, etc.
      ~/code/xena/nix/configuration.nix

      # Mix in the quivver-specific stuff
      nix/system.nix
    ];
    
  };
}
