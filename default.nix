{ nixpkgs ? import <nixpkgs> {} }:
 
let
  user = "quivver";
  db-name = "quivver";
  settings = "quivver.settings";
  src = ./src;
  wsgi = "quivver/wsgi.py";


  # Assemble the pieces of a web app!
  python = import ./nix/python.nix {};
  uwsgi = import ./nix/gunicorn.nix {inherit user python settings wsgi src;};
  webserver = import ./nix/nginx.nix {inherit user;};
  database = import ./nix/postgres.nix {inherit user db-name;};

in
  nixpkgs.stdenv.mkDerivation rec {
    name = "quivver-django";
    src=./.;
    buildInputs = [
      python
      uwsgi
    ];
  }
