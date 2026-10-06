#!/usr/bin/env bash
# Assert citation text and compile the multi-page/multi-file regression fixtures.
set -euo pipefail
cd "$(dirname "$0")/.."
out=$(mktemp -d)
trap 'rm -rf "$out"' EXIT
for fixture in cite cite-parts cite-styles cite-page-function; do
  if ! typst compile "tests/$fixture.typ" "$out/$fixture.pdf" --root . 2>"$out/$fixture.err"; then
    cat "$out/$fixture.err"
    exit 1
  fi
  if [ -s "$out/$fixture.err" ]; then
    cat "$out/$fixture.err"
    exit 1
  fi
  pdftotext -layout "$out/$fixture.pdf" "$out/$fixture.txt"
done
python3 - "$out" <<'PY'
from pathlib import Path
import re, sys, subprocess
out = Path(sys.argv[1])
expected = {
    'contextual-page': 'Exercise 1 (p. 1-1)',
    'forward': 'Exercice 2.1 (p. 4)',
    'back': 'Exercice 1.2 (p. 3)',
    'nopage': 'Exercice 1.1',
    'noprefix': '1.2',
    'hidden': 'Exercice ?? (p. ??)',
    'unknown': 'Exercice ?? (p. ??)',
    'wrong-topic': 'Exercice ?? (p. ??)',
    'repeat': 'Problem 7.1',
    'occurrence': 'Problem 7.1',
    'original': 'Exercice 1.1',
    'direct': 'Exercice 2.1',
    'roman': 'Problem 7.2 (p. iv)',
    'filter': 'Problem 2',
    'missing-label': 'Problem ?? (p. ??)',
    'missing-occurrence': 'Problem ?? (p. ??)',
    'solution-only': 'Problem ?? (p. ??)',
    'forward-part': 'Exercice 1.1 (p. 2, Livre B)',
    'back-part': 'Exercice 1.1 (p. 1, Partie I)',
    'part-only': 'Exercice 1.1 (Livre B)',
    'custom-part': '1.1 (volume I)',
}
found = {}
for path in out.glob('*.txt'):
    for name, value in re.findall(r'CHK-([a-z-]+): ([^\n\r]+)', path.read_text()):
        found[name] = value.strip()
for name, value in expected.items():
    assert found.get(name) == value, f'{name}: expected {value!r}, got {found.get(name)!r}'
    print(f'ok  {name}: {value}')
PY

# Inspect final link destinations after layout; in-document link queries would
# add a dependency pass on top of the citation's own forward reference.
python3 - <<'PYLINK'
import subprocess, json
expr = """{
  let anchors = query(<_exb-reference>)
  let first(id) = anchors.find(it => it.value.id == id).location()
  let second-a = anchors.filter(it => it.value.id == "a").at(1).location()
  let expected = (first("later"), first("b"), first("a"), first("b"),
    second-a, second-a, first("a"), first("later"), first("roman-page"), anchors.filter(it => it.value.id == "roman-page").at(1).location())
  query(link).map(it => it.dest) == expected
}"""
r = subprocess.run(['typst', 'eval', expr, '--in', 'tests/cite.typ', '--root', '.'],
                   check=True, capture_output=True, text=True)
assert not r.stderr, r.stderr
assert json.loads(r.stdout) is True, 'Wrong citation link destinations'
print('ok  links target individual headers; unknown/hidden targets have no link')
PYLINK
