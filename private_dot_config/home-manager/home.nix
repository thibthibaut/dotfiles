{
  config,
  pkgs,
  lib,
  ...
}:

let
  pkgsUnstable = import <nixpkgs-unstable> { };
in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tvercueil";
  home.homeDirectory = "/home/tvercueil/";
  home.enableNixpkgsReleaseCheck = false;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.runc # Container runtime
    pkgs.conmon # Container monitor (often missing in basic installs)
    pkgs.slirp4netns # User-mode networking (vital for rootless)
    pkgs.fuse-overlayfs # User-mode filesystem
    pkgs.age
    pkgs.android-tools
    pkgs.arandr
    pkgs.asciinema
    pkgs.ast-grep
    pkgs.atuin
    pkgs.awscli2
    pkgs.bacon
    pkgs.baobab
    pkgs.bash-language-server
    pkgs.bat
    pkgs.bear
    pkgs.binwalk
    pkgs.bpm-tools
    pkgs.brave
    pkgs.brave
    pkgs.ccache
    pkgs.check-jsonschema
    pkgs.chezmoi
    pkgs.cmake-language-server
    pkgs.commitizen
    pkgs.conan
    pkgs.delta
    pkgs.direnv
    pkgs.doxygen
    pkgs.dust
    pkgs.entr
    pkgs.eza
    pkgs.fd
    pkgs.feh
    pkgs.ffmpeg
    pkgs.flameshot
    pkgs.fortune
    pkgs.freeoffice
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
    pkgs.imhex
    pkgs.inkscape
    pkgs.jrnl
    pkgs.just
    pkgs.kitty
    pkgs.lazygit
    pkgs.llvmPackages_19.clang-tools
    pkgs.mermaid-cli
    pkgs.most
    pkgs.nerd-fonts.iosevka
    pkgs.nil
    pkgs.ninja
    pkgs.nix-your-shell
    pkgs.nodejs
    pkgs.nushell
    pkgs.obsidian
    pkgs.openvpn
    pkgs.pandoc
    pkgs.patchelf
    pkgs.peek
    pkgs.podman
    pkgs.poetry
    pkgs.pre-commit
    pkgs.presenterm
    pkgs.rawtherapee
    pkgs.rclone
    pkgs.ripgrep
    pkgs.rofi
    pkgs.ruff
    pkgs.rustup
    pkgs.s3cmd
    pkgs.s4cmd
    pkgs.s5cmd
    pkgs.sct
    pkgs.serpl
    pkgs.shfmt
    pkgs.slack
    pkgs.sox
    pkgs.sshfs
    pkgs.sshfs
    pkgs.sttr
    pkgs.sxiv
    pkgs.taplo
    pkgs.taskwarrior3
    pkgs.teams-for-linux
    pkgs.television
    pkgs.tinymist
    pkgs.tldr
    pkgs.traceroute
    pkgs.typst
    pkgs.typstyle
    pkgs.unar
    pkgs.valgrind
    pkgs.vlc
    pkgs.vscode-langservers-extracted
    pkgs.vscodium
    pkgs.wgnord
    pkgs.wireguard-tools
    pkgs.xclip
    pkgs.xdg-utils
    pkgs.yazi
    pkgs.zathura
    pkgs.zellij
    pkgs.zsync
    pkgsUnstable.devenv
    pkgsUnstable.helix
    pkgsUnstable.uv

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
    CPM_SOURCE_CACHE = "$HOME/.cache/cpm";
    NIXPKGS_ALLOW_UNFREE = "1";

    EDITOR = "hx";

    XKB_DEFAULT_LAYOUT = "us";
    XKB_DEFAULT_VARIANT = "altgr-intl";

    # Add local bin to PATH implicitly by extending the path
    PATH = "$HOME/.local/bin:$PATH";
  };

  programs.fish = {
    enable = true;

    # Fix for Nix on Ubuntu: ensure environment is loaded
    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      # Standard Nix setup for non-NixOS
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
      end

      # Hybrid Vi/Emacs bindings
      fish_vi_key_bindings --no-erase insert

      # Bind Ctrl+Z to foreground
      bind -M insert \cz 'fg 2>/dev/null; commandline -f repaint'
      bind \cz 'fg 2>/dev/null; commandline -f repaint'
    '';

    # Plugins managed by Nix
    plugins = [
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
      # nix-your-shell is better managed as a package + init script if not using the module,
      # but there is a dedicated program module for it too (see below)
    ];

    # Aliases
    shellAliases = {
      j = "just";
      ls = "eza --icons"; # exa is unmaintained, switched to eza (drop-in replacement)
      cat = "bat";
      blue = "bluetoothctl connect AC:80:0A:AB:6F:89";
      unblue = "bluetoothctl disconnect AC:80:0A:AB:6F:89";
      hifi = "pacmd set-card-profile bluez_card.AC_80_0A_AB_6F_89 a2dp_sink";
      mountceleste = "sudo -e sshfs -o allow_other,default_permissions tvercueil@10.114.2.73:/share2/ /mnt/celeste2";
      # Note: command substitution $() works differently in fish, but aliases are literal text replacement.
      # For complex logic, functions are better, but this often works if invoked as `cdd`
      cdd = "cd (git rev-parse --show-toplevel)";
      s5cmd = "s5cmd --endpoint-url=https://axzhdeir8b7i.compat.objectstorage.eu-frankfurt-1.oraclecloud.com";

      # Docker alias (kept exactly as requested)
      Q = "docker run -it -u (id -u):(id -g) -v (pwd):(pwd) -w (pwd) rg.fr-par.scw.cloud/prophesee-devops/qnn:2.8";
    };

    # Abbreviations
    shellAbbrs = {
      gs = "git status";
      cm = "chezmoi";
      lg = "lazygit";
      ns = "nix-shell -p";
    };

    # Custom Functions
    functions = {
      # Yazi wrapper
      n = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
    };
  };

  # Enable these modules so they automatically hook into Fish
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ]; # If you want to customize bindings manually
    settings = {
      # ATUIN_NOBIND true equivalent
      # We manually bind keys in interactiveShellInit or let atuin handle it
      # If you set this to true, atuin won't bind anything automatically
      # auto_sync = true;
    };
  };

  # For the custom Atuin bindings, add this back to interactiveShellInit if the module defaults aren't enough:
  # bind \cr _atuin_search
  # bind -M insert \cr _atuin_search

  # Nix-your-shell integration
  programs.nix-your-shell = {
    enable = true;
    enableFishIntegration = true;
  };

  services.podman.enable = true;
  # xsession.enable = true;
  # xsession.windowManager.command = "${pkgs.i3}/bin/i3";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
