#!/usr/bin/env bash
# With qr-position: "tasks" the code is an overlay of zero flow height. Text an
# exercise places before its #tasks call, and a body that has no tasks call at
# all, must still keep clear of it. The fixture puts a solid black square where
# the code goes, so its edges are exact, and the check measures how close the
# text comes to the left edge of that square.
set -euo pipefail
cd "$(dirname "$0")/.."

if ! python3 -c "import PIL" 2>/dev/null; then
  echo "skip  qr-overlay (python3 Pillow absent)"
  exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
typst compile tests/qr-overlay-narrow.typ "$tmp/p-{p}.png" --root . --ppi 200

python3 - "$tmp" <<'PY'
import glob, sys
from PIL import Image

status = 0
for page in sorted(glob.glob(sys.argv[1] + "/p-*.png")):
    im = Image.open(page).convert("L")
    w, h = im.size
    px = im.load()

    black_cols = [x for x in range(w) if sum(1 for y in range(h) if px[x, y] < 40) > 40]
    if not black_cols:
        print("FAIL  %s : bloc QR introuvable" % page.split("/")[-1])
        status = 1
        continue
    left, right = min(black_cols), max(black_cols)
    black_rows = [y for y in range(h)
                  if sum(1 for x in range(left, right + 1) if px[x, y] < 40) > 40]
    top, bottom = min(black_rows), max(black_rows)

    gap = None
    for y in range(top, bottom + 1):
        # skip the few antialiased pixels along the square's own edge
        ink = [x for x in range(max(0, left - 300), left - 3) if px[x, y] < 128]
        if ink:
            d = left - max(ink)
            if gap is None or d < gap:
                gap = d

    name = page.split("/")[-1]
    if gap is None:
        print("ok    %s : aucun texte a hauteur du QR" % name)
    elif gap >= 10:
        print("ok    %s : le texte s'arrete %d px avant le QR" % (name, gap))
    else:
        print("FAIL  %s : le texte touche le QR (%d px)" % (name, gap))
        status = 1
raise SystemExit(status)
PY
