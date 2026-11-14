cask "vernet" do
  version "1.6.2+81"
  sha256 "1c0851587335b3141e3e6a8ac569b93a734bc0bd50563a201169c3b193a1ea4a"

  url "https://github.com/osociety/vernet/releases/download/v#{version}/Vernet-v#{version}-macos.dmg"
  name "Vernet"
  desc "Network Analyzer and Monitoring Tool"
  homepage "https://osociety.github.io/vernet/"

  livecheck do
    url "https://github.com/osociety/vernet"
    strategy :github_latest
    regex(/^v?(\d+(?:\.\d+)*\+\d+)$/)
  end

  depends_on macos: :monterey

  app "vernet.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-r", "-d", "com.apple.quarantine", "{{appdir}}/vernet.app"]
  end

  zap trash: [
    "~/Library/Application Scripts/org.fsociety.vernet.vernet",
    "~/Library/Containers/org.fsociety.vernet.vernet",
  ]

  caveats do
    <<~EOS
      This cask will remove the quarantine attribute from the installed application by running:
        xattr -r -d com.apple.quarantine "#{appdir}/vernet.app"
    EOS
  end
end
