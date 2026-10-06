#import "../lib.typ": *
#set page(width: 18cm, height: auto, margin: 1cm)
#exo-setup(display: "ex", exercise-label: "Exercise", number-prefix: none)
#let styles = ("box", "circled", "filled-circle", "rect", "filled-rect", "pill", "tag", "margin", "border-accent", "underline", "rounded-box", "header-card")
#for style in styles {
  exo-setup(badge-style: style)
  exo(id: style, exercise: [A statement.], qr: rect(width: 1cm, height: 1cm, fill: black))
  [See #exo-cite(style, show-page: false). #parbreak()]
}
#exo-setup(badge-style: (label, number, font-size, color, is-solution) => [#label #number])
#exo(id: "custom", exercise: [Custom badge, rendering the provided number.])
#exo-cite("custom", show-page: false)
#context {
  let anchors = query(<_exb-reference>)
  assert.eq(anchors.len(), 13)
  for id in styles + ("custom",) {
    assert.eq(anchors.filter(it => it.value.id == id).len(), 1)
  }
}
