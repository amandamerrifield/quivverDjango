{ nixpkgs ? import <nixpkgs> {} }:
 
let
  app-name = "quivver";
  settings = "quivver.settings";


  # Assemble the pieces of a web app!
  python = import ./nix/python.nix {};
  uwsgi = import ./nix/gunicorn.nix {inherit app-name settings;};
  # webserver = import ./nix/nginx.nix {inherit app-name;};
  # database = import ./nix/postgres.nix {inherit app-name;};

in
  nixpkgs.stdenv.mkDerivation rec {
    name = "quivver-django";
    src=./.;
    buildInputs = [
      python
      uwsgi
    ];
  }
