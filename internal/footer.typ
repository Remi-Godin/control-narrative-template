#import "data_extractor.typ": *
#import "common_vars.typ": *

#let footer = {
  context {
    set text(size: 0.9em, fill: luma(100))
    set par(justify: false)
    let copyright = [#owner #sym.copyright #datetime.today().year()]

    let left_section = {
      stack(
        dir: ltr,
        spacing: 1fr,
        copyright,
        text(size: 1em, "Build hash: " + hash),
      )
    }

    let page = text(font: title_font, str(numbering(
      page.numbering,
      counter(page).get().at(0),
    )))
    let page_disp = grid(
      inset: 3pt,
      columns: (auto, auto, auto),
      align(horizon, line(stroke: blue)),
      text(size: 1.3em, fill: black, page),
      align(horizon, line(stroke: blue)),
    )
    let right_section = {
      stack(
        dir: ltr,
        spacing: 1fr,
        text(size: 1em, font: mono_font, full_id),
        text(size: 1em, "Revision: " + revision),
      )
    }
    set align(horizon)
    grid(
      columns: (1fr, auto, 1fr),
      column-gutter: 1em,
      align(left, left_section), page_disp, align(right, right_section),
    )
  }
}
