cask "vernet" do
  version "1.4.20+77"
  sha256 "e5e98c7ec8db5c55d5280ef3166bebdcb491d78b8308d3672b3717aeaf22a459"

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
