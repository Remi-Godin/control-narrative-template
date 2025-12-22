#let heading_rule_4(
  accent_color: rgb("#0971ce"),
  it,
) = {
  let accent_color = rgb("#0971ce")
  let body = it.body
  let num = numbering(it.numbering, ..counter(heading).get())
  grid(
    columns: (auto, auto),
    column-gutter: 0.5em,
    strong(text(fill: accent_color, num)), align(horizon, body),
  )
}
