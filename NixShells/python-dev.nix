{ pkgs ? import <nixpkgs> {} }:

let
  pythonEnv = pkgs.python311.withPackages (ps: with ps; [
    requests
    numpy
    pandas
    matplotlib
    # Add more if needed
  ]);
in

pkgs.mkShell {
  name = "python-dev-shell";

  buildInputs = [
    pythonEnv
    pkgs.git
  ];

  shellHook = ''
    export PYTHONPATH=${pythonEnv}/${pythonEnv.sitePackages}
    echo "🐍 Python dev environment is ready!"
  '';
}
