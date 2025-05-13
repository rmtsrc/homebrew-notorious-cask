cask "moneydance@2023" do
  version "2023.3,5064"
  sha256 :no_check

  url "https://infinitekind.com/stabledl/2023/Moneydance.dmg"
  name "Moneydance"
  desc "Personal financial management application focused on privacy"
  homepage "https://infinitekind.com/moneydance"

  livecheck do
    url "https://infinitekind.com/download_2023"
    strategy :page_match do |page|
      page.scan(/Moneydance\s*v?(\d+(?:\.\d+)*)\s*\((\d+)\)/i).map do |match|
        "#{match[0]},#{match[1]}"
      end
    end
  end

  depends_on macos: ">= :el_capitan"

  app "Moneydance.app"

  zap trash: [
    "~/Library/Application Scripts/com.infinitekind.MoneydanceOSX",
    "~/Library/Containers/com.infinitekind.MoneydanceOSX",
  ]
end
