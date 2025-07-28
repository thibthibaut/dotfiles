{
  description = "Home Manager configuration of tibo";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
      zen-browser.url = "github:0xc000022070/zen-browser-flake";
      ghostty.url = "github:ghostty-org/ghostty";
      nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { nixpkgs, home-manager, zen-browser, ghostty, nixgl,  ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      ghostty-wrapped = pkgs.writeShellScriptBin "ghostty" ''
        ${nixgl.packages.${system}.default}/bin/nixGL ${ghostty.packages.${system}.default}/bin/ghostty "$@"
      '';
      
      # Create a modified desktop entry that uses our wrapped binary
      ghostty-desktop = pkgs.runCommand "ghostty-desktop" {} ''
        mkdir -p $out/share/applications
        cp ${ghostty.packages.${system}.default}/share/applications/com.mitchellh.ghostty.desktop $out/share/applications/
        # Replace the Exec lines to use our wrapped binary
        substituteInPlace $out/share/applications/com.mitchellh.ghostty.desktop \
          --replace "Exec=ghostty" "Exec=${ghostty-wrapped}/bin/ghostty" \
          --replace "Exec=/nix/store/" "Exec=${ghostty-wrapped}/bin/ghostty"
      '';
      
    in {
      homeConfigurations."tvercueil" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          {
              home.packages = [
                # zen-browser.packages."${system}".default
                #ghostty.packages."${system}".default
                ghostty-wrapped
                ghostty-desktop
                nixgl.packages."${system}".default
              ];
            
          }
           ./home.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
