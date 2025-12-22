#let mono(color: black, font: "Noto Sans Mono", it) = upper(text(
  font: font,
  fill: color,
  weight: "bold",
)[#it])
#let desc(it) = text(fill: luma(150))[#it]

#let title_block_iso7200(
  project_id: "project_id",
  scope_id: "scope_id",
  iec_61355_type: "iec_61355_type",
  doc_num: "doc_num",
  revision: "revision",
  hash: none,
  status: "status",
  creator: "creator",
  approver: "approver",
  owner: "owner",
  accent_color: rgb("#0971ce"),
  font: "Bebas Neue",
  mono_font: "Noto Sans Mono",
  issue_date: datetime.today().display(),
) = {
  let full_id = (
    "=="
      + project_id
      + if type(scope_id) == array {
        for i in scope_id { "=" + i }
      } else {
        "=" + scope_id
      }
      + "&"
      + iec_61355_type
      + "-"
      + doc_num
  )

  let entry(desc, value) = {
    set align(top)
    stack(
      spacing: 0.20em,
      text(size: 1.0em, font: font, fill: luma(150), desc),
      value,
    )
  }
  box(stroke: black, radius: 5pt, table(
    stroke: (x, y) => (
      top: if y > 0 { black },
      left: if x > 0 { black },
    ),
    columns: (20%, 20%),
    table.cell(colspan: 2, entry("REFERENCE ID", mono(
      font: mono_font,
      full_id,
    ))),
    entry("CREATOR", mono(font: mono_font, creator)),
    entry("DATE OF ISSUE", mono(font: mono_font, issue_date)),
    entry("APPROVER", mono(font: mono_font, approver)),
    entry("STATUS", mono(font: mono_font, status)),
    entry("LEGAL OWNER", mono(font: mono_font, owner)),
    entry("REVISION", mono(
      font: mono_font,
      stack(
        dir: ltr,
        spacing: 1fr,
        text(fill: luma(200), "" + hash),
        revision,
      ),
    )),
  ))
}

/********************
    TITLE PAGE
*********************/
#let title_page(
  // Title information
  issuing_dept: "issuing_dept",
  title: "title",
  document_type: "document_type",
  // Document info
  project_id: "project_id",
  scope_id: "scope_id",
  iec_61355_type: "iec_61355_type",
  doc_num: "doc_num",
  revision: "revision",
  status: "status",
  creator: "creator",
  approver: "approver",
  owner: "owner",
  issue_date: datetime.today().display(),
  hash: none,
  // Style overrides
  font: "Bebas Neue",
  mono_font: "Noto Sans Mono",
  accent_color: rgb("#0971ce"),
) = {
  context {
    set text(font: "Bebas Neue")
    set par(leading: 0.2em)
    page(
      background: align(top, box(fill: accent_color, width: 100%, height: 20%)),
      margin: 5%,
      {
        // Load logo and "place" it on the page
        // This prevents it from taking space inside the layout
        // to not affect the placement of the other elements on the page
        let logo = image("../assets/tz_white.png", height: 20%)
        place(dy: -33pt, dx: -15pt, logo)

        // Defines the section above the mid line
        let top = {
          set align(bottom + right)
          stack(
            text(size: 2.5em, issuing_dept),
            v(2em),
            text(fill: accent_color, size: 3.5em, title),
            v(.5em),
          )
        }

        // Defines the section below the mid line
        let bot = {
          set align(right)
          stack(
            v(.5em),
            text(size: 3em, document_type),
            1fr,
            align(bottom + right, title_block_iso7200(
              project_id: project_id,
              scope_id: scope_id,
              iec_61355_type: iec_61355_type,
              doc_num: doc_num,
              revision: revision,
              status: status,
              creator: creator,
              approver: approver,
              owner: owner,
              issue_date: issue_date,
              hash: hash,
            )),
          )
        }

        // Display content
        // This layout will ensure the line is
        // always at the center of the page
        grid(
          rows: (1fr, auto, 1fr),
          top,
          line(length: 100%),
          bot,
        )
      },
    )
  }
}

