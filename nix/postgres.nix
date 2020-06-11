{user, db-name}:
with import <nixpkgs> {};
{
    services.postgresql = {
        enable = true;
        ensureDatabases = [ db-name ];
        ensureUsers = [{
          name = "${user}";
          ensurePermissions = {
            "DATABASE ${db-name}" = "ALL PRIVILEGES";
          };
        }];
        package = pkgs.postgresql_11;
    };
}
