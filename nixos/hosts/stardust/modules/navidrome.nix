{ ... }:

{
  services.navidrome = {
    enable = true;
    settings = {
      Address = "0.0.0.0";
      Port = 4533;
      MusicFolder = "/navidrome/music/";
      DataFolder = "/navidrome/";
      ScanSchedule = "@every 1m";
    };
  };

}
