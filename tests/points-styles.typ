// Points of an exercise on every badge style: one page per style, every
// points-position with both badge positions
//   typst compile --root .. points-styles.typ

#import "../lib.typ": *

#set page(paper: "a4", margin: (left: 2.6cm, rest: 1.2cm))
#set text(size: 10pt, lang: "fr")
#exo-setup(
  show-qr: false,
  label-font-size: 10pt,
  exercise-label: "Exercice",
  points-label: "points",
  display: "ex",
)

#let styles = (
  "box", "circled", "filled-circle", "pill", "tag", "rounded-box",
  "margin", "border-accent", "underline", "header-card",
)

#let panel(badge-position, points-position) = {
  exo-setup(badge-position: badge-position, points-position: points-position)
  block(
    width: 100%,
    above: 0.9em,
    below: 0.4em,
    text(size: 8.5pt, fill: rgb("#777"))[
      #raw("badge-position: \"" + badge-position + "\"")
      #h(1em)
      #raw("points-position: \"" + points-position + "\"")
    ],
  )
  exo(
    title: [Théorème de Pythagore],
    points: 4,
    exercise: [
      Le triangle $A B C$ est rectangle en $A$, avec $A B = 3$ cm et $A C = 4$ cm.
      Calculer $B C$.
    ],
  )
  exo(
    points: 1.5,
    exercise: [Calculer $2^3 + 3^2$.],
  )
}

#for style in styles {
  for badge-position in ("margin", "above") {
    exo-setup(badge-style: style)
    exo-reset-counter()
    align(center, text(size: 14pt, weight: "bold")[
      Style #raw(style) #h(0.6em) #text(size: 11pt, weight: "regular")[badge-position: #raw(badge-position)]
    ])
    for points-position in ("below", "right", "badge") {
      panel(badge-position, points-position)
    }
    if not (style == styles.last() and badge-position == "above") { pagebreak() }
  }
}

// ============================================================
// points-format: "score" (blank for the mark)
#pagebreak()
#align(center, text(size: 14pt, weight: "bold")[#raw("points-format: \"score\"")])
#exo-setup(points-format: "score", points-label: "pts")
#for (style, badge-position, points-position) in (
  ("box", "margin", "right"),
  ("box", "above", "right"),
  ("underline", "margin", "right"),
  ("header-card", "margin", "right"),
  ("margin", "margin", "right"),
  ("underline", "margin", "below"),
  ("pill", "margin", "badge"),
) {
  exo-setup(badge-style: style)
  exo-reset-counter()
  block(above: 1em, below: 0.4em, text(size: 8.5pt, fill: rgb("#777"), raw(
    "badge-style: \"" + style + "\"  badge-position: \"" + badge-position + "\"  points-position: \"" + points-position + "\"",
  )))
  exo-setup(badge-position: badge-position, points-position: points-position)
  exo(title: [Théorème de Pythagore], points: 4, exercise: [Calculer $B C$.])
}
