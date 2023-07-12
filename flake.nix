{
  description = "Intel® RealSense™ SDK";

  inputs = {
    # Pointing to the current stable release of nixpkgs. You can
    # customize this to point to an older version or unstable if you
    # like everything shining.
    #
    # E.g.
    #
    # nixpkgs.url = "github:NixOS/nixpkgs/unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    overlays.default = final: prev: {
        librealsensex = final.callPackage ./nix/pkgs/librealsense {};
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          (python-final: python-prev: {
            real-sense-sensor = python-final.callPackage ./nix/pkgs/real-sense-sensor {};
          })
        ];
    };
  } // inputs.utils.lib.eachSystem [
    "x86_64-linux"
  ] (system: let
    pkgs-dev = import nixpkgs {
      inherit system;
      overlays = [];
    };

    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        self.overlays.default
      ];
    };
  in {
    devShells.default = pkgs-dev.mkShell rec {
      # Update the name to something that suites your project.
      name = "librealsense";

      packages = with pkgs-dev; [
        # Development Tools
        gcc
        cmake
        cmakeCurses
        ninja
        pkg-config
        nasm

        # Development time dependencies
        gtest

        # Build time and Run time dependencies
        libusb1
        mesa
        gtk3
        glfw
        libGLU
        libjpeg  # This is just libjpeg-turbo
        curl
      ];

      # Setting up the environment variables you need during
      # development.
      shellHook = let
        icon = "f121";
      in ''
        export PS1="$(echo -e '\u${icon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
      '';
    };

    packages.default = pkgs.librealsensex;
    packages.real-sense-sensor = pkgs.python3Packages.real-sense-sensor;
  });
}
