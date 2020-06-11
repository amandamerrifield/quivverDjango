{}:
with import <nixpkgs> {};
let
  # the interpreter we're choosing to use
  interpreter = python37;
  # A function that takes a package set and selects a list from that set
  choosePackages = pkgs: with pkgs; [
      # Project dependencies
      django_2_2
      jinja2

      # System dependencies
      whitenoise  # Serve out static files
      brotli      # Compression for whitenoise
      gunicorn    # WSGI server
      psycopg2    # Database connector
  ];
in
  interpreter.withPackages choosePackages
