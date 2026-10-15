cask "jet-pilot" do
  arch arm:   "aarch64",
       intel: on_system_conditional(macos: "x64", linux: "amd64")
  os macos: "dmg", linux: "AppImage"

  # Bumped automatically by unxsist/jet-pilot's release workflow.
  version "2.2.2"
  sha256 arm:          "b138ff8125380ace508a06dfe530268492fbabe0d75e5db4830c8bea29457193",
         intel:        "4f02442c6757a41c5cacdc63c1f2aee699d184bbaf132a32ef90b0e3fd42d9c7",
         arm64_linux:  "23d6e7a67251828512beadc5dc2fe17470515a73349616f92fe65f07fc81e154",
         x86_64_linux: "1a15c6f43b585b4a96dc5da44444d31d3c216bdbdf16f3836a6324191870c7ee"

  url "https://github.com/unxsist/jet-pilot/releases/download/v#{version}/JET.Pilot_#{version}_#{arch}.#{os}"
  name "JET Pilot"
  desc "Open-source Kubernetes IDE"
  homepage "https://www.jet-pilot.app/"

  livecheck do
    url "https://updates.jet-pilot.app/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true

  on_macos do
    app "JET Pilot.app"

    # JET Pilot is free and open source and not notarized by Apple, so
    # Gatekeeper would refuse to open the quarantined download ("is damaged
    # and can't be opened"). Clear the quarantine flag on the installed app.
    postflight_steps do
      run "/usr/bin/xattr",
          args:         ["-dr", "com.apple.quarantine", "{{appdir}}/JET Pilot.app"],
          must_succeed: false
    end

    zap trash: [
      "~/Library/Application Support/com.unxsist.jetpilot",
      "~/Library/Caches/com.unxsist.jetpilot",
      "~/Library/WebKit/com.unxsist.jetpilot",
    ]
  end

  on_linux do
    app_image "JET.Pilot_#{version}_#{arch}.AppImage", target: "JET Pilot.AppImage"
  end
end
