cask "rymdport" do
  version "3.9.1"
  sha256 "f1a492e9b024a6dd68fdc2a909965f40dc898b66b07b4de5be5204e83bac9a08"

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
