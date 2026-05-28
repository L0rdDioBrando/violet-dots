{ ... }:

{
  # Default Applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Zathura
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "application/x-pdf" = [ "org.pwmt.zathura.desktop" ];

      # Imv
      "image/png" = [ "imv.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];
      "image/webp" = [ "imv.desktop" ];
      "image/tiff" = [ "imv.desktop" ];
      "image/svg" = [ "imv.desktop" ];

      # Mpv
      "video/mp4" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/quicktime" = [ "mpv.desktop" ];
      "video/x-flv" = [ "mpv.desktop" ];
      "video/x-msvideo" = [ "mpv.desktop" ];
      "audio/mpeg" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/x-flac" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/mp4" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/ogg" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/x-wav" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/aac" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/opus" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/flac" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
    };

    associations.added = {
      "image/png" = [ "imv.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "video/mp4" = [ "mpv.desktop" ];
      "audio/mpeg" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/x-flac" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/mp4" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/ogg" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/x-wav" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/aac" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/opus" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
      "audio/flac" = [ "org.strawberrymusicplayer.strawberry.desktop" ];
    };
  };
}
