#!/usr/bin/env python3
import os
import pathlib
import sys
import uuid

if len(sys.argv) != 2:
    print("Usage: lowercase_extensions.py <path>")
    sys.exit(1)

root = pathlib.Path(sys.argv[1]).expanduser().resolve()
if not root.exists():
    print(f"Error: path does not exist: {root}")
    sys.exit(1)

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
