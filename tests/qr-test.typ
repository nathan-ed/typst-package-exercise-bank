// Visual test: QR codes in every badge style
#import "../lib.typ": *

#set page(margin: (left: 3cm, rest: 1.5cm), height: auto)
#set text(font: "New Computer Modern", size: 11pt)

#let url = "https://naths.ch/corriges/exo-42"
#let long = [Solve the following system of equations and discuss the number of solutions depending on the parameter $m$: $ cases(x + 2y = 3, m x - y = 1) $ Then sketch the two lines for $m = 2$ and check your answer graphically. #lorem(30)]
#let short = [Compute $3 + 4$.]

= Badge styles (QR below badge)

#exo-setup(badge-style: "box")
#exo(exercise: long, qr: url)
#exo(exercise: short, qr: url)

#exo-setup(badge-style: "circled")
#exo(exercise: long, qr: url)

#exo-setup(badge-style: "filled-circle", badge-color: rgb("#2563eb"))
#exo(exercise: long, qr: url)

#exo-setup(badge-style: "pill", badge-color: rgb("#059669"))
#exo(exercise: long, qr: url)
#exo(exercise: short, qr: url)

#exo-setup(badge-style: "tag", badge-color: rgb("#7c3aed"))
#exo(exercise: long, qr: url)

#pagebreak()
= Full-width styles (content wraps QR)

#exo-setup(badge-style: "margin", badge-color: rgb("#374151"))
#exo(exercise: long, qr: url)
#exo(exercise: short, qr: url)

#exo-setup(badge-style: "border-accent", badge-color: rgb("#d97706"))
#exo(exercise: long, qr: url)
#exo(exercise: short, qr: url)

#exo-setup(badge-style: "underline", badge-color: rgb("#dc2626"))
#exo(exercise: long, qr: url)

#exo-setup(badge-style: "rounded-box", badge-color: rgb("#0891b2"))
#exo(exercise: long, qr: url)

#exo-setup(badge-style: "header-card", badge-color: rgb("#4f46e5"))
#exo(exercise: long, qr: url)
#exo(exercise: short, qr: url)

#pagebreak()
= Reduced margin adaptation (pill)

#exo-setup(badge-style: "pill", margin-position: 1.2cm, label-extra: 0.5cm)
#exo(exercise: [Margin 1.2cm + extra 0.5cm: QR must shrink. #lorem(20)], qr: url)

#exo-setup(margin-position: 0.8cm, label-extra: 0.2cm)
#exo(exercise: [Margin 0.8cm + extra 0.2cm: tiny. #lorem(15)], qr: url)

#exo-setup(margin-position: auto, label-extra: 1cm)

= Caption, custom color, toggle off

#exo-setup(badge-style: "box", qr-caption: [Corrigé], qr-color: rgb("#1e3a8a"))
#exo(exercise: [With caption and blue modules. #lorem(15)], qr: url)

#exo-setup(show-qr: false)
#exo(exercise: [show-qr false: no QR should appear here. #lorem(10)], qr: url)
#exo-setup(show-qr: true, qr-caption: none, qr-color: black)

= qr-position: "wrap" (forced wrapping for any style)

#exo-setup(badge-style: "box", qr-position: "wrap")
#exo(exercise: long, qr: url)
#exo(exercise: short, qr: url)

#exo-setup(badge-style: "pill", badge-color: rgb("#059669"))
#exo(exercise: long, qr: url)

#exo-setup(badge-style: "margin", badge-color: rgb("#374151"))
#exo(exercise: long, qr: url)

#exo-setup(badge-style: "box", qr-position: "auto")

= Bank flow (exo-define / exo-show / exo-select) + solutions

#exo-define(id: "b1", exercise: [Bank exercise shown via `exo-show`. #lorem(12)], solution: [The solution has no QR.], qr: url)
#exo-show("b1")

#exo-select(where: ex => ex.id == "b1")

= QR on solutions and corrections

#exo(
  exercise: [Exercise with QR, solution with its own QR. #lorem(10)],
  solution: [Solution with a QR code linking to a video walkthrough. #lorem(15)],
  qr: url,
  qr-sol: "https://naths.ch/videos/sol-1",
)

#exo-setup(corr-display: "correction")
#exo(
  exercise: [Correction carries the QR here.],
  correction: [Detailed correction with didactical QR. #lorem(15)],
  sol-in-corr: true,
  qr-corr: "https://naths.ch/videos/corr-1",
)
#exo-setup(corr-display: "solution")

#exo-setup(badge-style: "margin")
#exo(
  exercise: [Margin style: solution box is full-width, QR wraps. #lorem(8)],
  solution: [Margin-style solution with QR wrapped in the content. #lorem(20)],
  qr-sol: "https://naths.ch/videos/sol-2",
)
#exo-setup(badge-style: "box")

#exo-define(id: "b2", exercise: [Bank exercise. #lorem(6)], solution: [Bank solution with QR. #lorem(12)], qr-sol: "https://naths.ch/videos/sol-3")
#exo-show("b2")
