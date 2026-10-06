// Real displayed numbers/pages, forward references and filtered selections.
#import "../lib.typ": *
#set page(width: 420pt, height: 210pt, margin: 10pt, numbering: "1")
#set text(size: 11pt)
#set heading(numbering: "1.")
#exo-setup(display: "ex", badge-style: "underline", exercise-label: "Exercice", number-prefix: "chapter")

CHK-forward: #exo-cite("later") #parbreak()
#pagebreak()
= Chapitre 1
#exo-define(id: "excluded", topic: "alg", level: "other", exercise: [Ne pas afficher.])
#exo-define(id: "a", topic: "alg", level: "chosen", exercise: [Question A. \ Ligne 2 \ Ligne 3 \ Ligne 4 \ Ligne 5 \ Ligne 6])
#exo-define(id: "b", topic: "alg", level: "chosen", exercise: [Question B. \ Ligne 2 \ Ligne 3 \ Ligne 4 \ Ligne 5 \ Ligne 6])
#exo-define(id: "not-displayed", topic: "alg", level: "chosen", exercise: [Hors limite.])
#exo-select(where: ex => ex.metadata.level == "chosen", max: 2) <selected>
#pagebreak()
= Chapitre 2
#exo(id: "later", exercise: [Question plus tard.]) <later-display>
CHK-back: #exo-cite("b", <selected>, topic: "alg") #parbreak()
CHK-nopage: #exo-cite("a", show-page: false) #parbreak()
CHK-noprefix: #exo-cite("b", <selected>, prefix: none, show-page: false) #parbreak()
CHK-hidden: #exo-cite("not-displayed") #parbreak()
CHK-unknown: #exo-cite("absent") #parbreak()
CHK-wrong-topic: #exo-cite("b", topic: "geometry") #parbreak()

#exo-setup(number-prefix: 7, exercise-label: "Problem")
#exo-show("a") <again>
CHK-repeat: #exo-cite("a", <again>, show-page: false) #parbreak()
CHK-occurrence: #exo-cite("a", occurrence: 2, show-page: false) #parbreak()
CHK-original: #exo-cite("a", <selected>, show-page: false) #parbreak()
CHK-direct: #exo-cite("later", pos-label: <later-display>, show-page: false) #parbreak()

#pagebreak()
#set page(numbering: "i")
#counter(page).update(4)
#exo(id: "roman-page", topic: "filter-target", exercise: [Page numérotée en romain.])
CHK-roman: #exo-cite("roman-page") #parbreak()
#context {
  let anchors = query(<_exb-reference>)
  let a = anchors.find(it => it.value.id == "a")
  let b = anchors.find(it => it.value.id == "b")
  assert(b.location().page() > a.location().page(), message: "Fixture must span multiple selection pages")
  assert.eq(anchors.filter(it => it.value.id == "not-displayed").len(), 0)
  assert.eq(anchors.filter(it => it.value.id == "a").len(), 2)
}

#exo-filter(topic: "filter-target") <filtered>
CHK-filter: #exo-cite("roman-page", <filtered>, show-page: false) #parbreak()
CHK-missing-label: #exo-cite("a", <no-display>) #parbreak()
CHK-missing-occurrence: #exo-cite("a", occurrence: 99) #parbreak()
#exo-setup(display: "sol")
#exo(id: "hidden-statement", exercise: [Caché.], solution: [Réponse visible.])
CHK-solution-only: #exo-cite("hidden-statement") #parbreak()
