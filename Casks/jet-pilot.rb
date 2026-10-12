cask "jet-pilot" do
  arch arm:   "aarch64",
       intel: on_system_conditional(macos: "x64", linux: "amd64")
  os macos: "dmg", linux: "AppImage"

  # Bumped automatically by unxsist/jet-pilot's release workflow.
  version "2.1.0"
  sha256 arm:          "f3dcc0a9beda7b562ddc3e6e40dba1c5f2b9dd6758b719c56c32b7cf16581d76",
         intel:        "cc9c683b8e5f5eee7ab306696fb09fd5cd6ec73b712e3c52dc6dba3a65a69a5b",
         arm64_linux:  "695d77ce95ddee9b2c3e93fac9cdcc5683f26770734f7d6a5b0c8c4f4ad67119",
         x86_64_linux: "074b434e2a22c7f9db1e5bf43e5f65b834a068bda9a292e97e44f4c5775201ab"

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
