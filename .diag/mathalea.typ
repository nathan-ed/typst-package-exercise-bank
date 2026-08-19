#import "@preview/exercise-bank:0.6.2": exo, exo-setup, exo-solution-box
#import "@preview/taskize:0.2.8": tasks, tasks-setup
#import "@preview/breather:0.1.0": breathe

#set page(paper: "a4", margin: (x: 15mm, y: 15mm))
#set text(size: 11pt, lang: "fr")
#set par(leading: 0.6em)
#set enum(numbering: "1.", spacing: 1.2em)
#show math.frac: it => math.display(it)
#show: breathe
#tasks-setup(columns: "auto-fit", auto-fit-mode: "uniform", max-columns: 4)

#let couleur = rgb("#dc2626")
#exo-setup(exercise-label: "Exercice", badge-style: "header-card",
  badge-color: couleur, qr-size: 1.8cm, qr-position: "tasks")

#let fig(w) = rect(width: w, height: 20pt, fill: rgb("#F15929").lighten(50%))
#let figblock(body) = layout(size => {
  let natural = measure(body).width
  let f = calc.min(1.0, size.width / natural)
  let scaled = if f != 1.0 { box(scale(f * 100%, origin: top + left, reflow: true, body)) } else { body }
  let available = calc.min(size.width, 1000pt)
  let left = calc.max(0pt, (available - natural * f) / 2)
  pad(left: left)[#scaled]
})

#let ex1 = exo.with(id: "10NO3A-0", qr: "https://coopmaths.fr/alea?uuid=704ee&id=10NO3A-0&n=4&alea=LFhb",
  exercise: [
    Calculer en s'aidant éventuellement du schéma.

    #tasks(columns: "auto-fit", label: (..n) => strong(numbering("1.", ..n)), row-gutter: 1.2em, above: 1.2em, below: 0.8em, start: 1)[
      + $2 dot.op frac(4, 5)$\
        #figblock(fig(291pt))
      + $4 dot.op frac(2, 3)$\
        #figblock(fig(291pt))
      + $4 dot.op frac(1, 2)$\
        #figblock(fig(291pt))
      + $4 dot.op frac(1, 3)$\
        #figblock(fig(291pt))
    ]
  ])

#let ex3 = exo.with(id: "10NO3A-3", qr: "https://coopmaths.fr/alea?uuid=3ee4e&id=10NO3A-3",
  exercise: [
    Calculer et donner le résultat sous forme irréductible.

    #tasks(columns: "auto-fit", label: none, row-gutter: 1.2em, above: 1.2em, below: 0.8em, start: 1)[
      + $A = frac(20, 15) dot.op frac(1, 35)$
      + $B = frac(2, 28) dot.op frac(1, 20)$
      + $C = frac(14, 15) dot.op frac(1, 28)$
      + $D = frac(55, 18) dot.op frac(1, 99)$
    ]
  ])

#columns(2, gutter: 8mm)[
  #ex1()
  #ex3()
]
