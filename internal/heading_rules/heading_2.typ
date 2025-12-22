#let heading_rule_2(
  title_font: "Bebas Neue",
  accent_color: rgb("#0971ce"),
  it,
) = {
  let body = it.body
  let num = numbering(it.numbering, ..counter(heading).get())
  set text(size: 1.7em, font: title_font)
  stack(
    spacing: 0.5em,
    grid(
      columns: (10%, 2%, 1fr),
      align(center + horizon, num), none, align(bottom, body),
    ),
    {
      place(line(length: 100%, stroke: accent_color + 3pt))
      place(dx: 10%, line(length: 90%, stroke: luma(200) + 3pt))
    },
  )
}
