#import "@preview/exercise-bank:0.6.3": *

// =============================================================================
// DOCUMENT SETUP
// =============================================================================

#set page(margin: (x: 1.8cm, y: 2cm))
#set text(size: 10.5pt, font: "New Computer Modern")
#set heading(numbering: "1.")
#set par(justify: true)

#show raw.where(lang: "typst"): it => block(
  fill: luma(97%),
  radius: 3pt,
  inset: 8pt,
  stroke: 0.5pt + luma(85%),
)[#it]

// =============================================================================
// HELPER FUNCTIONS
// =============================================================================

/// Two-column example layout with code and preview
#let example(code, body) = block(breakable: false)[
  #table(
    columns: (1fr, 1fr),
    stroke: none,
    inset: 6pt,
    align: (left + top, left + top),
    [
      #set text(size: 8.5pt)
      *Code*
      #v(0.3em)
      #code
    ],
    [
      *Preview*
      #v(0.3em)
      #box(
        width: 100%,
        inset: (left: 1.8cm, right: 6pt, y: 6pt),
        radius: 3pt,
        stroke: 0.5pt + luma(85%),
        fill: luma(98%),
        clip: true,
      )[
        #set text(size: 9pt)
        // Use smaller font and margins for examples to fit in preview box
        #exo-setup(margin-position: 1.6cm, label-extra: 0.6cm, label-font-size: 9pt)
        #body
      ]
    ],
  )
  #v(0.5em)
]

/// Full-width example for larger previews
#let example-full(code, body) = block(breakable: false)[
  #set text(size: 8.5pt)
  *Code*
  #v(0.3em)
  #code
  #v(0.5em)
  *Preview*
  #v(0.3em)
  #box(
    width: 100%,
    inset: (left: 2.2cm, right: 8pt, y: 8pt),
    radius: 3pt,
    stroke: 0.5pt + luma(85%),
    fill: luma(98%),
    clip: true,
  )[
    #set text(size: 9.5pt)
    // Use smaller font and margins for examples to fit in preview box
    #exo-setup(margin-position: 2cm, label-extra: 0.6cm, label-font-size: 10pt)
    #body
  ]
  #v(0.8em)
]

// =============================================================================
// TITLE PAGE
// =============================================================================

#align(center)[
  #v(2cm)
  #text(size: 28pt, weight: "bold")[exercise-bank]
  #v(0.5em)
  #text(size: 16pt)[Typst Package]
  #v(1em)
  #text(size: 12pt, style: "italic")[Exercise Management & Banking System]
  #v(2cm)
  #line(length: 60%, stroke: 0.5pt)
  #v(1cm)
  #text(size: 11pt)[
    A comprehensive solution for creating, organizing, and filtering exercises\
    Version 0.6.1\
    Nathan Scheinmann
  ]
]

#pagebreak()

// =============================================================================
// TABLE OF CONTENTS
// =============================================================================

#outline(indent: 1em, depth: 2)

#pagebreak()

// =============================================================================
// INTRODUCTION
// =============================================================================

= Introduction

`exercise-bank` is a Typst package for creating and managing exercises with solutions, metadata, filtering, and exercise banks. Perfect for teachers, textbook authors, and educational content creators.

== Features

- Exercises with inline or deferred solutions
- Teacher corrections with flexible display modes
- Difficulty levels shown as badge colors, stars, or symbols
- Clickable links between exercises and their deferred corrections
- Split solution/correction placement, with an inline epigraph-style solution mode
- Chapter-prefixed numbering ("3.5") and automatic end-of-chapter corrections
- Draft mode for work-in-progress documents
- Multiple display control options (what, where, which content)
- Metadata support (topic, level, author, competencies)
- Exercise banks: define once, display anywhere
- Powerful filtering by any criteria
- Automatic numbering with reset options
- Customizable labels (localization support)

== Installation

Import the package in your Typst document:

```typst
#import "@preview/exercise-bank:0.6.3": exo, exo-setup
```

== Quick Start

#example-full(
  [```typst
#exo(
  exercise: [Solve the equation $2x + 5 = 13$.]
)
  ```],
  [
    #exo-setup(exercise-label: "Exercise", solution-label: "Solution")
    #exo(exercise: [Solve the equation $2x + 5 = 13$.])
  ]
)

#pagebreak()

// =============================================================================
// BASIC USAGE
// =============================================================================

= Basic Usage

== Simple Exercise

#example-full(
  [```typst
#exo(
  exercise: [Calculate $3 + 4 times 2$.]
)
  ```],
  [
    #exo-reset-counter()
    #exo(exercise: [Calculate $3 + 4 times 2$.])
  ]
)

== Exercise with Solution

#example-full(
  [```typst
#exo(
  exercise: [Calculate $3 + 4 times 2$.],
  solution: [$3 + 4 times 2 = 3 + 8 = 11$],
)
  ```],
  [
    #exo-reset-counter()
    #exo(
      exercise: [Calculate $3 + 4 times 2$.],
      solution: [$3 + 4 times 2 = 3 + 8 = 11$],
    )
  ]
)

== Multiple Exercises

Exercises are automatically numbered:

#example-full(
  [```typst
#exo(exercise: [Simplify $x^2 + 2x + 1$.])
#exo(exercise: [Factor $x^2 - 4$.])
#exo(exercise: [Solve $2x - 6 = 0$.])
  ```],
  [
    #exo-reset-counter()
    #exo(exercise: [Simplify $x^2 + 2x + 1$.])
    #exo(exercise: [Factor $x^2 - 4$.])
    #exo(exercise: [Solve $2x - 6 = 0$.])
  ]
)

#pagebreak()

// =============================================================================
// DISPLAY CONTROL
// =============================================================================

= Display Control

The package uses three parameters to control display behavior.

== `display` - What to Display

