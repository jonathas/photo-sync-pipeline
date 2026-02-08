on run argv
  if (count of argv) is 0 then
    error "Missing album name"
  end if
  set targetAlbumName to item 1 of argv

  tell application "Photos"
  if not (exists album targetAlbumName) then
    error "Album not found: " & targetAlbumName
  end if
  delete album targetAlbumName
  make new album named targetAlbumName
  end tell
end run
