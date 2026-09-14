cask "lan-mouse" do
  version "0.11.0"
  sha256 "5ff9965d05be7f125b1d75b9e7259d874ec98aa086ce40012522bc25406500a9"

  url "https://github.com/feschber/lan-mouse/releases/download/v#{version}/lan-mouse-macos-arm64.zip"
  name "Lan Mouse"
  desc "Mouse & keyboard sharing via LAN"
  homepage "https://github.com/feschber/lan-mouse"

  depends_on macos: :catalina

  app "Lan Mouse.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{appdir}}/Lan Mouse.app"]
  end

  caveats do
    <<~EOS
      This cask will remove the quarantine attribute from the installed application by running:
        xattr -r -d com.apple.quarantine "#{appdir}/Lan Mouse.app"
    EOS
  end

  zap trash: [
    "~/.config/lan-mouse",
    "~/Library/Preferences/de.feschber.LanMouse.plist",
  ]
end
