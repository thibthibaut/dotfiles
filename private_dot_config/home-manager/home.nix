{ config, pkgs, lib, ... }:


let
 pkgsUnstable = import <nixpkgs-unstable> {};
in

# https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tvercueil";
  home.homeDirectory = "/home/tvercueil/";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
   
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.nushell
    pkgs.zathura
    pkgs.nodejs
    pkgs.imhex
    pkgs.lazygit
    pkgs.mermaid-cli
    pkgs.presenterm
    pkgs.inkscape
    pkgs.freeoffice
    pkgs.arandr
    pkgs.sxiv
    pkgs.television
    pkgs.devenv
    pkgs.bear
    pkgs.android-tools
    pkgs.llvmPackages_19.clang-tools
    pkgs.awscli2
    pkgs.brave
    pkgs.xclip
    pkgs.age
    pkgs.fish
    pkgs.fishPlugins.bass
    pkgs.fishPlugins.tide
    pkgs.asciinema
    pkgs.ast-grep
    pkgs.atuin
    pkgs.bacon
    pkgs.baobab
    pkgs.bash-language-server
    pkgs.bat
    pkgs.binwalk
    pkgs.brave
    pkgs.ccache
    pkgs.check-jsonschema
    pkgs.chezmoi
    pkgs.cmake-language-server
    pkgs.commitizen
    pkgs.conan
    pkgs.delta
    pkgs.direnv
    pkgs.docker
    pkgs.dogdns
    pkgs.doxygen
    pkgs.dust
    pkgs.entr
    pkgs.eza
    pkgs.fd
    pkgs.feh
    pkgs.ffmpeg
    pkgs.flameshot
    pkgs.fortune
    pkgs.fzf
    pkgs.gh
    pkgs.gimp
    pkgs.git
    pkgs.git-lfs
    pkgs.gitui
    pkgs.go
    pkgs.htop
    pkgs.hyperfine
    pkgs.imagemagick
    pkgs.jrnl
    pkgs.just
    pkgs.kitty
    pkgs.most
    pkgs.nil
    pkgs.ninja
    pkgs.nix-your-shell
    pkgs.obsidian
    pkgs.openvpn
    pkgs.pandoc
    pkgs.patchelf
    pkgs.peek
    pkgs.poetry
    pkgs.pre-commit
    pkgs.rawtherapee
    pkgs.rclone
    pkgs.ripgrep
    pkgs.rofi
    pkgs.ruff
    pkgs.rustup
    pkgs.s3cmd
    pkgs.s4cmd
    pkgs.s5cmd
    pkgs.sttr
    pkgs.sshfs
    pkgs.sct
    pkgs.serpl
    pkgs.shfmt
    # pkgs.signal-desktop
    pkgs.slack
    pkgs.spotify
    pkgs.sshfs
    pkgs.taplo
    pkgs.taskwarrior3
    pkgs.teams-for-linux
    pkgs.tldr
    pkgs.traceroute
    pkgs.typst
    pkgs.tinymist
    pkgs.typstyle
    pkgs.unar
    pkgs.uv
    pkgs.valgrind
    pkgs.vlc
    pkgs.vscode-langservers-extracted
    pkgs.vscodium
    pkgs.wgnord
    pkgs.wireguard-tools
    pkgs.xdg-utils
    pkgs.yazi
    pkgs.zellij
    pkgs.zsync
    pkgsUnstable.helix
    pkgs.nerd-fonts.iosevka

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    # Define a location for the AppImage
#   ".local/bin/netron" = {
#    source = builtins.fetchurl {
#      url = "https://github.com/lutzroeder/netron/releases/download/v7.9.5/Netron-7.9.5.AppImage";
#      sha256 = "0n8n6m6b9fn191rnagcgvq2fcmk41y3w10r800id2ay5fdbarxss";
#
#    };
#    executable = true; 
#  };
  };

  home.activation = {
    uv = lib.mkAfter ''
        ${pkgs.uv}/bin/uv tool install cmake@3.26.0 --force
    '';

  };


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tvercueil/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
      EDITOR = "hx";
      # Set the keyboard layout when the session starts
      XKB_DEFAULT_LAYOUT = "us";
      XKB_DEFAULT_VARIANT = "alt-intl";
  };


  # home.activation.setMimeDefaults = lib.mkAfter ''
  #   # Set Brave as the default for additional MIME types
  #   xdg-mime default brave-browser.desktop text/html
  #   xdg-mime default brave-browser.desktop application/xhtml+xml
  # '';


  xsession.enable = true;
  xsession.windowManager.command = "${pkgs.i3}/bin/i3";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # programs.docker.virtualisation.docker.enable = true;
}
