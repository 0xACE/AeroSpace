cask "aerospace" do # version and sha256 are updated by .github/workflows/release.yml
  version "0.20.4-Beta"
  sha256 "da9bb42cab5e29df9e12717140470dc96de4471820171f5f0d81dba9717b2947"

  url "https://github.com/0xACE/AeroSpace/releases/download/v#{version}/AeroSpace-v#{version}.zip"
  name "AeroSpace"
  desc "AeroSpace is an i3-like tiling window manager for macOS"
  homepage "https://github.com/0xACE/AeroSpace"
  conflicts_with cask: "nikitabobko/tap/aerospace"

  depends_on macos: ">= :ventura"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/AeroSpace-v#{version}/bin/aerospace"
    system "xattr", "-d", "com.apple.quarantine", "#{appdir}/AeroSpace.app"
  end

  app "AeroSpace-v#{version}/AeroSpace.app"
  binary "AeroSpace-v#{version}/bin/aerospace"

  binary "AeroSpace-v#{version}/shell-completion/zsh/_aerospace",
      target: "#{HOMEBREW_PREFIX}/share/zsh/site-functions/_aerospace"
  binary "AeroSpace-v#{version}/shell-completion/bash/aerospace",
      target: "#{HOMEBREW_PREFIX}/etc/bash_completion.d/aerospace"
  binary "AeroSpace-v#{version}/shell-completion/fish/aerospace.fish",
      target: "#{HOMEBREW_PREFIX}/share/fish/vendor_completions.d/aerospace.fish"

  Dir["#{staged_path}/AeroSpace-v#{version}/manpage/*"].each { |man| manpage man }

  uninstall quit: "bobko.AeroSpace"

  zap trash: [
    "~/Library/Application Support/AeroSpace",
    "~/Library/Preferences/bobko.AeroSpace.plist",
  ]
end