Controls what content is displayed:
- `"both"` (default) - Show exercises and solutions/corrections
- `"ex"` - Show only exercises
- `"sol"` - Show only solutions/corrections

#example-full(
  [```typst
#exo-setup(display: "ex")  // Exercises only

#exo(
  exercise: [Solve $x + 3 = 7$.],
  solution: [$x = 4$],  // Hidden
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(display: "ex")
    #exo(
      exercise: [Solve $x + 3 = 7$.],
      solution: [$x = 4$],
    )
  ]
)

== `corr-display` - Which Content to Show

Controls whether to show solutions or corrections:
- `"solution"` (default) - Show solution content
- `"correction"` - Show correction content
- `"mixed"` - Default to solution, but use correction for exercises with `show-corr: true`

#example-full(
  [```typst
#exo-setup(corr-display: "correction")

#exo(
  exercise: [Simplify $2x + 3x$.],
  correction: [
    $2x + 3x = 5x$
    (Combine like terms)
  ],
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(display: "both", corr-display: "correction")
    #exo(
      exercise: [Simplify $2x + 3x$.],
      correction: [
        $2x + 3x = 5x$
        (Combine like terms)
      ],
    )
  ]
)

== `corr-loc` - Where to Display

Controls where solutions/corrections appear:
- `"after"` (default) - Immediately after each exercise
- `"pagebreak"` - With a page break between
- `"end-section"` - Collected at section end
- `"end-chapter"` - Collected at chapter end

#example-full(
  [```typst
#exo-setup(corr-loc: "end-section")

#exo(exercise: [Exercise 1], solution: [Answer 1])
#exo(exercise: [Exercise 2], solution: [Answer 2])

#exo-print-solutions()  // Print collected solutions
  ```],
  [
    #exo-reset-counter()
    #exo-setup(display: "both", corr-display: "solution", corr-loc: "end-section")
    #exo(exercise: [Exercise 1], solution: [Answer 1])
    #exo(exercise: [Exercise 2], solution: [Answer 2])
    #exo-print-solutions()
  ]
)

#pagebreak()

// =============================================================================
// CORRECTIONS
// =============================================================================

= Corrections (Teacher Version)

Corrections are detailed solutions for teachers, including pedagogical notes and teaching tips.

== Exercise with Correction

#example-full(
  [```typst
#exo-setup(corr-display: "correction")

#exo(
  exercise: [Solve $x^2 = 9$.],
  correction: [
    *Teacher notes:*
    $x = plus.minus 3$

    Common mistake: forgetting the negative root.
  ],
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(display: "both", corr-display: "correction")
    #exo(
      exercise: [Solve $x^2 = 9$.],
      correction: [
        *Teacher notes:*
        $x = plus.minus 3$

        Common mistake: forgetting the negative root.
      ],
    )
  ]
)

== Solutions Only (Answer Key)

Show only solutions for student answer keys:

#example-full(
  [```typst
#exo-setup(display: "sol")

#exo(
  exercise: [This is hidden],
  solution: [Only this solution is shown],
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(display: "sol", corr-display: "solution")
    #exo(
      exercise: [This is hidden],
      solution: [Only this solution is shown],
    )
  ]
)

== The `sol-in-corr` Flag

When `corr-display: "correction"`, both correction AND solution are shown by default. Use `sol-in-corr: true` on an exercise to indicate the solution is already embedded in the correction (avoiding duplication):

#example-full(
  [```typst
#exo-setup(corr-display: "correction")

// Without sol-in-corr: both correction and solution shown
#exo(
  exercise: [Problem A],
  correction: [Teacher notes only],
  solution: [$x = 5$],
)

// With sol-in-corr: only correction shown
#exo(
  exercise: [Problem B],
  correction: [
    *Solution:* $x = 3$

    _Teaching tip: Watch for sign errors._
  ],
  solution: [$x = 3$],
  sol-in-corr: true,  // Solution already in correction
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(display: "both", corr-display: "correction")
    #exo(
      exercise: [Problem A],
      correction: [Teacher notes only],
      solution: [$x = 5$],
    )
    #exo(
      exercise: [Problem B],
      correction: [
        *Solution:* $x = 3$

        _Teaching tip: Watch for sign errors._
      ],
      solution: [$x = 3$],
      sol-in-corr: true,
    )
  ]
)

== Mixed Display Mode

Use `corr-display: "mixed"` to default to solutions while showing corrections for specific exercises:

#example-full(
  [```typst
#exo-setup(corr-display: "mixed")

#exo(
  exercise: [Simple problem],
  solution: [Quick answer],
  correction: [Detailed explanation],
)

#exo(
  exercise: [Complex problem],
  solution: [Answer],
  correction: [Step-by-step solution],
  show-corr: true,  // Shows correction
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(display: "both", corr-display: "mixed")
    #exo(
      exercise: [Simple problem],
      solution: [Quick answer],
      correction: [Detailed explanation],
    )
    #exo(
      exercise: [Complex problem],
      solution: [Answer],
      correction: [Step-by-step solution],
      show-corr: true,
    )
  ]
)

#pagebreak()

// =============================================================================
// DRAFT MODE
// =============================================================================

= Draft Mode

Show placeholders for incomplete exercises during document preparation.

== With Draft Mode ON

#example-full(
  [```typst
#exo-setup(
  draft-mode: true,
  solution-placeholder: [_[To be written]_],
)

#exo(
  exercise: [Solve $x + 5 = 12$],
  solution: [],  // Empty - shows placeholder
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(
      display: "both",
      corr-display: "solution",
      draft-mode: true,
      solution-placeholder: [_\[To be written\]_],
    )
    #exo(
      exercise: [Solve $x + 5 = 12$],
      solution: [],
    )
  ]
)

== With Draft Mode OFF (Default)

Empty solutions show minimal space without placeholders:

#example-full(
  [```typst
#exo-setup(draft-mode: false)

#exo(
  exercise: [Solve $x + 5 = 12$],
  solution: [],  // Empty - no placeholder
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(display: "both", corr-display: "solution", draft-mode: false)
    #exo(
      exercise: [Solve $x + 5 = 12$],
      solution: [],
    )
  ]
)

