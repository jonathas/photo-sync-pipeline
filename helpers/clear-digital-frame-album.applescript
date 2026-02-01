on run argv
  if (count of argv) is 0 then
    error "Missing album name"
  end if
  set targetAlbumName to item 1 of argv

  tell application "Photos"
  if not (exists album targetAlbumName) then
    error "Album not found: " & targetAlbumName
  end if
  set targetAlbum to album targetAlbumName
  set albumItems to every media item of targetAlbum

  repeat with p in albumItems
    remove p from targetAlbum
  end repeat
  end tell
end run
