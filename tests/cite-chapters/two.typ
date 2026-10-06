#import "../../lib.typ": exo, exo-cite, exo-setup
#import "@preview/beautitled:0.3.1": beautitled-setup
#beautitled-setup(part-numbering: "A", part-prefix: "Livre")
= Deuxième partie
== Premier chapitre
#exo(id: "second-part", exercise: [Exercice de la deuxième partie.])
#exo-setup(exercise-label: "Nouvelle étiquette")
CHK-back-part: #exo-cite("first-part", show-part: true) #parbreak()
CHK-part-only: #exo-cite("second-part", show-part: true, show-page: false) #parbreak()
CHK-custom-part: #exo-cite("first-part", show-part: true, show-page: false, prefix: none, part-prefix: "volume") #parbreak()
