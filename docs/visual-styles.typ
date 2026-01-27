// =============================================================================
// Exercise Visual Styles - Design Proposals
// =============================================================================
// This document presents different visual styles for exercise numbering/display.
// Compile with: typst compile docs/visual-styles.typ
// =============================================================================

#set page(margin: 2cm)
#set text(font: "New Computer Modern", size: 11pt)

#align(center)[
  #text(size: 18pt, weight: "bold")[Exercise Visual Styles]
  #v(0.5em)
  #text(size: 11pt, fill: gray)[Design proposals for exercise-bank package]
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

// =============================================================================
// Style 1: Current Box Style (Reference)
// =============================================================================

#line(length: 100%, stroke: 0.5pt + gray)
#v(0.5em)
== Style 1: Box Badge (Current)
#v(0.3em)
#text(size: 9pt, fill: gray)[Rectangle with stroke around label + number]

#v(0.8em)
#let box-badge(number) = box(
  stroke: 0.8pt,
  fill: white,
  inset: (x: 4pt, y: 3pt),
  text(weight: "bold", size: 11pt)[Exercice #number],
)

#grid(
  columns: (3cm, 1fr),
  column-gutter: 8pt,
  align(right)[#box-badge(1)],
  sample-content,
)

// =============================================================================
// Style 2: Circled Number (Minimal)
// =============================================================================

#v(1.5em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(0.5em)
== Style 2: Circled Number
#v(0.3em)
#text(size: 9pt, fill: gray)[Clean circled number, no text label - elegant and minimal]

#v(0.8em)
#let circled-number(number, size: 22pt) = {
  let circle-stroke = 1.2pt + black
  box(
    width: size,
    height: size,
    stroke: circle-stroke,
    radius: 50%,
    align(center + horizon)[
      #text(weight: "bold", size: size * 0.5)[#number]
    ]
  )
}

#grid(
  columns: (3cm, 1fr),
  column-gutter: 8pt,
  align(right)[#circled-number(1)],
  sample-content,
)

// =============================================================================
// Style 3: Filled Circle
// =============================================================================

#v(1.5em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(0.5em)
== Style 3: Filled Circle
#v(0.3em)
#text(size: 9pt, fill: gray)[Solid colored circle with white number - high contrast]

#v(0.8em)
#let filled-circle(number, size: 22pt, color: rgb("#2563eb")) = {
  box(
    width: size,
    height: size,
    fill: color,
    radius: 50%,
    align(center + horizon)[
      #text(weight: "bold", size: size * 0.5, fill: white)[#number]
    ]
  )
}

#grid(
  columns: (3cm, 1fr),
  column-gutter: 8pt,
  align(right)[#filled-circle(1)],
  sample-content,
)

#v(0.5em)
#text(size: 9pt, style: "italic")[Color variants:]
#h(1em)
#filled-circle(1, color: rgb("#2563eb"))
#h(0.5em)
#filled-circle(2, color: rgb("#059669"))
#h(0.5em)
#filled-circle(3, color: rgb("#d97706"))
#h(0.5em)
#filled-circle(4, color: rgb("#dc2626"))
#h(0.5em)
#filled-circle(5, color: rgb("#7c3aed"))

// =============================================================================
// Style 4: Pill / Rounded Badge
// =============================================================================

#v(1.5em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(0.5em)
== Style 4: Pill Badge
#v(0.3em)
#text(size: 9pt, fill: gray)[Rounded ends like a pill - modern and friendly]

#v(0.8em)
#let pill-badge(number, label: "Exercice") = box(
  stroke: 0.8pt + rgb("#374151"),
  fill: rgb("#f3f4f6"),
  radius: 12pt,
  inset: (x: 10pt, y: 4pt),
  text(weight: "medium", size: 10pt, fill: rgb("#374151"))[#label #number],
)

#grid(
  columns: (3cm, 1fr),
  column-gutter: 8pt,
  align(right)[#pill-badge(1)],
  sample-content,
)

// =============================================================================
// Style 5: Left Border Accent
// =============================================================================

#v(1.5em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(0.5em)
== Style 5: Left Border Accent
#v(0.3em)
#text(size: 9pt, fill: gray)[Vertical colored bar with inline header - document-like]

#v(0.8em)
#let border-accent(number, label: "Exercice", color: rgb("#3b82f6")) = {
  block(
    stroke: (left: 3pt + color),
    inset: (left: 12pt, y: 8pt),
    width: 100%,
  )[
    #text(weight: "bold", size: 11pt, fill: color)[#label #number]
    #v(0.3em)
    #sample-content
  ]
}

