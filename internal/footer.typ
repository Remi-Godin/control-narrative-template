#let footer(
  title_font: "Bebas Neue",
  body_font: "Nimbus Sans",
  mono_font: "Noto Sans Mono",
  doc_id: "doc_id",
  legal_owner: "legal_owner",
  revision: "revision",
  status: "status",
  creator: "creator",
  approver: "approver",
  owner: "owner",
  accent_color: rgb("#0971ce"),
) = {
  context {
    set par(justify: false)
    let title = [#legal_owner #sym.copyright #datetime.today().year()]

    let page = text(font: title_font, str(numbering(
      page.numbering,
      counter(page).get().at(0),
    )))
    let page_disp = grid(
      inset: 3pt,
      columns: (auto, auto, auto),
      align(horizon, line(stroke: blue)),
      page,
      align(horizon, line(stroke: blue)),
    )
    set align(horizon)
    grid(
      columns: (1fr, auto, 1fr),
      title, page_disp, align(right, text(font: mono_font, doc_id)),
    )
  }
}
