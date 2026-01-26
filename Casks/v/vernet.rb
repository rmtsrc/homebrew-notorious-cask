cask "vernet" do
  version "1.3.2+40"
  sha256 "eded32c5963fafcf43c6406084c1bcdc08bbef13c475996bccf5483af8449888"

  url "https://github.com/osociety/vernet/releases/download/v#{version}/Vernet-v#{version}-macos.dmg",
      verified: "github.com/osociety/"
  name "Vernet"
  desc "Network Analyzer and Monitoring Tool"
  homepage "https://osociety.github.io/vernet/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "vernet.app"

  caveats do
    <<~EOS
      Requires installation using the --no-quarantine parameter
    EOS
  end

  zap trash: [
    "~/Library/Application Scripts/org.fsociety.vernet.vernet",
    "~/Library/Containers/org.fsociety.vernet.vernet",
  ]
end
