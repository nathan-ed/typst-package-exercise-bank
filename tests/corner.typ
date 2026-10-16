// exo-corner: a solid black square stands for the page-level QR code. Every
// badge style, with the badge in the margin and above, must keep clear of it
// (see check-corner.sh): header lines and rules stop short of it, statements
// flow around it, framed styles start below it.
#import "/lib.typ": exo, exo-setup, exo-corner, exo-corner-fit
#import "@preview/taskize:0.2.10": tasks
#set page(width: 16cm, height: 10cm, margin: 0.8cm)

#let statement = [Calculer.
  #tasks(columns: 4)[
    + $2 times 3$
    + $3 times 4$
    + $4 times 5$
    + $5 times 6$
    + $6 times 7$
    + $7 times 8$
    + $8 times 9$
    + $9 times 10$
  ]
]

#for (pos, pts) in (("margin", "right"), ("above", "below")) {
  for st in ("border-accent", "underline", "rounded-box", "header-card", "margin", "box", "pill", "tag", "circled", "filled-circle", "rect", "filled-rect") {
    exo-setup(badge-style: st, badge-position: pos, points-position: pts, qr-position: "tasks", show-id: false)
    exo-corner(rect(width: 1.8cm, height: 1.8cm, fill: black))
    exo(title: st, points: 3, exercise: statement)
    pagebreak(weak: true)
  }
}

// a sheet title fitted beside the corner, then a statement opening with a
// block that is not a tasks call (moved below the corner)
#exo-setup(badge-style: "underline", badge-position: "margin", points-position: "below")
#exo-corner(rect(width: 1.8cm, height: 1.8cm, fill: black))
#exo-corner-fit[
  #text(size: 1.5em, weight: "bold")[Fiche d'exercices]
  #line(length: 100%)
]
#exo(exercise: [
  #rect(width: 100%, height: 0.6cm, fill: gray)
  Suite de l'énoncé.
])
