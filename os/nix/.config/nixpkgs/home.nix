{ pkgs, ... }:

{

  xsession.enable = true;
  xsession.windowManager.command = "${pkgs.i3-gaps}/bin/i3";

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.ag
    # pkgs.androidStudioPackages.stable
    pkgs.anki
    pkgs.artha
    pkgs.ardour
    pkgs.arandr
    pkgs.borgbackup
    pkgs.breeze-icons
    pkgs.compton
    pkgs.chromium
    pkgs.dbeaver
    pkgs.deluge
    # pkgs.digikam
    pkgs.docker-compose
    pkgs.dtrx
    pkgs.feh
    pkgs.ffmpeg-full
    pkgs.file
    pkgs.filezilla
    pkgs.font-manager
    pkgs.frei0r
    pkgs.gimp
    pkgs.git-ftp
    pkgs.gnome-mpv
    pkgs.google-chrome-dev
    pkgs.gotop
    pkgs.gparted
    pkgs.guvcview
    pkgs.htop
    pkgs.i3-gaps
    pkgs.i3blocks-gaps
    pkgs.ifuse
    pkgs.imagemagickBig
    pkgs.insomnia
    pkgs.kdeconnect
    pkgs.kdenlive
    pkgs.keepassxc
    pkgs.libreoffice-fresh
    pkgs.lm_sensors
    # pkgs.mirage
    # pkgs.minecraft
    pkgs.mpv
    pkgs.gnome3.nautilus
    pkgs.gnome3.sushi
    pkgs.neofetch
    pkgs.nnn
    pkgs.nomacs
    pkgs.ntfs3g
    pkgs.obs-studio
    pkgs.okular
    pkgs.pasystray
    pkgs.psensor
    pkgs.ranger
    pkgs.rofi
    pkgs.roxterm
    pkgs.slack
    pkgs.syncthing-tray
    pkgs.synergy
    pkgs.sxiv
    pkgs.udiskie
    pkgs.unclutter
    pkgs.unrar
    pkgs.v4l_utils
    pkgs.viber
    pkgs.vifm
    pkgs.vlc
    pkgs.wget
    pkgs.xclip
    pkgs.xorg.xev
    pkgs.youtubeDL
    pkgs.zathura
    # pkgs.zeal
    pkgs.zip
    (pkgs.callPackage ./pkgs/upwork/default.nix { })

    # Doom Emacs dependencies
    ## Required
    pkgs.ripgrep
    ## Optional
    pkgs.fd
    pkgs.clang
  ];

  home.sessionVariables = {
    EDITOR = "emacsclient -nw";
  };

  services.network-manager-applet.enable = true;

  services.flameshot.enable = true;

  services.udiskie.enable = true;

  services.unclutter.enable = true;

  services.redshift = {
    enable = true;
    tray = true;
    latitude = "15.55";
    longitude = "120.82";
    brightness = {
      day = "1.0";
      night = "1.0";
    };
    temperature = {
      day = 6500;
      night = 4000;
    };
    extraOptions = ["-m randr"];
  };

  services.syncthing.enable = true;

  systemd.user.services.synergy-daemon = {
    Unit = {
      Description = "Synergy Server Daemon";
    };
    Service = {
      ExecStart = "${pkgs.synergy}/bin/synergys --no-daemon --debug WARNING --config /home/dido/.config/synergy.conf --log /var/log/synergy.log";
      ExecStop = "/usr/bin/env pkill synergys";
      Restart = "always";
      RestartSec = 3;
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };

  systemd.user.startServices = true;

  programs.emacs = {
    enable = true;
  };

  programs.feh.enable = true;

  programs.rofi.enable = true;

  programs.ssh.enable = true;

  programs.termite = {
    enable = true;
    audibleBell = false;
    cursorShape = "block";
    cursorBlink = "off";
    allowBold = true;
    dynamicTitle = true;
    scrollOnKeystroke = true;
    scrollbackLines = 10000;
    scrollbar = "off";
    browser = "xdg-open";
    clickableUrl = true;

    backgroundColor = "#ffffff";
    foregroundColor = "#222222";
    cursorColor = "#222222";
  };

  home.file = {
    ".config/i3".source = ~/dots/i3;

    ".config/synergy.conf".text = ''
      section: screens
        tattletale:
        bitch:
      end

      section: links
        tattletale:
          right = bitch
        bitch:
          left = tattletale
      end
    '';
  };

  programs.home-manager = {
    enable = true;
    path = https://github.com/rycee/home-manager/archive/release-19.03.tar.gz;
  };
}
