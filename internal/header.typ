#import "data_extractor.typ": *
#let header = context {
  set text(fill: luma(100))
  let q1 = query(selector(heading.where(level: 1)))
  let pages = q1.map(q => { q.location().page() })
  if pages.contains(here().page()) {
    none
  } else {
    let q2 = query(selector(heading.where(level: 1)).before(here()))
    if q2.len() != 0 {
      grid(
        rows: 1fr,
        inset: (top: 20pt),
        align: top,
        columns: (auto, 1fr, auto),
        title, none, (q2.last().supplement, q2.last().body).join(": "),
      )
    }
  }
}
