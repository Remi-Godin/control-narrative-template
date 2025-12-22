#import "../common_vars.typ": *
#let heading_rule_4(
  it,
) = {
  let body = it.body
  let num = numbering(it.numbering, ..counter(heading).get())
  grid(
    columns: (auto, auto),
    column-gutter: 0.5em,
    strong(text(fill: accent_color, num)), align(horizon, body),
  )
}
