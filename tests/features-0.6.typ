// Test suite for the 0.6.0 features
// Compile to PNG and inspect each page:
//   typst compile --root .. features-0.6.typ features-0.6-{p}.png --format png

#import "../lib.typ": *

#set page(width: 16cm, height: 22cm, margin: (left: 2.5cm, rest: 1.2cm))
#set text(size: 10pt)
#exo-setup(show-qr: false, label-font-size: 10pt)

// ============================================================
// Page 1: markers (optional / corr-given) on every badge style
// ============================================================
= Marqueurs sur tous les styles de badge

#for style in ("box", "circled", "filled-circle", "rect", "filled-rect", "pill", "tag") {
  exo-setup(badge-style: style)
  exo(
    exercise: [Style *#raw(style)* avec marqueur optional. $x^2 = 4$],
    optional: true,
  )
  exo(
    exercise: [Style *#raw(style)* avec marqueur corr-given.],
    corr-given: true,
  )
}

#pagebreak()

// ============================================================
// Page 2: markers on full-width styles
// ============================================================
= Marqueurs sur les styles full-width

#for style in ("margin", "border-accent", "underline", "rounded-box", "header-card") {
  exo-setup(badge-style: style)
  exo(
    exercise: [Style full-width *#raw(style)* avec marqueurs optional + corr-given.],
    optional: true,
    corr-given: true,
  )
}

#exo-setup(badge-style: "box")
#pagebreak()

// ============================================================
// Page 3: difficulty — color mode (default)
// ============================================================
= Difficulté : mode "color" (défaut)

#for lvl in range(1, 6) {
  exo(
    exercise: [Exercice de difficulté #lvl : le badge prend la couleur du niveau.],
    difficulty: lvl,
  )
}

== Mode "stars"
#exo-setup(difficulty-display: "stars")
#for lvl in range(1, 6) {
  exo(
    exercise: [Difficulté #lvl en étoiles.],
    difficulty: lvl,
  )
}

#pagebreak()

// ============================================================
// Page 4: difficulty — symbols mode + custom scale
// ============================================================
= Difficulté : mode "symbols"

#exo-setup(difficulty-display: "symbols")
#for lvl in range(1, 6) {
  exo(
    exercise: [Difficulté #lvl : pousse / crayon / cible / montagne / étoile.],
    difficulty: lvl,
  )
}

== Échelle personnalisée
#exo-setup(
  difficulty-display: "color",
  difficulty-scale: (
    "facile": (color: rgb("#00897b")),
    "dur": (color: rgb("#e65100")),
  ),
)
#exo(exercise: [Niveau custom "facile" (turquoise).], difficulty: "facile")
#exo(exercise: [Niveau custom "dur" (orange).], difficulty: "dur")

#exo-setup(difficulty-display: "color", difficulty-scale: auto)
#pagebreak()

// ============================================================
// Page 5: chapter-prefixed numbering + rect + custom badge fn
// ============================================================
#set heading(numbering: "1.")
#exo-setup(number-prefix: "heading", badge-style: "filled-rect", counter-reset: "chapter")
#counter(heading).update(2)

= Numérotation avec préfixe chapitre
#exo-chapter-start()

#exo(exercise: [Cet exercice doit être numéroté 3.1 (filled-rect).])
#exo(exercise: [Celui-ci 3.2.])

== Badge fonction personnalisée
#exo-setup(badge-style: (label, number, font-size, color, is-solution) => {
  box(stroke: (bottom: 1.5pt + color), inset: (x: 4pt, y: 3pt),
    text(weight: "black", size: font-size, fill: color, style: "italic")[#number.])
})
#exo(exercise: [Badge 100% custom via une fonction (souligné, italique, "3.3.").])

#exo-setup(badge-style: "box", number-prefix: none, counter-reset: "section")
#set heading(numbering: none)
#pagebreak()

// ============================================================
// Pages 6-8: end-chapter workflow with exo-auto-chapter,
// sol-loc: "after" + inline solutions, corr-loc: "end-chapter",
// clickable links
// ============================================================
#exo-setup(
  corr-display: "correction",
  sol-loc: "after",
  corr-loc: "end-chapter",
  solution-style: "inline",
  link-solutions: true,
  counter-reset: "chapter",
  exercise-label: "Exercice",
  correction-label: "Corrigé",
)

#show: exo-auto-chapter

= Chapitre A : solutions inline, corrigés en fin de chapitre

#exo(
  exercise: [Résoudre $x^2 - 5x + 6 = 0$. (icône lien → corrigé)],
  solution: [$x in {2, 3}$],
  correction: [On factorise : $x^2-5x+6 = (x-2)(x-3)$, donc $x=2$ ou $x=3$. (icône retour → énoncé)],
)

#exo(
  exercise: [Exercice avec solution inline seulement (pas de corrigé, pas d'icône).],
  solution: [Réponse courte sous l'énoncé, style épigraphe.],
)

#exo(
  exercise: [Exercice avec corrigé seulement, difficulté 4, optional.],
  correction: [Corrigé complet reporté en fin de chapitre.],
  difficulty: 4,
  optional: true,
)

#pagebreak()

= Chapitre B : les corrigés du chapitre A doivent être AVANT ce titre

#exo(
  exercise: [Premier exercice du chapitre B (compteur reparti à 1).],
  solution: [Solution inline B.1],
  correction: [Corrigé B.1, en fin de chapitre B.],
)

Les corrigés du chapitre B doivent apparaître ci-dessous (fin de document).

#pagebreak()

= Chapitre C : référence de page style manuel scolaire

#set heading(numbering: "1.")
#exo-setup(
  link-style: "page",
  solution-style: auto,
  sol-loc: auto,
  badge-style: "filled-rect",
  badge-color: rgb("#1a4d8f"),
  number-prefix: "heading",
)

#exo(
  exercise: [Esquisser le graphe d'une primitive de la fonction $f$ dans chacun
    des cas ci-dessous. En haut à droite doit figurer « Corrigé p. N » cliquable.],
  correction: [Le corrigé, quelque part en fin de chapitre.],
)

#exo(
  exercise: [Deuxième exercice, badge « 3.2 », avec sa propre référence de page.],
  correction: [Corrigé du deuxième.],
)

== Difficulté sous le badge (défaut)

#exo-setup(link-style: "icon", difficulty-display: "stars", badge-style: "box", number-prefix: none)

#exo(exercise: [Trois étoiles *sous* le badge, badge compact.], difficulty: 3)
#exo(exercise: [Cinq étoiles sous le badge.], difficulty: 5)

#exo-setup(difficulty-display: "symbols")
#exo(exercise: [Montagne sous le badge.], difficulty: 4)

#exo-setup(difficulty-position: "badge")
#exo(exercise: [Montagne dans le badge (difficulty-position: "badge").], difficulty: 4)

== Solution inline avec label de marge

#exo-setup(
  difficulty-display: "color", difficulty-position: "below",
  sol-loc: "after", solution-style: "inline", corr-display: "solution",
  solution-label: "Solution",
)

#exo(
  exercise: [Résoudre $x^2 - 5x + 6 = 0$. Un petit « Solution » doit figurer
    dans la marge à gauche du trait.],
  solution: [$x in {2, 3}$],
)

#exo-setup(inline-label: text(size: 8pt, fill: gray)[Rép.])
#exo(
  exercise: [Label de marge personnalisé « Rép. ».],
  solution: [$f'(x) = 3x^2 - 3$],
)
