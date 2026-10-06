// Cross-file references, repeated chapter numbers in different beautitled parts.
#import "../lib.typ": *
#import "@preview/beautitled:0.3.1": beautitled-init, beautitled-setup
#set page(width: 16cm, height: auto, margin: 1cm, numbering: "1")
#set text(size: 11pt, lang: "fr")
#show: beautitled-init
#beautitled-setup(enable-parts: true, part-fullpage: false, part-prefix: "Partie")
#show: exo-auto-chapter
#exo-setup(display: "ex", exercise-label: "Exercice", number-prefix: "chapter", badge-style: "underline")
#include "cite-chapters/one.typ"
#pagebreak()
#include "cite-chapters/two.typ"
#context {
  let anchors = query(<_exb-reference>)
  assert.eq(anchors.len(), 2)
  assert(anchors.at(1).location().page() > anchors.first().location().page())
}
