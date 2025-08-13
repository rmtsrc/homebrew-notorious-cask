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

  zap trash: [
    "~/Library/Application Support/InputLeap",
    "~/Library/Saved Application State/InputLeap.savedState",
  ]
end
