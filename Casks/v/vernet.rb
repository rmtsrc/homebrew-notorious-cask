cask "vernet" do
  version "1.5.0+78"
  sha256 "103572a30f38593cf73dd8f40c88048b01a89b4d25f502d3166e5d0921c7abc8"

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