#pagebreak()

// =============================================================================
// EXERCISE BANKS
// =============================================================================

= Exercise Banks

Define exercises once, display them anywhere. Perfect for creating reusable exercise collections.

== Defining Bank Exercises

Use `exo-define` to register exercises without displaying them:

```typst
#exo-define(
  id: "quad-1",
  exercise: [Solve $x^2 - 5x + 6 = 0$.],
  topic: "quadratics",
  level: "1M",
  solution: [$x = 2$ or $x = 3$],
)

#exo-define(
  id: "geom-1",
  exercise: [Find the area of a circle with radius 5.],
  topic: "geometry",
  level: "1M",
  solution: [$A = 25pi$],
)
```

== Displaying Bank Exercises

Use `exo-show` to display a specific exercise:

#example-full(
  [```typst
#exo-show("quad-1")
  ```],
  [
    #exo-reset-counter()
    #exo-clear-registry()
    #exo-setup(display: "both", corr-display: "solution")
    #exo-define(
      id: "quad-1",
      exercise: [Solve $x^2 - 5x + 6 = 0$.],
      topic: "quadratics",
      level: "1M",
      solution: [$x = 2$ or $x = 3$],
    )
    #exo-show("quad-1")
  ]
)

== Selecting Multiple Exercises

Use `exo-select` with filters:

```typst
// All quadratics exercises
#exo-select(topic: "quadratics")

// Level 1M exercises only
#exo-select(level: "1M")

// Multiple topics
#exo-select(topics: ("quadratics", "geometry"))

// Limit count
#exo-select(topic: "algebra", max: 5)

// Custom filter
#exo-select(where: ex => ex.metadata.level == "hard")
```

#pagebreak()

// =============================================================================
// METADATA & FILTERING
// =============================================================================

= Metadata and Filtering

== Adding Metadata

Tag exercises for organization and filtering:

```typst
#exo(
  exercise: [Solve $x + 1 = 5$.],
  topic: "algebra",
  level: "easy",
  authors: ("Prof. Smith",),
)
```

== Filtering Exercises

Display only exercises matching criteria:

```typst
#exo-filter(topic: "algebra")
#exo-filter(level: "easy")
#exo-filter(topic: "algebra", level: "hard")
```

#pagebreak()

// =============================================================================
// COMPETENCIES
// =============================================================================

= Competency Tags

Tag exercises with competencies and display them visually.

#example-full(
  [```typst
#exo-setup(show-competencies: true)

#exo-define(
  id: "comp-ex",
  exercise: [Solve and explain your reasoning.],
  competencies: ("C1.1", "C2.3", "C4.1"),
  solution: [Detailed solution here],
)

#exo-show("comp-ex")
  ```],
  [
    #exo-reset-counter()
    #exo-clear-registry()
    #exo-setup(display: "both", corr-display: "solution", show-competencies: true)
    #exo-define(
      id: "comp-ex",
      exercise: [Solve and explain your reasoning.],
      competencies: ("C1.1", "C2.3", "C4.1"),
      solution: [Detailed solution here],
    )
    #exo-show("comp-ex")
  ]
)

== Filter by Competency

```typst
#exo-select(competency: "C1.1")
#exo-select(competencies: ("C1.1", "C2.3"))
```

#pagebreak()

// =============================================================================
// CONFIGURATION
// =============================================================================

= Configuration

== Global Setup

Use `exo-setup` to configure defaults:

```typst
#exo-setup(
  // Display control
  display: "both",               // "ex", "sol", "both"
  corr-display: "solution",    // "solution", "correction", "mixed"
  corr-loc: "after",           // "after", "pagebreak", "end-section", "end-chapter"
  // Labels
  exercise-label: "Exercise",
  solution-label: "Solution",
  correction-label: "Correction",
  // Counter behavior
  counter-reset: "section",   // "section", "chapter", "global"
  // Display options
  show-id: false,
  show-competencies: false,
  // Draft mode
  draft-mode: false,
  // Badge styling
  badge-style: "box",
  badge-color: black,
)
```

== Badge Styles

Change the visual style of exercise badges:

```typst
// Circled number (no label text)
#exo-setup(badge-style: "circled")

// Filled circle with white number
#exo-setup(badge-style: "filled-circle", badge-color: rgb("#2563eb"))

// Pill-shaped badge
#exo-setup(badge-style: "pill")

// Arrow tag
#exo-setup(badge-style: "tag", badge-color: rgb("#1e40af"))
```

Available styles: `"box"` (default), `"circled"`, `"filled-circle"`, `"pill"`, `"tag"`, `"margin"`, `"border-accent"`, `"underline"`, `"rounded-box"`, `"header-card"`

== Localization

Change labels for different languages:

#example(
  [```typst
// French
#exo-setup(
  exercise-label: "Exercice",
  solution-label: "Solution",
  correction-label: "Corrigé",
)
  ```],
  [
    #text(size: 9pt)[
      *French:* Exercice, Solution, Corrigé\
      *German:* Aufgabe, Lösung\
      *Spanish:* Ejercicio, Solución
    ]
  ]
)

== Counter Reset Options

Control when numbering resets:

```typst
#exo-setup(counter-reset: "section")  // Reset each section
#exo-setup(counter-reset: "chapter")  // Reset each chapter
#exo-setup(counter-reset: "global")   // Never reset
```

Use hooks to trigger resets:

```typst
= New Section
#exo-section-start()  // Resets if counter-reset: "section"

= New Chapter
#exo-chapter-start()  // Resets if counter-reset: "chapter"
```

