#import "../lib.typ": *
#set page(width: 420pt, height: auto, margin: 20pt,
  numbering: (n, ..total) => str(counter(heading).get().first()) + "-" + str(n))
#set heading(numbering: "1.")
#exo-setup(display: "ex")
= First chapter
#exo(id: "contextual-page", exercise: [Statement.])
#pagebreak()
= Second chapter
CHK-contextual-page: #exo-cite("contextual-page")
