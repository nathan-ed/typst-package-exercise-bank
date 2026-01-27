// =============================================================================
// Exercise Visual Styles - Gallery
// =============================================================================
// This document showcases all available badge styles in exercise-bank.
// To use a style: #exo-setup(badge-style: "style-name")
// Compile with: typst compile docs/visual-styles.typ
// =============================================================================

#import "@preview/exercise-bank:0.3.0": *

#set page(margin: 2cm)
#set text(font: "New Computer Modern", size: 11pt)

#align(center)[
  #text(size: 18pt, weight: "bold")[Exercise Visual Styles]
  #v(0.5em)
  #text(size: 11pt, fill: gray)[Available styles in exercise-bank package]
]

#v(1em)

// Sample exercise content for demonstrations
#let sample-content = [
  Résoudre dans $RR$ pour $x$.

  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 1em,
    [a) $4m x - 8 - 11m = 3 + 2m$],
    [b) $5x - 3p = 2x - 7$],
    [c) $9r^2 x + 2r = 4x - 5$],
  )
]

// Reset counter for each style demo
#let style-demo(style-name, description) = {
  exo-counter.update(0)
  exo-setup(badge-style: style-name, badge-color: black)

  line(length: 100%, stroke: 0.5pt + gray)
  v(0.5em)
  text(size: 13pt, weight: "bold")[#style-name]
  h(1em)
  text(size: 9pt, fill: gray)[#description]
  v(0.8em)

  exo(exercise: sample-content)
}

// =============================================================================
// Badge-based Styles (badge + content grid)
// =============================================================================

#style-demo("box", "Rectangle with stroke around label + number (default)")

#v(1em)
#style-demo("circled", "Clean circled number, no text label - elegant and minimal")

#v(1em)
#style-demo("filled-circle", "Solid colored circle with white number - high contrast")

#v(1em)
#style-demo("pill", "Rounded ends like a pill - modern and friendly")

#v(1em)
#style-demo("tag", "Label tag with arrow pointer - callout style")

// =============================================================================
// Full-width Styles (wrap entire content)
// =============================================================================

#v(1em)
#style-demo("border-accent", "Vertical colored bar with inline header - document-like")

#v(1em)
#style-demo("underline", "Bold header with underline - classic textbook style")

#v(1em)
#style-demo("rounded-box", "Clean rounded border around the whole exercise")

#v(1em)
#style-demo("header-card", "Rounded box with colored header strip")

// =============================================================================
// Color Variants
// =============================================================================

#pagebreak()

#align(center)[
  #text(size: 16pt, weight: "bold")[Color Variants]
]

#v(1em)

#exo-counter.update(0)

#let colors = (
  ("Blue", rgb("#2563eb")),
  ("Green", rgb("#059669")),
  ("Orange", rgb("#d97706")),
  ("Red", rgb("#dc2626")),
  ("Purple", rgb("#7c3aed")),
)

#text(weight: "bold")[filled-circle with colors:]
#v(0.5em)

#for (idx, (name, color)) in colors.enumerate() {
  exo-setup(badge-style: "filled-circle", badge-color: color)
  exo(exercise: [Solve $x + #(idx + 1) = 10$])
}

#v(1em)
#exo-counter.update(0)

#text(weight: "bold")[header-card with colors:]
#v(0.5em)

#for (idx, (name, color)) in colors.enumerate() {
  exo-setup(badge-style: "header-card", badge-color: color)
  exo(exercise: [Solve $y - #(idx + 1) = 5$])
}

// =============================================================================
// Usage Summary
// =============================================================================

#pagebreak()

#align(center)[
  #text(size: 16pt, weight: "bold")[Usage]
]

#v(1em)

#block(
  fill: luma(97%),
  radius: 4pt,
  inset: 12pt,
  width: 100%,
)[
```typst
#import "@preview/exercise-bank:0.2.0": *

// Set your preferred style
#exo-setup(badge-style: "circled")

// Or with a custom color
#exo-setup(badge-style: "filled-circle", badge-color: rgb("#2563eb"))

// Then use exercises normally
#exo(
  exercise: [Solve $x + 2 = 5$],
  solution: [$x = 3$],
)
```
]

#v(1em)

#table(
  columns: (1fr, 2fr),
  inset: 8pt,
  stroke: 0.5pt + gray,

  [*Style*], [*Best For*],
  [`"box"`], [Traditional documents, formal contexts (default)],
  [`"circled"`], [Clean designs, worksheets, elegant documents],
  [`"filled-circle"`], [High visibility, color-coded topics],
  [`"pill"`], [Modern UIs, friendly tone],
  [`"tag"`], [Callouts, highlighted exercises],
  [`"border-accent"`], [Long exercises, document sections],
  [`"underline"`], [Textbooks, classic academic style],
  [`"rounded-box"`], [Clean worksheets, handouts],
  [`"header-card"`], [Standalone exercises, modern look],
)

#v(1em)

#block(
  fill: rgb("#e8f5e9"),
  stroke: 0.5pt + rgb("#4a7c59"),
  radius: 4pt,
  inset: 12pt,
)[
  *Tip:* The `"circled"` style provides a clean, professional look suitable for mathematics worksheets while keeping the layout compact.
]
