// typst compile --root . tests/underline-spacing.typ /tmp/underline-spacing.pdf
#import "../lib.typ": *
#set page(width: 300pt, height: 400pt, margin: 20pt)
#set text(size: 11pt)

// Old default geometry, retained here as the visual/measurement reference.
#let legacy(label, number, body, font-size) = block(width: 100%)[
  #text(weight: "bold", size: font-size + 1pt)[#label~#number]
  #v(-0.3em)
  #line(length: 100%, stroke: 0.8pt)
  #v(0.5em)
  #body
]
#context {
  for size in (9pt, 11pt, 14pt) {
    for label-size in (10pt, 12pt) {
      let old = measure({ set text(size: size); set par(spacing: 1.2em)
        legacy([Exercise], 1, [Body first line.], label-size) }, width: 260pt).height
      for spacing in (0pt, 1.2em, 3em) {
        let current = measure({ set text(size: size); set par(spacing: spacing)
          style-underline([Exercise], 1, [Body first line.], label-size, black, false) }, width: 260pt).height
        assert(calc.abs(old - current) < 0.001pt, message: repr((size, label-size, spacing, old, current)))
      }
    }
  }
}

// Pixel comparison: pages 1 and 2 must be identical.
#legacy([Exercise], 1, [Body first line.], 12pt)
#pagebreak()
#style-underline([Exercise], 1, [Body first line.], 12pt, black, false)
#pagebreak()

// New controls have priority over the general controls; none leaves them alone.
#exo-setup(badge-style: "underline", label-font-size: 11pt,
  underline-gap: 0.2em, underline-below: 0.78em + 0.4pt,
  header-rule-gap: 4em, header-body-gap: 4em)
#exo-setup(underline-gap: none, underline-below: none)
#context {
  let cfg = exo-config.get()
  assert.eq(cfg.underline-gap, 0.2em)
  assert.eq(cfg.underline-below, 0.78em + 0.4pt)
}
#exo(exercise: [Exercise body.], solution: [Solution body.])
#exo-correction-box(number: 1)[Correction body.]
#exo-setup(display: "sol")
#exo(exercise: [Hidden.], solution: [Solution only.])
#exo-setup(corr-display: "correction")
#exo(exercise: [Hidden.], correction: [Correction only.])

// The paragraph spacing INSIDE the body must still be inherited.
#context {
  let height(spacing) = measure({
    set par(spacing: spacing)
    style-underline([Exercise], 1, [First paragraph.

Second paragraph.], 11pt, black, false, gaps: (rule: 0.2em, body: 0.78em))
  }, width: 260pt).height
  assert(calc.abs(height(3em) - height(1em) - 22pt) < 0.001pt)
}

#pagebreak()
// Dedicated MathALÉA geometry, for the raster check (all ink in black).
#style-underline([Exercise], 1, [Body first line.], 11pt, black, false,
  gaps: (rule: 0.2em, body: 0.78em + 0.4pt))

#pagebreak()
// Measure the actual exo-box paths, including deferred and solution-only modes.
#let marker(id, role) = metadata((gap-test: id, role: role))
#let body(id) = [#marker(id, "body")Body first line.]
#for mode in ("ex", "sol", "corr", "direct-sol", "direct-corr", "deferred-sol", "deferred-corr") {
  let ex-id = mode + "-ex"
  let sol-id = mode + "-sol"
  exo-setup(
    display: if mode in ("sol", "corr") { "sol" } else if mode == "ex" { "ex" } else { "both" },
    corr-display: if mode in ("corr", "deferred-corr") { "correction" } else { "solution" },
    corr-loc: if mode in ("deferred-sol", "deferred-corr") { "end-section" } else { "after" },
    exercise-label: [#marker(ex-id, "head")Exercise],
    solution-label: [#marker(sol-id, "head")Solution],
    correction-label: [#marker(sol-id, "head")Correction],
  )
  if mode == "direct-sol" { exo-solution-box(body(sol-id)) }
  else if mode == "direct-corr" { exo-correction-box(body(sol-id)) }
  else {
    exo(exercise: body(ex-id),
      solution: if mode not in ("corr", "deferred-corr") { body(sol-id) },
      correction: if mode in ("corr", "deferred-corr") { body(sol-id) })
  }
  if mode in ("deferred-sol", "deferred-corr") { exo-print-solutions(title: [Deferred], loc: "end-section") }
  pagebreak()
}
#context {
  let markers = query(metadata).filter(it => type(it.value) == dictionary and "gap-test" in it.value)
  let headers = markers.filter(it => it.value.role == "head")
  assert.eq(headers.len(), 9)
  for head in headers {
    let body = markers.find(it => it.value.gap-test == head.value.gap-test and it.value.role == "body")
    assert.eq(head.location().page(), body.location().page())
    let top-distance = body.location().position().y - head.location().position().y
    let expected = (0.2em + 0.78em + 0.4pt).to-absolute() + measure(text(size: 12pt, weight: "bold")[Exercise 1]).height
    assert(calc.abs(top-distance - expected) < 0.001pt, message: "Underline controls did not reach " + head.value.gap-test)
  }
}
