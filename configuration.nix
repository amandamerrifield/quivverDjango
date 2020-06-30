# Configuration files for a fresh system running this only this application
# manage.py of the project can be called via manage-`projectname`
{config, pkgs, ...}:
let
  user = "quivver";
  app-name = user;
  settings = "quivver.settings_nix";
  name = "quivverDjango";
  port = 8080;
  gunicorn = import nix/gunicorn.nix {inherit app-name settings port;};
  python = import nix/python.nix {};

in
{
  environment.systemPackages = [
    python
    gunicorn
  ];

  # Open the firewall! This is a web server after all
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # create django user
  users.users.${user} = {};

  # We name the service like the specified user.
  # This allows us to have multiple django projects running in parallel
  systemd.services.${user} = {
    description = "${name} django service";
    wantedBy = [ "multi-user.target" ];
    wants = [ "postgresql.service" ];
    after = [ "network.target" "postgresql.service" ];
    serviceConfig = {
      LimitNOFILE = "99999";
      LimitNPROC = "99999";
      User = user;
      # AmbientCapabilities = "CAP_NET_BIND_SERVICE";  # to be able to bind to low number ports
    };
    script = ''
      ${gunicorn}/bin/serve
    '';
  };

  # We serve the django app out using Nginx, and let that take care of SSL for us
  services.nginx.enable = true;

  services.nginx.virtualHosts."quivver.merrifield.io" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString port}";
      extraConfig = ''
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_pass_header Authorization;
      '';
    };
  };

  # We punch a few holes in the firewall so the web service can work
  security.acme = {
    renewInterval = "hourly";
  };

  # We make sure there's a database up and running we can connect to
  # Furthermore, we make sure that the quivver user has access to their own schema
  services.postgresql = {
    enable = true;
    ensureDatabases = [ user ];
    ensureUsers = [{
      name = "${user}";
      ensurePermissions = {
        "DATABASE ${user}" = "ALL PRIVILEGES";
      };
    }];
    package = pkgs.postgresql_11;
  };
}
