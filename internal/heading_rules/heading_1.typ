#import "../common_vars.typ": *
#let heading_rule_1(
  it,
) = {
  pagebreak()
  context {
    let body = it.body
    let num = if it.numbering == none {
      "0"
    } else {
      numbering(it.numbering, ..counter(heading).get())
    }
    let num_size = 8em
    let body_display = {
      set text(font: title_font)
      box(
        height: 100%,
        width: 72%,
        inset: 4pt,
        align(bottom + right, text(size: 1.8em, body)),
      )
    }
    let num_display = {
      set text(font: title_font, fill: accent_color)
      place(circle(stroke: accent_color + 5pt, radius: 4em, text(
        size: 5em,
        align(center + horizon, num),
      )))
      place(dy: 4pt, dx: 4pt, circle(
        fill: accent_color,
        stroke: accent_color + 5pt,
      ))
    }
    show outline.entry: it => outline_rule_1(it)
    box(height: 16%, width: 100%)[
      #place(dx: 28%, body_display)
      #place(num_display)
    ]
    v(1em)
    line(length: 100%, stroke: accent_color + 10pt)
    grid(
      columns: (20%, 1fr),
      none,
      {
        set text(size: 0.8em)
      },
    )
  }
}
