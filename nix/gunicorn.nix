{
  app-name,
  settings,
  key-file? "",
  port ? 8080,
  processes ? 2,
  threads ? 4,
...}: 

with import <nixpkgs> {};

let

  # Repository-specific configuration options
  python = import ./python.nix {};
  src = "${../src}";
  key_file = "/run/${app-name}/django-keys";

  # Application-specific configuration options
  load-django-env = ''
    export DJANGO_SETTINGS_MODULE=${settings}
  '';
  load-django-keys = ''
    # Keep important secrets out of the nix store!
    KEYS=${key-file}
    if $KEYS && [ -f $KEYS ]; then
      source $KEYS
    fi
  '';
  serve = writeShellScriptBin "serve" ''
      ${load-django-env}
      cd ${src}
      python ${src}/manage.py collectstatic --noinput
      ${python}/bin/gunicorn ${app-name}.wsgi:application \
          --pythonpath ${src} \
          -b 0.0.0.0:${toString port} \
          --workers=${toString processes} \
          --threads=${toString threads}
    '';
in
  serve

