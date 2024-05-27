{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.user;
  defaultIconFileName = "profile.png";
  defaultIcon = pkgs.stdenvNoCC.mkDerivation {
    name = "default-icon";
    src = ./. + "/${defaultIconFileName}";

    dontUnpack = true;

    installPhase = ''
      cp $src $out
    '';

    passthru = {fileName = defaultIconFileName;};
  };
  propagatedIcon =
    pkgs.runCommandNoCC "propagated-icon"
    {passthru = {fileName = cfg.icon.fileName;};}
    ''
      local target="$out/share/plusultra-icons/user/${cfg.name}"
      mkdir -p "$target"

      cp ${cfg.icon} "$target/${cfg.icon.fileName}"
    '';
in {
  options.plusultra.user = with types; {
    name = mkOpt str "zhao" "The name to use for the user account.";
    fullName = mkOpt str "Zhaohui Wang" "The full name of the user.";
    email = mkOpt str "18811365389@163.com" "The email of the user.";
    initialPassword =
      mkOpt str "password"
      "The initial password to use when the user is first created.";
    icon =
      mkOpt (nullOr package) defaultIcon
      "The profile picture to use for the user.";
    prompt-init = mkBoolOpt true "Whether or not to show an initial message when opening a new shell.";
    extraGroups = mkOpt (listOf str) [] "Groups for the user to be assigned.";
    extraOptions =
      mkOpt attrs {}
      (mdDoc "Extra options passed to `users.users.<name>`.");
  };

  config = {
    environment.systemPackages = with pkgs; [
      cowsay
      fortune
      lolcat
      propagatedIcon
    ];

    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      histFile = "$XDG_CACHE_HOME/zsh.history";
    };

    users.users.${cfg.name} =
      {
        isNormalUser = true;

        inherit (cfg) name initialPassword;

        home = "/home/${cfg.name}";
        group = "users";

        shell = pkgs.zsh;

        # Arbitrary user ID to use for the user. Since I only
        # have a single user on my machines this won't ever collide.
        # However, if you add multiple users you'll need to change this
        # so each user has their own unique uid (or leave it out for the
        # system to select).
        uid = 1000;

        extraGroups = [] ++ cfg.extraGroups;
      }
      // cfg.extraOptions;

      # Icon
      #script_name = "set_icon_${cfg.name}";
      system.userActivationScripts.set_icon.text = ''
        if [[ ! -f "''$HOME/.face" ]]; then
          ln -s "${propagatedIcon}/share/plusultra-icons/user/${cfg.name}/${cfg.icon.fileName}" "''$HOME/.face"
        fi
      '';
  };
}