== Advanced Exercises

Mark exercises as advanced to display a visual cue before the label. The default symbol is `*`.

#example(
  [```typst
#exo(
  exercise: [A challenging problem.],
  advanced: true,
)
  ```],
  [
    #exo-reset-counter()
    #exo(exercise: [A challenging problem.], advanced: true)
  ]
)

Customize the symbol:

#example(
  [```typst
#exo-setup(advanced-symbol: sym.dagger)
#exo(
  exercise: [Advanced with dagger.],
  advanced: true,
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(advanced-symbol: sym.dagger)
    #exo(exercise: [Advanced with dagger.], advanced: true)
  ]
)

Disable with `advanced-symbol: none`.

== Optional Exercises

Mark exercises as optional to display the optional-star icon before the label. Students know they can skip these.

#example(
  [```typst
#exo(
  exercise: [A bonus problem.],
  optional: true,
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(optional-symbol: optional-star-icon())
    #exo(exercise: [A bonus problem.], optional: true)
  ]
)

Customize or disable the symbol via `exo-setup`:

```typst
#exo-setup(optional-symbol: [⭐])   // custom
#exo-setup(optional-symbol: none)    // disable
```

== Correction-Given Exercises

The dumbbell icon (`corr-given: true`) signals that the printed correction will be handed out to students, so they can work independently with the answer key.

#example(
  [```typst
#exo(
  exercise: [Factor $x^2 - 9$.],
  solution: [$(x-3)(x+3)$],
  corr-given: true,
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(corr-given-symbol: corr-given-icon())
    #exo(exercise: [Factor $x^2 - 9$.], solution: [$(x-3)(x+3)$], corr-given: true)
  ]
)

Customize via `exo-setup(corr-given-symbol: ...)` or disable with `none`.

// =============================================================================
// QR CODES
// =============================================================================

= QR Codes

Attach a QR code to any exercise (e.g. linking to a video correction or an online resource). Pass a URL string — the code is generated with #link("https://typst.app/universe/package/tiaoma/")[tiaoma] — or ready-made content via the `qr` parameter.

#example(
  [```typst
#exo(
  exercise: [Factorise $x^2 - 9$.],
  solution: [$(x-3)(x+3)$],
  qr: "https://example.com/eq1",
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: "box")
    #exo(exercise: [Factorise $x^2 - 9$.], solution: [$(x-3)(x+3)$])
  ]
)

The QR code is placed automatically based on the active badge style:

- *Badge styles* (`box`, `circled`, `filled-circle`, `pill`, `tag`, `margin`): the QR sits below the badge in the label margin.
- *Full-width styles* (`border-accent`, `underline`, `rounded-box`, `header-card`): the exercise content wraps around the QR at the top right.

Solution and correction boxes can carry their own separate QR codes via `qr-sol` and `qr-corr`.

== Global QR Settings

Control QR appearance globally via `exo-setup`:

#example(
  [```typst
#exo-setup(
  qr-size: 1.5cm,
  qr-color: rgb("#1e3a8a"),
  qr-caption: [Correction],
  show-qr: true,
)
  ```],
  []
)

Use `show-qr: false` to suppress all QR codes (e.g. for a print version) without removing the URLs from bank definitions.

== QR Placement Modes

`qr-position` controls how the exercise body flows around the QR code for full-width badge styles:

#table(
  columns: (auto, 1fr),
  stroke: (x: none, y: 0.3pt + luma(85%)),
  inset: 6pt,
  [*Value*], [*Behavior*],
  [`"auto"` (default)], [Placed per badge style: label margin for badge styles, wrapped for full-width styles],
  [`"wrap"`], [Always wrap the exercise text around the QR at the top right, using #link("https://typst.app/universe/package/wrap-it/")[wrap-it]],
  [`"tasks"`], [Overlay the QR at the top right without reserving flow height; a #link("https://typst.app/universe/package/taskize/")[taskize] `#tasks` body inside the exercise narrows its own top rows to flow around the QR instead of the whole block being pushed below it],
)

`"tasks"` is opt-in and only takes effect when the exercise body actually contains a `#tasks(...)` call from taskize 0.2.8 or newer — the two packages coordinate purely through a shared state key (`taskize-wrap-zone`), with no import dependency in either direction. Bodies without a `#tasks` block ignore the overlay zone and render as if `qr-position` were unset.

#example(
  [```typst
#exo-setup(qr-position: "tasks")
#exo(
  exercise: tasks(
    [First short task.],
    [Second short task.],
    [Third short task.],
  ),
  qr: "https://example.com/quiz",
)
  ```],
  []
)

// =============================================================================
// DIFFICULTY LEVELS
// =============================================================================

= Difficulty Levels

Tag each exercise with a `difficulty:` level (built-in scale: 1 to 5). By default the exercise badge takes the level color:

#example(
  [```typst
#exo(exercise: [Introductory.],
  difficulty: 1)
#exo(exercise: [Exam-type.],
  difficulty: 3)
#exo(exercise: [Advanced.],
  difficulty: 4)
  ```],
  [
    #exo-reset-counter()
    #exo(exercise: [Introductory.], difficulty: 1)
    #exo(exercise: [Exam-type.], difficulty: 3)
    #exo(exercise: [Advanced.], difficulty: 4)
  ]
)

== Stars and Symbols

`difficulty-display: "stars"` shows 1--5 small stars; `"symbols"` shows one drawn icon per level (seedling, pencil, target, mountain, star). Both are placed below the badge by default so the badge stays compact (`difficulty-position: "badge"` puts them inline).

