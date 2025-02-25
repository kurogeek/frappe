{
  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts";
    };

    process-compose-flake.url = "github:Platonic-Systems/process-compose-flake";
    services-flake.url = "github:juspay/services-flake";

    devshell = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/devshell";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { flake-parts, devshell, ... }@inputs:
  flake-parts.lib.mkFlake { inherit inputs; }(
    { lib, ... }: {
      systems = [ "x86_64-linux" ];
      imports = [ 
        devshell.flakeModule
      ];
      perSystem = { pkgs, ... }: let
        frappe-yarn = pkgs.mkYarnPackage {
          pname = "frappe";
          version = "1.1.1";
          src = ./.;

          buildPhase = ''
          
          '';
          installPhase = '''';

          distPhase = '''';

        };

      in {

        

        packages = {
          frappe-yarn = frappe-yarn;

          devshells.default = {
            env = [

            ];

            packages = with pkgs; [
              nodejs
              turbo
              python312
            ];
          };
        };
      };
    }
  );
}