#border-accent(1)

// =============================================================================
// Style 6: Underline Header
// =============================================================================

#v(1.5em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(0.5em)
== Style 6: Underline Header
#v(0.3em)
#text(size: 9pt, fill: gray)[Bold header with underline - classic textbook style]

#v(0.8em)
#let underline-header(number, label: "Exercice") = {
  block(width: 100%)[
    #text(weight: "bold", size: 12pt)[#label #number]
    #v(-0.3em)
    #line(length: 100%, stroke: 0.8pt)
    #v(0.5em)
    #sample-content
  ]
}

#underline-header(1)

// =============================================================================
// Style 7: Tag / Label Style
// =============================================================================

#v(1.5em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(0.5em)
== Style 7: Tag Style
#v(0.3em)
#text(size: 9pt, fill: gray)[Label tag with arrow pointer - callout style]

#v(0.8em)
#let tag-style(number, label: "Ex.", color: rgb("#1e40af")) = {
  let tag = box(
    fill: color,
    radius: (left: 3pt, right: 0pt),
    inset: (x: 8pt, y: 4pt),
  )[
    #text(weight: "bold", size: 10pt, fill: white)[#label #number]
  ]

  // Arrow/pointer using polygon
  let arrow = box(
    width: 8pt,
    height: 100%,
    move(dy: 0pt)[
      #polygon(
        fill: color,
        (0pt, 0pt),
        (8pt, 10pt),
        (0pt, 20pt),
      )
    ]
  )

  box[#tag#arrow]
}

#grid(
  columns: (3cm, 1fr),
  column-gutter: 8pt,
  align(right + top)[#tag-style(1)],
  sample-content,
)

// =============================================================================
// Style 8: Outlined Number with Dot
// =============================================================================

#v(1.5em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(0.5em)
== Style 8: Number with Dot Leader
#v(0.3em)
#text(size: 9pt, fill: gray)[Large number followed by dot - simple and direct]

#v(0.8em)
#let number-dot(number) = {
  text(weight: "bold", size: 16pt)[#number.]
}

#grid(
  columns: (1.5cm, 1fr),
  column-gutter: 8pt,
  align(right)[#number-dot(1)],
  sample-content,
)

// =============================================================================
// Style 9: Square Number
// =============================================================================

#v(1.5em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(0.5em)
== Style 9: Square Badge
#v(0.3em)
#text(size: 9pt, fill: gray)[Number in a square - compact and bold]

#v(0.8em)
#let square-number(number, size: 24pt, color: rgb("#1f2937")) = {
  box(
    width: size,
    height: size,
    fill: color,
    radius: 4pt,
    align(center + horizon)[
      #text(weight: "bold", size: size * 0.55, fill: white)[#number]
    ]
  )
}

#grid(
  columns: (3cm, 1fr),
  column-gutter: 8pt,
  align(right)[#square-number(1)],
  sample-content,
)

// =============================================================================
// Comparison Overview
// =============================================================================

#pagebreak()

#align(center)[
  #text(size: 16pt, weight: "bold")[Style Comparison]
]

#v(1em)

#table(
  columns: (auto, auto, 1fr),
  inset: 8pt,
  align: (center, left, left),
  stroke: 0.5pt + gray,

  [*Style*], [*Preview*], [*Best For*],

  [Box Badge], box-badge(1), [Traditional documents, formal contexts],

  [Circled], circled-number(1), [Clean designs, worksheets, elegant documents],

  [Filled Circle], filled-circle(1), [High visibility, color-coded topics],

  [Pill], pill-badge(1), [Modern UIs, friendly tone],

  [Border Accent], text(fill: rgb("#3b82f6"), weight: "bold")[Ex 1 |], [Long exercises, document sections],

  [Underline], text(weight: "bold")[Exercice 1] + line(length: 3cm, stroke: 0.5pt), [Textbooks, classic academic style],

  [Tag], tag-style(1), [Callouts, highlighted exercises],

  [Number Dot], number-dot(1), [Minimal design, problem sets],

  [Square], square-number(1), [Bold emphasis, numbered lists],
)

#v(1em)

#block(
  fill: rgb("#fef3c7"),
  stroke: 0.5pt + rgb("#d97706"),
  radius: 4pt,
  inset: 12pt,
)[
  *Recommendation:* The *Circled Number* style (Style 2) matches the user's reference image and provides a clean, professional look suitable for mathematics worksheets.
]