#example(
  [```typst
#exo-setup(
  difficulty-display: "stars")
#exo(exercise: [Three stars.],
  difficulty: 3)

#exo-setup(
  difficulty-display: "symbols")
#exo(exercise: [Mountain.],
  difficulty: 4)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(difficulty-display: "stars")
    #exo(exercise: [Three stars.], difficulty: 3)
    #exo-setup(difficulty-display: "symbols")
    #exo(exercise: [Mountain.], difficulty: 4)
    #exo-setup(difficulty-display: "color")
  ]
)

== Custom Scale and Filtering

The scale is a dictionary mapping any key to a color and/or symbol:

```typst
#exo-setup(difficulty-scale: (
  "easy": (color: rgb("#00897b")),
  "hard": (color: rgb("#e65100"), symbol: [🔥]),
))
#exo(exercise: [...], difficulty: "hard")

// Filtering
#exo-select(difficulty: 3)
#exo-select(difficulties: (1, 2))
#exo-count(difficulty: 4)
```

Difficulty combines well with the `optional` marker: encode every exercise's level, and mark the mandatory ones with `optional: false`.

// =============================================================================
// SOLUTION PLACEMENT & LINKS (0.6.0)
// =============================================================================

= Solution Placement and Links

== Automatic End-of-Chapter Corrections

With `corr-loc: "end-chapter"` the corrections are only _collected_; print them by calling `#exo-chapter-end()` where they should appear, or wrap the document with `exo-auto-chapter` to do it automatically before each new level-1 heading and at the end of the document:

```typst
#exo-setup(corr-loc: "end-chapter", counter-reset: "chapter")
#show: exo-auto-chapter

= Chapter 1
#exo(exercise: [...], solution: [...])

= Chapter 2  // <- Chapter 1 solutions print just before this title
```

== Separate Solution and Correction Placement

`sol-loc` controls where _solutions_ go, independently of `corr-loc` (default `auto` = follow it). Typical setup: short answer under the statement, full correction at the end of the chapter:

```typst
#exo-setup(
  corr-display: "correction",  // show correction and solution
  sol-loc: "after",            // answer below the statement
  corr-loc: "end-chapter",     // correction at chapter end
  solution-style: "inline",    // epigraph-like, no badge
)
```

== Inline Solution Style

`solution-style: "inline"` renders the solution as a short rule + content right under the statement, with a small margin label (customizable via `inline-label`, `none` to hide; rule length via `inline-rule-length`):

#example(
  [```typst
#exo-setup(
  solution-style: "inline")
#exo(
  exercise: [Solve
    $x^2 - 5x + 6 = 0$.],
  solution: [$x in {2, 3}$],
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(display: "both", corr-display: "solution", corr-loc: "after",
      sol-loc: "after", solution-style: "inline")
    #exo(
      exercise: [Solve $x^2 - 5x + 6 = 0$.],
      solution: [$x in {2, 3}$],
    )
    #exo-setup(solution-style: auto)
  ]
)

== Clickable Exercise #sym.arrow.l.r Correction Links

When corrections are deferred, `link-solutions: true` adds a clickable arrow icon next to the exercise badge that jumps to the correction, and a back-link on the correction. With `link-style: "page"` the exercise instead shows a textbook-style clickable reference ("Solution p. 30") at the top right of the statement:

```typst
#exo-setup(corr-loc: "end-chapter", link-solutions: true)
// or, textbook style:
#exo-setup(corr-loc: "end-chapter", link-solutions: true,
  link-style: "page")
```

Customize with `link-icon` / `backlink-icon` (icons) or `page-ref-color` / `page-ref-format` (page reference).

== Chapter-Prefixed Numbering

`number-prefix: "heading"` prefixes displayed numbers with the current level-1 heading number, e.g. exercise 5 of chapter 3 shows as "3.5" (separator via `number-separator`):

```typst
#set heading(numbering: "1.")
#exo-setup(number-prefix: "heading", counter-reset: "chapter")
#show: exo-auto-chapter
```

`number-prefix` also accepts a counter or a function `() => value`, for heading packages that keep their own chapter counter instead of `counter(heading)`. With beautitled 0.3.0+ the native counter is kept in sync, so `number-prefix: "heading"` works directly; for earlier versions (or with `enable-parts`, where the first heading level is the part) use beautitled's exported counter:

```typst
#import "@preview/beautitled:0.2.7": beautitled-init, chapter-counter
#show: beautitled-init
#exo-setup(number-prefix: chapter-counter, counter-reset: "chapter")
#show: exo-auto-chapter
```

With beautitled's direct `#chapter(...)` calls (no native headings), wrap the call instead of using `exo-auto-chapter`:

```typst
#let chapitre(..args) = {
  exo-chapter-end(); chapter(..args); exo-chapter-start()
}
```

// =============================================================================
// VISUAL STYLES
// =============================================================================

= Visual Styles

Set the badge style with `exo-setup(badge-style: "...")`.

== Box (Default)

#example(
  [```typst
#exo-setup(badge-style: "box")
#exo(exercise: [Solve $x + 3 = 7$])
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: "box")
    #exo(exercise: [Solve $x + 3 = 7$])
  ]
)

== Circled

#example(
  [```typst
#exo-setup(badge-style: "circled")
#exo(exercise: [Solve $x + 3 = 7$])
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: "circled")
    #exo(exercise: [Solve $x + 3 = 7$])
  ]
)

== Filled Circle

#example(
  [```typst
#exo-setup(
  badge-style: "filled-circle",
  badge-color: rgb("#2563eb"),
)
#exo(exercise: [Solve $x + 3 = 7$])
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: "filled-circle", badge-color: rgb("#2563eb"))
    #exo(exercise: [Solve $x + 3 = 7$])
  ]
)

== Rect and Filled Rect

Compact number-only rectangles -- a minimal alternative when circles look too large in your font:

#example(
  [```typst
#exo-setup(badge-style: "rect")
#exo(exercise: [Solve $x + 3 = 7$])
#exo-setup(
  badge-style: "filled-rect",
  badge-color: rgb("#1a4d8f"),
)
#exo(exercise: [Solve $2x = 10$])
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: "rect", badge-color: black)
    #exo(exercise: [Solve $x + 3 = 7$])
    #exo-setup(badge-style: "filled-rect", badge-color: rgb("#1a4d8f"))
    #exo(exercise: [Solve $2x = 10$])
  ]
)

