{ pkgs }: {
  deps = [
    pkgs.openjdk-headless
    pkgs.wget
    pkgs.unzip
    pkgs.python313
    pkgs.bashInteractive
    pkgs.nodePackages.bash-language-server
    pkgs.man
  ];
}