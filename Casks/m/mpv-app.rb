cask "mpv-app" do
  version "0.41.0"

  base_url = "https://github.com/mpv-player/mpv/releases/download/v#{version}/mpv-v#{version}-macos"

  on_arm do
    on_sonoma :or_older do
      sha256 "5c96f9b21355fc0a11d2e2161ad65f33031070e9fb3f6bd9865fb459b94587e6"
      url "#{base_url}-14-arm.zip"
    end
    on_sequoia do
      sha256 "489cf6a54f57c54f86ad8d7cedaf5bb26848770d58dc059021214e2f689ee799"
      url "#{base_url}-15-arm.zip"
    end
    on_tahoe :or_newer do
      sha256 "09820c0d84f6687446b84eb9df81fcf6a26ebe869cee58ea1857d7948cfb7c71"
      url "#{base_url}-26-arm.zip"
    end
  end
  on_intel do
    on_sequoia :or_newer do
      sha256 "41003617ab4f7784394b5ddea7ce51b3e0838e8cfc8166ad1a378b2eda3b583c"
      url "#{base_url}-15-intel.zip"
    end
  end

  name "mpv"
  desc "Media player based on MPlayer and mplayer2"
  homepage "https://mpv.io/"

  livecheck do
    url "https://github.com/mpv-player/mpv"
    strategy :github_latest
  end

  conflicts_with cask: ["mpv-macwrapper", "mpv-official", "stolendata-mpv"]
  depends_on :macos
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
