#!/usr/bin/env bash
# Verify spacing, pagination, and exact default raster compatibility.
set -euo pipefail
cd "$(dirname "$0")/.."
out=$(mktemp -d)
trap 'rm -rf "$out"' EXIT
typst compile tests/underline-spacing.typ "$out/spacing-{p}.png" --root . --ppi 288
typst compile tests/fullwidth-sticky.typ "$out/sticky.pdf" --root .
python3 - "$out" <<'PY'
from pathlib import Path
import sys
from PIL import Image, ImageChops
out = Path(sys.argv[1])
a = Image.open(out / 'spacing-1.png').convert('RGB')
b = Image.open(out / 'spacing-2.png').convert('RGB')
assert ImageChops.difference(a, b).getbbox() is None, 'Default raster changed'
# MathALÉA: the lower edge of the 0.8pt rule to the first capitals in the body.
im = Image.open(out / 'spacing-4.png').convert('L')
rows = [y for y in range(im.height) if im.crop((80, y, im.width - 80, y + 1)).getextrema()[0] < 80]
groups = []
for y in rows:
    if not groups or y > groups[-1][-1] + 1:
        groups.append([])
    groups[-1].append(y)
assert len(groups) == 3, f'Expected title, rule and body; found {len(groups)} ink bands'
blank_pt = (groups[2][0] - groups[1][-1] - 1) / 4
assert abs(blank_pt - 0.78 * 11) < 0.5, f'Unexpected white space below rule: {blank_pt}pt'
print(f'ok  exact default raster; MathALÉA white space below rule: {blank_pt:.2f}pt')
print('ok  paragraph-spacing measurements; page/column stickiness; breakable long bodies')
PY
