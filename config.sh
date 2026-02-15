# === LOCAL PATHS ===
# Always derive from this file's location so helper paths stay stable.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DIGITAL_FRAME_DIR="$HOME/Pictures/Digital Frame"
CAMERA_UPLOADS_DIR="$HOME/Pictures/Camera Uploads"

# === PHOTOS ===
DIGITAL_FRAME_ALBUM="Digital frame"

# === ANDROID / ADB ===
ANDROID_IP="192.168.0.217"
ANDROID_PORT="40821"
ANDROID_DEST="/sdcard/Pictures"

# Fotoo package name
FOTOO_PKG="com.bo.fotoo"

# === TOOLS ===
LOWERCASE_SCRIPT="$SCRIPT_DIR/helpers/lowercase-extensions"
CLEAR_ALBUM_SCRIPT="$SCRIPT_DIR/helpers/clear-digital-frame-album.applescript"

# === BACKUPS ===
SYNC_EXTERNAL_CMD="sync-external-drive"
SYNC_BACKUP_CMD="sync-backup-drives"

# === SYNC PATHS ===
SYNC_BASE_DIR="$HOME/Library/CloudStorage/Dropbox"
SYNC_EXTERNAL_DRIVE_DIR="/Volumes/Expansion"
SYNC_BACKUP_SOURCE="/Volumes/Expansion"
SYNC_BACKUP_DEST="/Volumes/WD Elements"
SYNC_LOCAL_DIRS=("Backup" "Documents" "EstelaJon" "Photos" "Videos")
