#import "/lib.typ": *
#import "@preview/taskize:0.2.8": tasks, tasks-setup

#set page(width: 19cm, height: auto, margin: 1cm)
#set text(size: 11pt, lang: "fr")
#tasks-setup(columns: "auto-fit", auto-fit-mode: "uniform", max-columns: 4)
#exo-setup(badge-style: "header-card", badge-color: rgb("#dc2626"),
  qr-size: 1.8cm, qr-position: "tasks")

#columns(2, gutter: 8mm)[
  #let e1 = exo.with(id: "A", qr: "https://coopmaths.fr/alea?uuid=704ee&id=10NO3A-0&n=4",
    exercise: [
      Calculer en s'aidant éventuellement du schéma.

      #tasks(columns: "auto-fit", label: (..n) => strong(numbering("1.", ..n)), start: 1)[
        + $2 dot.op 4/5$
        + $4 dot.op 2/3$
      ]
    ])
  #e1()
]