== Custom Badge Function

For full control, pass a function `(label, number, font-size, color, is-solution) => content` as `badge-style`:

#example(
  [```typst
#exo-setup(badge-style:
  (label, number, font-size,
   color, is-solution) => {
    box(stroke:
      (bottom: 1.5pt + color),
      inset: (x: 4pt, y: 3pt),
      text(weight: "bold",
        size: font-size,
        fill: color)[#number.])
  })
#exo(exercise: [Solve $x^2 = 4$])
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: (label, number, font-size, color, is-solution) => {
      box(stroke: (bottom: 1.5pt + color), inset: (x: 4pt, y: 3pt),
        text(weight: "bold", size: font-size, fill: color)[#number.])
    })
    #exo(exercise: [Solve $x^2 = 4$])
    #exo-setup(badge-style: "box")
  ]
)

== Pill

#example(
  [```typst
#exo-setup(badge-style: "pill")
#exo(exercise: [Solve $x + 3 = 7$])
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: "pill")
    #exo(exercise: [Solve $x + 3 = 7$])
  ]
)

== Tag

#example(
  [```typst
#exo-setup(
  badge-style: "tag",
  badge-color: rgb("#1e40af"),
)
#exo(exercise: [Solve $x + 3 = 7$])
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: "tag", badge-color: rgb("#1e40af"))
    #exo(exercise: [Solve $x + 3 = 7$])
  ]
)

== Border Accent

#example(
  [```typst
#exo-setup(
  badge-style: "border-accent",
  badge-color: rgb("#3b82f6"),
)
#exo(exercise: [Solve $x + 3 = 7$])
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: "border-accent", badge-color: rgb("#3b82f6"))
    #exo(exercise: [Solve $x + 3 = 7$])
  ]
)

== Underline

#example(
  [```typst
#exo-setup(badge-style: "underline")
#exo(exercise: [Solve $x + 3 = 7$])
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: "underline")
    #exo(exercise: [Solve $x + 3 = 7$])
  ]
)

== Rounded Box

#example-full(
  [```typst
#exo-setup(badge-style: "rounded-box")
#exo(exercise: [Solve $x + 3 = 7$])
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: "rounded-box")
    #exo(exercise: [Solve $x + 3 = 7$])
  ]
)

== Header Card

#example-full(
  [```typst
#exo-setup(badge-style: "header-card", badge-color: rgb("#3b82f6"))
#exo(exercise: [Solve $x + 3 = 7$])
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: "header-card", badge-color: rgb("#3b82f6"))
    #exo(exercise: [Solve $x + 3 = 7$])
  ]
)

== Margin

The label appears flush-right in a fixed-width left column; content flows in the right column. Solutions are shown in a compact bordered block.

#example-full(
  [```typst
#exo-setup(badge-style: "margin")
#exo(
  exercise: [Solve $x + 3 = 7$],
  solution: [$x = 4$],
)
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: "margin", display: "both")
    #exo(exercise: [Solve $x + 3 = 7$], solution: [$x = 4$])
  ]
)

== Badge Position

Every style above places the badge in its own column on the left, so the statement is indented for the whole height of the exercise. In a narrow measure -- two-column layouts especially -- that column costs its width on *every* line, and it gets worse when the statement holds an enumeration, whose own indent stacks on top of it.

`badge-position: "above"` puts the badge alone on a header line and lets the statement run the full width underneath. It is independent of `badge-style`, so every badge look keeps working:

#example-full(
  [```typst
#exo-setup(badge-style: "filled-circle")
#exo(exercise: [...])            // badge-position: "margin" (default)

#exo-setup(badge-position: "above")
#exo(exercise: [...])            // same badge, full-width statement
  ```],
  [
    #exo-reset-counter()
    #exo-setup(badge-style: "filled-circle", badge-color: rgb("#1a4d8f"))
    #let statement = [
      A floor is covered with 500 square tiles. Tiles 5 cm longer and wider
      would have taken 320 of them.
      + Express the side length of the first tiles.
      + How many tiles of side $x + 5$ would be needed?
    ]
    // Narrowed to a two-column measure: that is where the left badge column
    // is worth the most, and where the enumeration indent hurts twice
    #block(width: 7.4cm)[
      #text(size: 8pt, style: "italic", fill: luma(45%))[badge-position: "margin"]
      #exo(exercise: statement)
    ]
    #v(0.4em)
    #exo-setup(badge-position: "above")
    #block(width: 7.4cm)[
      #text(size: 8pt, style: "italic", fill: luma(45%))[badge-position: "above"]
      #exo(exercise: statement)
    ]
    #exo-setup(badge-position: "margin", badge-style: "box", badge-color: black)
  ]
)

With `link-style: "page"` the "Solution p. 34" reference moves onto the badge line as well, instead of being wrapped into the top right of the statement.

#pagebreak()

// =============================================================================
// PARAMETER REFERENCE
// =============================================================================

= Parameter Reference

== `exo` Function

