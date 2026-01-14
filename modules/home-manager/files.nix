{ ... }:
let
  # Shared Electron/Chromium flags for Wayland + fcitx5 IME
  waylandImeFlags = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
    --enable-wayland-ime
    --wayland-text-input-version=3
  '';
in {
  # Electron/Chromium apps need these flags for native Wayland IME support
  home.file.".config/chrome-flags.conf".text = waylandImeFlags;
  home.file.".config/chromium-flags.conf".text = waylandImeFlags;
  home.file.".config/microsoft-edge-stable-flags.conf".text = waylandImeFlags;
  home.file.".config/google-chrome-dev-flags.conf".text = waylandImeFlags;
  home.file.".config/teams-for-linux-flags.conf".text = waylandImeFlags;
  home.file.".config/electron-flags.conf".text = waylandImeFlags;
}
