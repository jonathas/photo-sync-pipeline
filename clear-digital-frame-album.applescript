tell application "Photos"
  set targetAlbumName to "Digital frame"
  set targetAlbum to album targetAlbumName
  set albumItems to every media item of targetAlbum

  repeat with p in albumItems
    remove p from targetAlbum
  end repeat
end tell