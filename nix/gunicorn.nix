{
  settings,
  wsgi,
  src,
  user ? "quivver",
  db-name ? "quivver",
  port ? 8080,
  processes ? 2,
  threads ? 4,
...}: 

with import <nixpkgs> {};

let

  # Repository-specific configuration options
  python = import ./python.nix {};

  # Application-specific configuration options
  load-django-env = ''
    export DJANGO_SETTINGS_MODULE=${settings}
  '';
  load-django-keys = ''
    # Keep important secrets out of the nix store!
    KEYS=/run/${user}/django-keys
    if [ -f $KEYS ]; then
      source $KEYS
    fi
  '';
  serve = writeShellScriptBin "serve" ''
      ${load-django-env}
      ${load-django-keys}
      ${python}/bin/gunicorn quivver.wsgi:application \
          --pythonpath ${src} \
          -b 0.0.0.0:${toString port} \
          --workers=${toString processes} \
          --threads=${toString threads}
          $@
    '';
in
  serve

