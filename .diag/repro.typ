#import "/lib.typ": *
#import "@preview/taskize:0.2.8": tasks, tasks-setup

#set page(width: 18cm, height: auto, margin: 1cm)
#set text(size: 11pt, lang: "fr")
#set par(leading: 0.6em)
#show math.frac: it => math.display(it)
#tasks-setup(columns: "auto-fit", auto-fit-mode: "uniform", max-columns: 4)

*A. label et maths sur la même ligne ?*
#tasks(columns: 2, label: (..n) => strong(numbering("1.", ..n)), start: 1)[
  + $2 dot.op frac(4, 5)$
  + $4 dot.op frac(2, 3)$
]

*B. sans fraction display (témoin)*
#tasks(columns: 2, label: (..n) => strong(numbering("1.", ..n)), start: 1)[
  + $2 + 4$
  + $4 + 2$
]
