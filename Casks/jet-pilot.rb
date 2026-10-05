cask "jet-pilot" do
  arch arm:   "aarch64",
       intel: on_system_conditional(macos: "x64", linux: "amd64")
  os macos: "dmg", linux: "AppImage"

  # Bumped automatically by unxsist/jet-pilot's release workflow.
  version "1.38.1"
  sha256 arm:          "134c7bb1f024a64455d65be8982b3cf7516a61f3b2abdf3d9953120534ef8307",
         intel:        "b3c7e9a7916c3eda22a8a81568d45f149c96ad897e081463f134afdbd2b03a22",
         arm64_linux:  "553749042422402f70101553f3d61c66219f313545dadeb53afb31982ecb0dfa",
         x86_64_linux: "de8d6ea3d94a9217f479d98a5c81d3b5ff8aaf1d365cab173ebdbf9f1bbad5fb"

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
