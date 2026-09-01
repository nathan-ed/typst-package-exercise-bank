// Test: two-column layouts + badge sizing (0.6.4)
//   typst compile --root .. tests/columns-corrections.typ out-{p}.png --format png

#import "../lib.typ": *

#set page(width: 16cm, height: 22cm, margin: 1.4cm)
#set text(size: 10pt)
#set heading(numbering: "1.")
#show: exo-auto-chapter

#exo-setup(
  show-qr: false,
  label-font-size: 10pt,
  badge-style: "filled-rect",
  badge-position: "above",
  corr-display: "correction",
  corr-loc: "end-chapter",
  counter-reset: "chapter",
  exercise-label: "Exercice",
  correction-label: "Corrigé",
  // corrections collected at the end of the chapter, set in two columns
  // with a vertical rule
  corr-columns: 2,
  corr-columns-rule: 0.5pt + gray,
  corr-columns-gutter: 0.7cm,
)

= Ensembles

#exo-columns(count: 2, rule: 0.5pt + gray, gutter: 0.7cm)[
  #for i in range(1, 9) {
    exo(
      exercise: [Calculer $A union B$ pour la paire numéro #i, puis vérifier
        que $A inter B = emptyset$.],
      correction: [$A union B = {0; 1; 2; #i}$ et $A inter B = emptyset$.],
    )
  }
]

= Badges plus petits

#exo-setup(badge-scale: 0.55)

#exo-columns(count: 2, rule: 0.5pt + gray, gutter: 0.7cm)[
  #for i in range(1, 5) {
    exo(
      exercise: [Badge réduit (#sym.times 0.55), exercice #i.],
      correction: [Corrigé #i.],
    )
  }
]

= Tous les styles, trois tailles

#for scale in (0.5, 1.0, 1.6) {
  exo-setup(badge-scale: scale)
  for style in ("box", "circled", "filled-circle", "rect", "filled-rect", "pill", "tag") {
    exo-setup(badge-style: style)
    exo(exercise: [`#style` à l'échelle #scale.], correction: [ok])
  }
}

// ---------------------------------------------------------------------------
// A columned block longer than a page: the split path must keep every exercise
// (a body that cannot be split falls back to a fixed-height block, which drops
// what does not fit), balance the columns, break across pages and stop its rule
// at the content. Count the statements in the PDF: 40 expected.
// ---------------------------------------------------------------------------

= Bloc plus long qu'une page

#exo-setup(badge-scale: 0.6, corr-columns: 1)

#exo-columns(count: 2, rule: 0.5pt + gray, gutter: 0.7cm, balance: true)[
  #for i in range(1, 41) {
    exo(exercise: [Résoudre l'équation $x^2 - #i x + #i = 0$ à l'aide du
      discriminant, puis vérifier les solutions trouvées.])
  }
]

Texte de pleine largeur, juste après le bloc.
