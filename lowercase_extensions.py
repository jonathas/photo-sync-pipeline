#!/usr/bin/env python3
import os
import pathlib
import uuid

root = pathlib.Path.home() / "Pictures" / "CameraUploads"

def same_file(a: pathlib.Path, b: pathlib.Path) -> bool:
    try:
        return os.path.samefile(a, b)
    except OSError:
        return False

count = 0
for p in root.rglob("*"):
    if not p.is_file():
        continue
    if "." not in p.name:
        continue

    ext = p.suffix
    lower_ext = ext.lower()
    if ext == lower_ext:
        continue

    target = p.with_suffix(lower_ext)

    if target.exists() and not same_file(p, target):
        print("SKIP (different file exists):", target)
        continue

    tmp = p.with_name(p.stem + f".__tmpcase__{uuid.uuid4().hex}")
    os.replace(p, tmp)
    os.replace(tmp, target)
    print("RENAMED:", p.name, "->", target.name)
    count += 1

print("DONE. Renamed:", count)

def same_file(a: pathlib.Path, b: pathlib.Path) -> bool:
    try:
        return os.path.samefile(a, b)
    except OSError:
        return False

count = 0
for p in root.rglob("*"):
    if not p.is_file():
        continue
    if "." not in p.name:
        continue

    ext = p.suffix
    lower_ext = ext.lower()
    if ext == lower_ext:
        continue

    target = p.with_suffix(lower_ext)

    if target.exists() and not same_file(p, target):
        print("SKIP (different file exists):", target)
        continue

    tmp = p.with_name(p.stem + f".__tmpcase__{uuid.uuid4().hex}")
    os.replace(p, tmp)
    os.replace(tmp, target)
    print("RENAMED:", p.name, "->", target.name)
    count += 1

print("DONE. Renamed:", count)