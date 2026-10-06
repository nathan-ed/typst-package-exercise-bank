// Sweep page and column boundaries, automatic and explicit gaps, all box paths.
// typst compile --root . tests/fullwidth-sticky.typ /tmp/fullwidth-sticky.pdf
#import "../lib.typ": *
#import "@preview/taskize:0.2.9": tasks
#set page(width: 300pt, height: 180pt, margin: 10pt)
#set text(size: 11pt)
#let mark(id, kind) = metadata((id: id, kind: kind))
#let statement(id) = [#mark(id, "first")Ligne 1 \ Ligne 2 \ Ligne 3 \ Ligne 4]
#let render(style, mode, offset, explicit, column: false, long: false) = {
  let id = repr((style, mode, offset, explicit, column, long))
  exo-setup(badge-style: style,
    exercise-label: [#mark(id, "header")Exercise],
    solution-label: [#mark(id, "header")Solution],
    correction-label: [#mark(id, "header")Correction],
    display: if mode in ("sol", "corr") { "sol" } else { "ex" },
    corr-display: if mode == "corr" { "correction" } else { "solution" },
    header-rule-gap: if explicit { 0.2em } else { auto },
    header-body-gap: if explicit { 0.5em } else { auto },
  )
  let body = if mode == "task-ex" {
    tasks(columns: 1)[
      + #mark(id, "first")Première question.
      + Deuxième question.
      + Troisième question.
      + Quatrième question.
    ]
  } else if long {
    [#mark(id, "first")First line. #for i in range(30) [\ More lines.] #mark(id, "last")]
  } else { statement(id) }
  let item = {
    if mode == "direct-sol" { exo-solution-box(body) }
    else if mode == "direct-corr" { exo-correction-box(body) }
    else {
      exo(
        title: if mode == "wrapped-ex" {
          [Un titre assez long pour occuper plusieurs lignes et tester la liaison avec le début de l’énoncé.]
        },
        exercise: body,
        solution: if mode == "sol" { body },
        correction: if mode == "corr" { body },
      )
    }
  }
  let content = [#v(offset * 1pt) #item]
  if column { columns(2, gutter: 10pt, content) } else { content }
  pagebreak()
}
#for style in ("underline", "border-accent", "rounded-box", "header-card") {
  for explicit in (false, true) {
    for mode in ("ex", "sol", "corr", "direct-sol", "direct-corr", "task-ex", "wrapped-ex") {
      for offset in (85, 100, 115, 130) {
        render(style, mode, offset, explicit)
      }
    }
    render(style, "ex", 115, explicit, column: true)
    render(style, "task-ex", 115, explicit, column: true)
    render(style, "ex", 115, explicit, long: true)
  }
}
#context {
  let markers = query(metadata).filter(it => type(it.value) == dictionary and "kind" in it.value)
  let headers = markers.filter(it => it.value.kind == "header")
  assert.eq(headers.len(), 248)
  for head in headers {
    let first = markers.find(it => it.value.id == head.value.id and it.value.kind == "first")
    assert.eq(head.location().page(), first.location().page(), message: "Orphaned header: " + head.value.id)
    // In columns, page equality alone would miss an orphaned column header.
    // Allow the task label gutter, but less than the 145pt column stride.
    assert(calc.abs(head.location().position().x - first.location().position().x) < 90pt,
      message: "Header and first line occupy different columns")
    let last = markers.find(it => it.value.id == head.value.id and it.value.kind == "last")
    if last != none { assert(last.location().page() > first.location().page(), message: "Long body stopped breaking across pages") }
  }
}
