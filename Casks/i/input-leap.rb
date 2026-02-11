cask "input-leap" do
  version "3.0.3"
  sha256 "131745b9be83cbee825df6d0975d1da0c13e32ad10e11109c0f4251ac21661f4"

  url "https://github.com/input-leap/input-leap/releases/download/v#{version}/macOS-Apple_Silicon-debug-v#{version}.tar.gz"
  name "Input Leap"
  desc "Open-source KVM software"
  homepage "https://github.com/input-leap/input-leap"

  depends_on macos: ">= :catalina"
  container nested: "macOS-Apple_Silicon-debug/InputLeap-macOS-Apple_Silicon.tar.gz"

  app "InputLeap.app"

  postflight do
    system_command '/usr/bin/xattr', args: ['-r', '-d', 'com.apple.quarantine', "#{appdir}/InputLeap.app"]
  end

  caveats do
    <<~EOS
      This cask will remove the quarantine attribute from the installed application by running:
        xattr -r -d com.apple.quarantine "#{appdir}/InputLeap.app"
    EOS
  end

  zap trash: [
    "~/Library/Application Support/InputLeap",
    "~/Library/Saved Application State/InputLeap.savedState",
  ]
end
