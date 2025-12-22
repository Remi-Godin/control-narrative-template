#let heading_rule_3(
  accent_color: rgb("#0971ce"),
  it,
) = {
  let body = it.body
  let num = numbering(it.numbering, ..counter(heading).get())
  set text(size: 1.3em, fill: white)
  set par(justify: true, hanging-indent: 0pt, first-line-indent: (
    amount: 0pt,
    all: true,
  ))
  block(
    width: 100%,
    inset: 0.3em,
    fill: accent_color,
    stack(
      dir: ltr,
      spacing: 1em,
      num,
      body,
    ),
  )
}
