cask "wallpaper-a-day" do
  version "0.3.2"
  sha256 "48fe3b32ac9a752ebcb69788be047e26bafdd15486c78a7e2bec961eff60d1b7"

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
