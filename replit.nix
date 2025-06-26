{ pkgs }: {
  deps = [
    pkgs.jdk21_headless
    pkgs.wget
    pkgs.unzip
    pkgs.python313
    pkgs.udev
  ];
}
