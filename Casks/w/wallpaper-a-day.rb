cask "wallpaper-a-day" do
  version "0.2.5"
  sha256 "48151e907a2ce0f19645b59235eaccfa368af8ff7d09e20fa913cdaec6f773d1"

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
