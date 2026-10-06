// Points of an exercise (exo(points:), points-label, points-position,
// points-format) on every badge style and both badge positions
//   typst compile --root .. points.typ points-{p}.png --format png

#import "../lib.typ": *

#set page(width: 16cm, height: 24cm, margin: (left: 2.5cm, rest: 1.2cm))
#set text(size: 10pt, lang: "fr")
#exo-setup(show-qr: false, label-font-size: 10pt, exercise-label: "Exercice")

#let styles = (
  "box", "circled", "filled-circle", "pill", "tag", "rounded-box",
  "margin", "border-accent", "underline", "header-card",
)

// ============================================================
// One page per (badge position, points position): every style, with and
// without a title
#for badge-position in ("margin", "above") {
  for points-position in ("below", "right", "badge") {
    exo-setup(
      badge-position: badge-position,
      points-position: points-position,
      points-label: "points",
    )
    exo-reset-counter()
    [== badge-position: #badge-position, points-position: #points-position]
    for style in styles {
      exo-setup(badge-style: style)
      exo(
        title: [Style #raw(style)],
        points: 3,
        exercise: [Calculer $2 + 3$.],
        solution: [$5$],
      )
      exo(
        points: 1.5,
        exercise: [Exercice sans titre.],
      )
    }
    pagebreak()
  }
}

// ============================================================
// points-format, exercise without points, correction without points
#exo-setup(
  badge-style: "underline",
  badge-position: "margin",
  points-position: "right",
  points-label: "pts",
  points-format: (points, unit) => text(fill: blue)[sur #points #unit],
)
#exo-reset-counter()
== points-format, no points, correction

#exo(title: [Format personnalisé], points: 4, exercise: [Énoncé.])
#exo(title: [Sans points], exercise: [Aucun point affiché.])
#exo-setup(badge-style: "margin", points-position: "below", points-format: auto, show-qr: true)
#exo(
  points: 2,
  qr: rect(width: 1.2cm, height: 1.2cm, fill: luma(220)),
  exercise: [Points puis QR code dans la colonne latérale.],
)
#exo-setup(badge-style: "underline", points-position: "right", show-qr: false)
#exo-setup(display: "both")
#exo(
  title: [Avec correction],
  points: 2,
  exercise: [Énoncé.],
  solution: [La correction ne répète pas les points.],
)
#exo-setup(display: "ex")

#pagebreak()

// ============================================================
// Exam path (exo-define / exo-show) keeps its points after the badge
#exo-setup(
  badge-style: "box",
  points-format: auto,
  points-position: "below",
  points-label: "pts",
)
#exo-reset-counter()
== exo-define / exo-show

#exo-setup(display-mode: "exam")
#exo-define(id: "points-exam", points: 5, exercise: [Exercice défini avec des points.])
#exo-show("points-exam")
#exo-setup(badge-style: "underline")
#exo-show("points-exam")
#exo-setup(display-mode: "exercise", badge-style: "box")