#table(
  columns: (1.2fr, 0.8fr, 0.8fr, 2fr),
  stroke: (x: none, y: 0.3pt + luma(85%)),
  inset: 6pt,
  [*Parameter*], [*Type*], [*Default*], [*Description*],
  [`exercise`], [content], [none], [Exercise content (required)],
  [`solution`], [content], [none], [Solution content],
  [`correction`], [content], [none], [Correction for teachers],
  [`id`], [string], [auto], [Unique exercise ID],
  [`margin-content`], [content], [none], [Content placed below the badge (e.g. remarks)],
  [`qr`], [string/content], [none], [QR code for the exercise box (URL string or content)],
  [`qr-sol`], [string/content], [none], [QR code for the solution box],
  [`qr-corr`], [string/content], [none], [QR code for the correction box],
  [`sol-in-corr`], [bool], [false], [If true, solution is already in correction (don't show both)],
  [`show-corr`], [bool], [false], [If true, show correction in "mixed" mode],
  [`optional`], [bool], [false], [Show the optional marker before the label],
  [`corr-given`], [bool], [false], [Show the correction-given marker (dumbbell icon)],
  [`topic`], [string], [none], [Topic metadata],
  [`level`], [string], [none], [Difficulty level],
  [`authors`], [array], [()], [Author names],
)

== `exo-define` Function

Same as `exo`, plus:

#table(
  columns: (1.2fr, 0.8fr, 0.8fr, 2fr),
  stroke: (x: none, y: 0.3pt + luma(85%)),
  inset: 6pt,
  [*Parameter*], [*Type*], [*Default*], [*Description*],
  [`optional`], [bool], [false], [Show the optional marker before the label],
  [`corr-given`], [bool], [false], [Show the correction-given marker (dumbbell icon)],
  [`competencies`], [array], [()], [Competency tags],
  [`points`], [number], [none], [Points (for exam mode)],
)

== `exo-select` Function

#table(
  columns: (1.2fr, 0.8fr, 0.8fr, 2fr),
  stroke: (x: none, y: 0.3pt + luma(85%)),
  inset: 6pt,
  [*Parameter*], [*Type*], [*Default*], [*Description*],
  [`topic`], [string], [none], [Filter by topic],
  [`level`], [string], [none], [Filter by level],
  [`author`], [string], [none], [Filter by author],
  [`competency`], [string], [none], [Filter by competency],
  [`topics`], [array], [none], [Filter by any topic],
  [`levels`], [array], [none], [Filter by any level],
  [`competencies`], [array], [none], [Filter by any competency],
  [`where`], [function], [none], [Custom filter function],
  [`renumber`], [bool], [true], [Renumber sequentially],
  [`max`], [int], [none], [Maximum exercises],
)

== `exo-setup` Function

*Display Control:*

#table(
  columns: (1.6fr, 0.8fr, 1fr, 2fr),
  stroke: (x: none, y: 0.3pt + luma(85%)),
  inset: 6pt,
  [*Parameter*], [*Type*], [*Default*], [*Description*],
  [`display`], [string], ["both"], ["ex", "sol", "both"],
  [`corr-display`], [string], ["solution"], ["solution", "correction", "mixed"],
  [`corr-loc`], [string], ["after"], ["after", "pagebreak", "end-section", "end-chapter"],
  [`sol-loc`], [string/auto], [auto], [Same values as `corr-loc`, for solutions only],
  [`exercise-label`], [string], ["Exercise"], [Label for exercises],
  [`solution-label`], [string], ["Solution"], [Label for solutions],
  [`correction-label`], [string], ["Correction"], [Label for corrections],
  [`counter-reset`], [string], ["section"], ["section", "chapter", "global"],
  [`number-prefix`], [none/str/counter/function], [none], ["heading" (level-1 heading number), a custom counter, or a function],
  [`number-separator`], [string], ["."], [Separator for chapter-prefixed numbers],
  [`show-id`], [bool], [false], [Show exercise IDs],
  [`show-competencies`], [bool], [false], [Show competency tags],
  [`draft-mode`], [bool], [false], [Show placeholders for empty content],
  [`solution-placeholder`], [content], [_To be completed_], [Placeholder text],
  [`correction-placeholder`], [content], [_To be completed_], [Placeholder text],
)

#v(0.5em)
*Visual Styling:*

#table(
  columns: (1.6fr, 0.8fr, 1fr, 2fr),
  stroke: (x: none, y: 0.3pt + luma(85%)),
  inset: 6pt,
  [*Parameter*], [*Type*], [*Default*], [*Description*],
  [`badge-style`], [string/function], ["box"], [Style: "box", "circled", "filled-circle", "rect", "filled-rect", "pill", "tag", "margin", "border-accent", "underline", "rounded-box", "header-card" -- or a custom badge function],
  [`badge-position`], [string], ["margin"], ["margin" (badge in its own left column) or "above" (badge on a header line, statement full width below)],
  [`badge-color`], [color], [black], [Color for exercise badges],
  [`solution-color`], [color], [green], [Color for solution badges],
  [`correction-color`], [color], [green], [Color for correction badges],
  [`label-font-size`], [length], [12pt], [Font size for badge labels],
  [`margin-position`], [length/auto], [auto], [Width reserved for badge column],
  [`label-extra`], [length], [1cm], [Extra space for labels in margin],
)

#v(0.5em)
*Spacing:*

#table(
  columns: (1.6fr, 0.8fr, 1fr, 2fr),
  stroke: (x: none, y: 0.3pt + luma(85%)),
  inset: 6pt,
  [*Parameter*], [*Type*], [*Default*], [*Description*],
  [`exercise-above`], [length], [0.8em], [Space above exercise boxes],
  [`exercise-below`], [length], [0.8em], [Space below exercise boxes],
  [`solution-above`], [length], [0.8em], [Space above solution boxes],
  [`solution-below`], [length], [0.8em], [Space below solution boxes],
  [`correction-above`], [length], [0.8em], [Space above correction boxes],
  [`correction-below`], [length], [0.8em], [Space below correction boxes],
  [`advanced-symbol`], [content/none], [`"*"`], [Symbol before label for advanced exercises],
  [`optional-symbol`], [content/none], [star icon], [Symbol before label for optional exercises],
  [`corr-given-symbol`], [content/none], [dumbbell icon], [Symbol before label when correction is handed out],
)

#v(0.5em)
*Difficulty, Inline Solutions, and Links:*

