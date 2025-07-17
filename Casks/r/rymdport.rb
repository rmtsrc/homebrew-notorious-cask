cask "rymdport" do
  version "3.9.0"
  sha256 "20294e531c533d8702c9f9f3aa39426290aa62634c0a5c36541bcf3620570a85"

  url "https://github.com/Jacalz/rymdport/releases/download/v#{version}/rymdport-v#{version}-macOS-arm64.zip"
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
