// Every badge style in a two-column document, with deferred corrections.
// Regression fixture for the multi-column layouts: the badges must cost no
// column width (badge "above", "margin" folded onto a header line) and the
// corrections printed by exo-auto-chapter must stay inside the columns.
//   typst compile --root .. tests/two-column-styles.typ out-{p}.png --format png

#import "../lib.typ": *

#set page(paper: "a4", margin: 2cm, numbering: "1")
#set text(size: 9.5pt)
#set par(justify: true)
#set heading(numbering: "1.")

#exo-setup(
  show-qr: false,
  label-font-size: 9pt,
  badge-color: rgb("#1a4f8a"),
  corr-loc: "end-chapter",
  corr-display: "correction",
  counter-reset: "chapter",
)

// exo-page-columns FIRST: the corrections exo-auto-chapter prints at the end of
// the document would otherwise fall outside the columned body
#show: exo-page-columns.with(count: 2, rule: 0.5pt + gray, rule-inset: 4pt)
#show: exo-auto-chapter

= Tous les styles

#for style in ("box", "circled", "filled-circle", "rect", "filled-rect", "pill",
               "tag", "margin", "border-accent", "underline", "rounded-box",
               "header-card") {
  exo-setup(badge-style: style)
  text(size: 7.5pt, fill: red)[*#style*]
  exo(
    exercise: [Résoudre $x^2 - 5x + 6 = 0$ à l'aide du discriminant, puis
      vérifier les solutions.],
    correction: [$Delta = 1$, donc $S = {2; 3}$.],
  )
}
