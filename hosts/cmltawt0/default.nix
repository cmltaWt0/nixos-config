{ pkgs, lib, ... }:
{
  # Nix configuration ------------------------------------------------------------------------------

  nix.settings.substituters = [
    "https://cache.nixos.org/"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
  nix.settings.trusted-users = [
    "@admin"
  ];
  nix.configureBuildUsers = true;

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [];

  # https://github.com/nix-community/home-manager/issues/423
  # environment.variables = {
  #   TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  # };
  programs.nix-index.enable = true;

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
    position                   = "bottom";
    display                    = "main";
    height                     = 26;
    title                      = "on";
    spaces                     = "on";
    clock                      = "on";
    power                      = "on";
    padding_left               = 20;
    padding_right              = 20;
    spacing_left               = 25;
    spacing_right              = 15;
    text_font                  = ''"Menlo:Regular:12.0"'';
    icon_font                  = ''"Font Awesome 5 Free:Solid:12.0"'';
    background_color           = "0xff202020";
    foreground_color           = "0xffa8a8a8";
    power_icon_color           = "0xffcd950c";
    battery_icon_color         = "0xffd75f5f";
    dnd_icon_color             = "0xffa8a8a8";
    clock_icon_color           = "0xffa8a8a8";
    power_icon_strip           = " ";
    space_icon                 = "•";
    space_icon_strip           = "1 2 3 4 5 6 7 8 9 10";
    spaces_for_all_displays    = "on";
    display_separator          = "on";
    display_separator_icon     = "";
    space_icon_color           = "0xff458588";
    space_icon_color_secondary = "0xff78c4d4";
    space_icon_color_tertiary  = "0xfffff9b0";
    clock_icon                 = "";
    dnd_icon                   = "";
    clock_format               = ''"%d/%m/%y %R"'';
    right_shell                = "on";
    right_shell_icon           = "";
    right_shell_command        = "whoami";
    };
  };

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    # updates homebrew packages on activation,
    # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
    brews = [
      "openvpn"
    ];
    casks = [
      "amethyst"
      "slack"
      "signal"
      "threema"
      "discord"
      "element"
      "nomachine"
      "tailscale"
      "obsidian"
      "visual-studio-code"
      "lens"
      "cubicsdr"
      "alacritty"
      "firefox"
      "postman"
      "android-studio"
    ];
  };

}
