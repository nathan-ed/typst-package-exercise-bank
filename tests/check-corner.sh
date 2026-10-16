#!/usr/bin/env bash
# exo-corner: nothing may be drawn beside or under the corner. The fixture puts
# a solid black square where the corner goes; the check looks for ink in the
# band of rows the square spans, between the left edge of the page body and
# the square, closer to the square than the gap exo-corner keeps (8pt).
set -euo pipefail
cd "$(dirname "$0")/.."

if ! python3 -c "import PIL" 2>/dev/null; then
  echo "skip  corner (python3 Pillow absent)"
  exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
typst compile tests/corner.typ "$tmp/p-{0p}.png" --root . --ppi 144

python3 - "$tmp" <<'PY'
import glob, sys
from PIL import Image

PPI = 144
min_gap = round(6 / 72 * PPI)  # 8pt asked, a little slack for antialiasing
status = 0
for page in sorted(glob.glob(sys.argv[1] + "/p-*.png")):
    name = page.split("/")[-1]
    im = Image.open(page).convert("L")
    w, h = im.size
    px = im.load()
    # the square: the first block of rows that each hold a dark run 1.8cm
    # wide (a left bar or a frame edge is narrower, a header-card strip is
    # wider, and neither is that tall)
    side = 1.8 / 2.54 * PPI
    def square_run(y):
        x = 0
        while x < w:
            if px[x, y] < 20:
                s = x
                while x < w and px[x, y] < 20: x += 1
                if abs(x - s - side) < 0.1 * side: return (s, x - 1)
            x += 1
        return None
    found = None
    for y in range(h):
        r = square_run(y)
        if r is None: continue
        y2 = y
        while y2 + 1 < h and square_run(y2 + 1) == r: y2 += 1
        if abs(y2 - y + 1 - side) < 0.1 * side:
            found = (r[0], r[1], y, y2); break
    if found is None:
        print("FAIL  %s : carré introuvable" % name); status = 1; continue
    left, right, top, bottom = found
    # ink beside the square (same rows, left of it) or right under it
    beside = [x for y in range(top, bottom + 1) for x in range(left - min_gap, left) if px[x, y] < 200]
    under = [y for y in range(bottom + 1, bottom + min_gap) for x in range(left, right + 1) if px[x, y] < 200]
    if beside or under:
        print("FAIL  %s : encre à moins de 8pt du coin (%d px à gauche, %d px dessous)"
              % (name, len(beside), len(under)))
        status = 1
    else:
        print("ok    %s" % name)
sys.exit(status)
PY
