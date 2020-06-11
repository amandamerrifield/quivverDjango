{}:
with import <nixpkgs> {};
let
  # the interpreter we're choosing to use
  interpreter = python37;
  # A function that takes a package set and selects a list from that set
  choosePackages = pkgs: with pkgs; [
      django_2_2
      jinja2
      ipython
      whitenoise
      gunicorn
      psycopg2
  ];
in
  interpreter.withPackages choosePackages
