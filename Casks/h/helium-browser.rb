cask "helium-browser" do
  version "0.3.7.1"
  sha256 "284f8308b02bcacf515d7e3118a122b68ccc4105a19eccc00a32e6288ff7810e"

  url "https://github.com/imputnet/helium-macos/releases/download/#{version}/helium_#{version}_arm64-macos.dmg"
  name "Helium"
  desc "Helium Browser for macOS"
  homepage "https://github.com/imputnet/helium-macos"

  auto_updates true

  app "Helium.app"

  zap trash: [
    "~/Library/Application Support/net.imput.helium",
    "~/Library/Caches/net.imput.helium",
    "~/Library/Preferences/net.imput.helium.plist",
  ]
end
