# unxsist/homebrew-tap

Homebrew tap for [JET Pilot](https://www.jet-pilot.app), the open-source Kubernetes IDE.

```bash
brew install --cask unxsist/tap/jet-pilot
```

JET Pilot is free and open source and isn't notarized by Apple, so
Homebrew's main cask repository no longer carries it for macOS. This
tap's cask removes the macOS quarantine flag after installing, so the
app opens normally; it keeps itself up to date afterwards.

Installed it from `homebrew/cask` before? Switch once (your settings are kept):

```bash
brew uninstall --cask jet-pilot
brew install --cask unxsist/tap/jet-pilot
```

The cask is bumped automatically by
[JET Pilot's release workflow](https://github.com/unxsist/jet-pilot/blob/main/.github/workflows/release.yml).
