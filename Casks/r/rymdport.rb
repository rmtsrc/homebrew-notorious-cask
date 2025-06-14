cask "rymdport" do
  version "3.8.0"
  sha256 "adfb355f8940486faa3a169c663fec7bbdb97ea5dd0a6c9cdcd16bff0d3a8470"

  url "https://github.com/Jacalz/rymdport/releases/download/v#{version}/rymdport-v#{version}-darwin-arm64.zip"
  name "Rymdport"
  desc "Cross-platform application for easy encrypted file, folder, and text sharing between devices"
  homepage "https://github.com/Jacalz/rymdport"

  depends_on macos: ">= :catalina"

  app "Rymdport.app"

  # No zap stanza required

  caveats do
    <<~EOS
      Requires installation using the --no-quarantine parameter
    EOS
  end
end
