cask "mpv-app" do
  arch arm: "arm", intel: "intel"

  version "0.42.0"

  on_sequoia do
    sha256 arm:   "be1b8d2445e6880860869c080b8710dee189721f1fa4689840db6a2c10d7be69",
           intel: "2d2f34350ff844b6014c35f21ca142937275e19c0c673150a8564fcd2f3bfa14"

    url "https://github.com/mpv-player/mpv/releases/download/v#{version}/mpv-v#{version}-macos-15-#{arch}.zip"
  end
  on_tahoe do
    sha256 arm:   "81bffbda01d69eec566ee3f576a2d0089447ba4b21dece3954f08109d5435ce1",
           intel: "2d2f34350ff844b6014c35f21ca142937275e19c0c673150a8564fcd2f3bfa14"

    url "https://github.com/mpv-player/mpv/releases/download/v#{version}/mpv-v#{version}-macos-#{(arch == "arm") ? 26 : 15}-#{arch}.zip"
  end
  on_golden_gate :or_newer do
    sha256 "87c7af5d908eb85217899b57d9a24cc9f5316daa93bb6b4a494a34cea25330b7"

    url "https://github.com/mpv-player/mpv/releases/download/v#{version}/mpv-v#{version}-macos-27-arm.zip"

    depends_on arch: :arm64
  end

  name "mpv"
  desc "Media player based on MPlayer and mplayer2"
  homepage "https://mpv.io/"

  livecheck do
    url "https://github.com/mpv-player/mpv"
    strategy :github_latest
  end

  conflicts_with cask: ["mpv-macwrapper", "mpv-official", "stolendata-mpv"]
  depends_on macos: :sequoia
  container nested: "mpv.tar.gz"

  app "mpv.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{appdir}}/mpv.app"]
  end

  zap trash: [
    "~/.config/mpv",
    "~/Library/Logs/mpv.log",
    "~/Library/Preferences/io.mpv.plist",
    "~/Library/Preferences/mpv.plist",
  ]

  caveats do
    <<~EOS
      This cask will remove the quarantine attribute from the installed application by running:
        xattr -r -d com.apple.quarantine "#{appdir}/mpv.app"
    EOS
  end
end
