{ nixpkgs ? import <nixpkgs> {  } }:
 
let
  python = nixpkgs.python37.withPackages (ps: with ps; [ 
    django_2_2
    jinja2
    ipython
    whitenoise
    gunicorn
    psycopg2
  ]);
in
  nixpkgs.stdenv.mkDerivation rec {
    name = "quivver-django";
    buildInputs = [
      python
    ];
  }
