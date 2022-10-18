{ config, pkgs, lib, ... }:

{
  home.stateVersion = "22.05";

  # https://github.com/malob/nixpkgs/blob/master/home/default.nix

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  # Neo Vim
  programs.neovim.enable = true;
  programs.neovim.vimAlias = true;

  home.packages = with pkgs; [
    # Some basics
    coreutils
    curl
    wget

    # Dev stuff
    # (agda.withPackages (p: [ p.standard-library ]))
    jq
    podman
    podman-compose
    podman-tui
    qemu
    nodePackages.typescript
    nodejs
    python310
    python310Packages.jedi
    vimPlugins.jedi-vim
    bottom
    zig
    virtualenv
    gnupg
    nmap
    tmux
    # Useful nix related tools
    cachix # adding/managing alternative binary caches hosted by Cachix
    # comma # run software from without installing it
    niv # easy dependency management for nix projects
    nodePackages.node2nix

    # RTL
    rtl-sdr

  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
    weechat
    # Github CLI
    delta
    gh
    fzf
    ngrok
    yarn
    ctags
    neofetch
    ffmpeg
    llvm
    emacs
    aws-iam-authenticator
  ];

  # Misc configuration files --------------------------------------------------------------------{{{

}
