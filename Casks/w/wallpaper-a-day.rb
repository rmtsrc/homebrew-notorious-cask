cask "wallpaper-a-day" do
  version "0.2.6"
  sha256 "5da3c128cc56ec5483efe8d7efdbff7dad7238664c0b19b67a0705f9eb6a450b"

  url "https://github.com/RobinNaumann/wallpaper_a_day/releases/download/v#{version}/Wallpaper.a.Day.app.zip",
      verified: "github.com/RobinNaumann/"
  name "Wallpaper a Day"
  desc "Daily wallpapers for your mac"
  homepage "https://apps.robbb.in/wallpaper_a_day"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "Wallpaper a Day.app"

  zap trash: [
    "~/Library/Application Scripts/in.robbb.wad",
    "~/Library/Containers/in.robbb.wad",
  ]
end
