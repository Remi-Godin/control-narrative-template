#let mono(it) = upper(text(font: "JetBrains Mono", weight: "bold")[#it])
#let desc(it) = text(fill: luma(150))[#it]

#let title_block_iso7200(
  project_id: "project_id",
  scope_id: "scope_id",
  iec_61355_type: "iec_61355_type",
  doc_num: "doc_num",
  revision: "revision",
  status: "status",
  creator: "creator",
  approver: "approver",
  owner: "owner",
) = {
  let full_id = (
    "==" + project_id + "=" + scope_id + "&" + iec_61355_type + "-" + doc_num
  )

  let entry(desc, value) = {
    set align(top)
    stack(
      spacing: 0.20em,
      text(size: 1.0em, font: "Bebas Neue", fill: luma(150), desc),
      value,
    )
  }
  table(
    columns: (20%, 20%),
    table.cell(colspan: 2, entry("REFERENCE ID", mono(full_id))),
    entry("CREATOR", mono(creator)),
    entry("DATE OF ISSUE", mono(datetime.today().display())),
    entry("APPROVER", mono(approver)),
    entry("REVISION", mono(sys.inputs.at("revision", default: "DRAFT"))),
    table.cell(colspan: 2, entry("LEGAL OWNER", mono(owner))),
  )
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
  // Style overrides
  font: "Bebas Neue",
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

