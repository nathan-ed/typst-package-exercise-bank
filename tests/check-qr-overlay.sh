#!/usr/bin/env bash
# The sentence an exercise puts before its #tasks call must not run under the
# QR overlay. Checked on the render: the band of the QR code is scanned for
# text pixels to its left edge, inside the code's own column.
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
import sys
from PIL import Image

im = Image.open(sys.argv[1] + "/p-1.png").convert("L")
w, h = im.size
px = im.load()

# The fixture puts a solid black square where the code goes, so its edges are
# unambiguous: the black run that is at least 1 cm wide and tall.
black_cols = [x for x in range(w) if sum(1 for y in range(h) if px[x, y] < 40) > 40]
if not black_cols:
    print("FAIL  bloc QR introuvable")
    raise SystemExit(1)
left, right = min(black_cols), max(black_cols)
black_rows = [y for y in range(h) if sum(1 for x in range(left, right + 1) if px[x, y] < 40) > 40]
top, bottom = min(black_rows), max(black_rows)

# Text beside the block is fine; text running into it is not. On the rows the
# block occupies, measure how close the text comes to its left edge: laid out
# correctly it stops a clear margin short, while text sliding underneath is
# clipped hard against the edge.
gap = None
for y in range(top, bottom + 1):
    ink = [x for x in range(max(0, left - 300), left) if px[x, y] < 128]
    if ink:
        d = left - max(ink)
        if gap is None or d < gap:
            gap = d

if gap is None:
    print("ok    aucun texte a hauteur du QR")
elif gap >= 10:
    print("ok    le texte s'arrete %d px avant le QR" % gap)
else:
    print("FAIL  le texte touche le QR (%d px)" % gap)
    raise SystemExit(1)
PY
