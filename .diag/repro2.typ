#import "/lib.typ": *
#import "/home/nathan/Documents/projets/typst_packages/taskize/lib.typ": tasks, tasks-setup
#import "@preview/breather:0.1.0": breathe

#set page(width: 18cm, height: auto, margin: 1cm)
#set text(size: 11pt, lang: "fr")
#set par(leading: 0.6em)
#set enum(numbering: "1.", spacing: 1.2em)
#show math.frac: it => math.display(it)
#tasks-setup(columns: "auto-fit", auto-fit-mode: "uniform", max-columns: 4)

#let fig = rect(width: 4cm, height: 0.5cm, fill: orange.lighten(60%))
#let figblock(body) = layout(size => {
  let natural = measure(body).width
  let f = calc.min(1.0, size.width / natural)
  box(scale(f * 100%, origin: top + left, reflow: true, body))
})

*A. sans breathe, avec \ + figure*
#tasks(columns: 2, label: (..n) => strong(numbering("1.", ..n)), start: 1)[
  + $2 dot.op frac(4, 5)$\
    #figblock(fig)
  + $4 dot.op frac(2, 3)$\
    #figblock(fig)
]

#show: breathe

*B. avec breathe*
#tasks(columns: 2, label: (..n) => strong(numbering("1.", ..n)), start: 1)[
  + $2 dot.op frac(4, 5)$\
    #figblock(fig)
  + $4 dot.op frac(2, 3)$\
    #figblock(fig)
]