#table(
  columns: (1.6fr, 0.8fr, 1fr, 2fr),
  stroke: (x: none, y: 0.3pt + luma(85%)),
  inset: 6pt,
  [*Parameter*], [*Type*], [*Default*], [*Description*],
  [`difficulty-display`], [string], ["color"], ["color", "stars", "symbols", "none"],
  [`difficulty-scale`], [auto/dict], [auto], [auto = built-in 5-level scale, or dict key -> (color: .., symbol: ..)],
  [`difficulty-position`], [string], ["below"], [Stars/symbols "below" the badge or inline in the "badge"],
  [`solution-style`], [auto/string], [auto], ["inline" = epigraph-style rule instead of a badge box],
  [`inline-rule-length`], [length], [3cm], [Rule length for inline solutions],
  [`inline-label`], [auto/content/none], [auto], [Small margin label for inline solutions],
  [`link-solutions`], [bool], [false], [Clickable links to deferred corrections],
  [`link-style`], [string], ["icon"], ["icon" (arrow) or "page" ("Solution p. 30" reference)],
  [`link-icon`], [content/none], [arrow icon], [Link icon on the exercise],
  [`backlink-icon`], [content/none], [arrow icon], [Back-link icon on the correction],
  [`page-ref-format`], [auto/function], [auto], [Custom page reference: (label, page) => content],
  [`page-ref-color`], [auto/color], [auto], [Page reference color (auto = badge color)],
)

#v(0.5em)
*QR Code Settings:*

#table(
  columns: (1.6fr, 0.8fr, 1fr, 2fr),
  stroke: (x: none, y: 0.3pt + luma(85%)),
  inset: 6pt,
  [*Parameter*], [*Type*], [*Default*], [*Description*],
  [`show-qr`], [bool], [true], [Master toggle for per-exercise QR codes],
  [`qr-size`], [length], [1.5cm], [Target QR code size (shrinks to fit margin if needed)],
  [`qr-min-size`], [length], [1cm], [Minimum size; below this the QR extends into page margin],
  [`qr-color`], [color], [black], [QR module color],
  [`qr-caption`], [content/none], [none], [Small caption below every QR code],
  [`qr-position`], [string], ["auto"], ["auto" (per badge style), "wrap" (always wrap content), or "tasks" (overlay; a taskize `#tasks` body flows around it)],
)

#pagebreak()

// =============================================================================
// UTILITY FUNCTIONS
// =============================================================================

= Utility Functions

#table(
  columns: (1fr, 2fr),
  stroke: (x: none, y: 0.3pt + luma(85%)),
  inset: 6pt,
  [*Function*], [*Description*],
  [`exo-reset-counter()`], [Reset exercise numbering to 0],
  [`exo-clear-registry()`], [Clear all registered exercises],
  [`exo-get-registry()`], [Retrieve the current registry of exercise metadata (context-dependent)],
  [`exo-section-start()`], [Call at section start (triggers reset if configured)],
  [`exo-chapter-start()`], [Call at chapter start (triggers reset if configured)],
  [`exo-section-end()`], [Print solutions pending for end-of-section placement],
  [`exo-chapter-end()`], [Print solutions pending for end-of-chapter placement],
  [`exo-print-solutions()`], [Print collected solutions (for end-section/chapter modes)],
  [`exo-count(topic: ..)`], [Count exercises matching criteria],
  [`exo-show("id")`], [Display exercise by ID],
  [`exo-show-many("a", "b")`], [Display multiple exercises by ID],
  [`exo-filter(topic: ..)`], [Filter and display matching exercises],
  [`competency-tag("comp")`], [Render a single competency as a small styled pill (used internally by `show-competencies`)],
)

= Exam Integration

These functions support building exam documents from an exercise bank, typically used alongside a layout package such as `texam`.

== `exam-setup`

Configure the exam correction box appearance and behaviour.

#table(
  columns: (auto, auto, auto, 1fr),
  stroke: (x: none, y: 0.3pt + luma(85%)),
  inset: 6pt,
  [*Parameter*], [*Type*], [*Default*], [*Description*],
  [`show-solutions`], [bool], [`false`], [Show `exam-solution-box` content],
  [`solution-label`], [string], [`"Correction"`], [Label shown in bold at the top of the solution box],
  [`solution-fill`], [color], [green tint], [Background fill of the solution box],
  [`solution-stroke`], [stroke], [green stroke], [Border stroke of the solution box],
  [`solution-radius`], [length], [`3pt`], [Corner radius of the solution box],
  [`solution-inset`], [length], [`8pt`], [Inner padding of the solution box],
  [`solution-label-color`], [color], [dark green], [Color of the label text],
  [`question-spacing`], [length], [`1em`], [Vertical space between questions],
)

== `exam-solution-box`

A green-highlighted answer block. Only rendered when `exam-setup(show-solutions: true)`.

```typst
#exam-solution-box[
  $(x - 2)(x - 3)$
]
```

Place it after an exercise. The same source file produces both the student version (box hidden) and the correction (box shown) by flipping `show-solutions`.

== `exam-score-table`

Builds a score grid from registered exercise IDs, reading point values from the registry.

```typst
#exam-score-table("ex-1", "ex-2", "ex-3")
```

#table(
  columns: (auto, auto, auto, 1fr),
  stroke: (x: none, y: 0.3pt + luma(85%)),
  inset: 6pt,
  [*Parameter*], [*Type*], [*Default*], [*Description*],
  [`..exercise-ids`], [strings], [], [Positional — IDs of exercises to include],
  [`question-label`], [string], [`"Question"`], [Header for the question column],
  [`points-label`], [string], [`"Points"`], [Header for the points row],
  [`grade-label`], [string], [`"Note"`], [Header for the grade row],
  [`total-label`], [string], [`"Total"`], [Label for the total column],
)
