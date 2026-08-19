#import "@preview/taskize:0.2.8": tasks
#set page(width: 16cm, height: auto, margin: 1cm)
#let body = [
  Calculer en s'aidant du schéma.

  #tasks(columns: 2)[
    + $2 dot.op 4/5$
    + $4 dot.op 2/3$
  ]
]
#repr(body.children.map(c => repr(c.func())))
