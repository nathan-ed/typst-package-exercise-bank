// qr-position: "tasks" places the QR as an overlay of zero flow height, so the
// text an exercise puts before its #tasks call has to keep clear of it. In a
// narrow column that sentence takes two or three lines and used to run right
// under the code.
#import "/lib.typ": exo, exo-setup
#import "@preview/taskize:0.2.9": tasks, tasks-setup

#set page(width: 19cm, height: 8cm, margin: 1cm)
#set text(size: 11pt, lang: "fr")
#tasks-setup(columns: "auto-fit", auto-fit-mode: "uniform", max-columns: 4)
#exo-setup(badge-style: "header-card", badge-color: rgb("#dc2626"),
  qr-size: 1.8cm, qr-position: "tasks")

#let ex = exo.with(id: "A", // a solid block instead of a real code: its edges are exact,
  // which is what the check measures against
  qr: rect(width: 100%, height: 1.8cm, fill: black),
  exercise: [
    Calculer en s'aidant éventuellement du schéma.

    #tasks(columns: "auto-fit", label: (..n) => strong(numbering("1.", ..n)), start: 1)[
      + $2 dot.op 4/5$
      + $4 dot.op 2/3$
    ]
  ])

#columns(2, gutter: 8mm)[#ex()]

#pagebreak()

// An exercise with no #tasks call at all: the whole body has to keep clear of
// the overlay, since there is no grid to hand the zone to.
#let plain = exo.with(id: "B", qr: rect(width: 100%, height: 1.8cm, fill: black),
  exercise: [Un exercice sans aucun bloc de taches, seulement une consigne redigee.])
#columns(2, gutter: 8mm)[#plain()]
