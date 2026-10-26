cask "moneydance@2023" do
  version "2023.3,5064"
  sha256 :no_check

  url "https://infinitekind.com/stabledl/2023/Moneydance.dmg"
  name "Moneydance"
  desc "Personal financial management application focused on privacy"
  homepage "https://infinitekind.com/moneydance"

  livecheck do
    skip "Archived version, no public updates"
  end

  depends_on :macos

  app "Moneydance.app"

  zap trash: [
    "~/Library/Application Scripts/com.infinitekind.MoneydanceOSX",
    "~/Library/Containers/com.infinitekind.MoneydanceOSX",
  ]
end
