cask "jet-pilot" do
  arch arm:   "aarch64",
       intel: on_system_conditional(macos: "x64", linux: "amd64")
  os macos: "dmg", linux: "AppImage"

  # Bumped automatically by unxsist/jet-pilot's release workflow.
  version "1.38.0"
  sha256 arm:          "c2ba6ae1542761838aa8f3a37a9c828af1398f44d40bbcfdd3bce256ccdafe73",
         intel:        "bca755141e462153ffb1bfcf77651c2d8320986d592cbbad27c8dc57b3a430c0",
         arm64_linux:  "29127c7a998cb3863ddb307ce7f5a96247bb2bbf989bec78b7bba521ba044291",
         x86_64_linux: "c9d1203cbe11d3381c7f706d9b89015e42239ae9c30ea64d6f4e471eede28e3f"

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
    postflight do
      system_command "/usr/bin/xattr",
                     args:         ["-dr", "com.apple.quarantine", "#{appdir}/JET Pilot.app"],
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
