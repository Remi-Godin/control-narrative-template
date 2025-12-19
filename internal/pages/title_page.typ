#let mono(it) = text(font: "Noto Sans Mono", fallback: true, raw(it))
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
    "==" + project_id + " =" + scope_id + " &" + iec_61355_type + " -" + doc_num
  )

  block(width: 100mm, stroke: 0.5pt, inset: 0pt, {
    set text(size: 7pt, font: "DejaVu Sans") // Standards usually prefer sans-serif
    set table(stroke: 0.5pt, inset: 4pt)

    table(
      columns: (auto, auto, auto, 8em),
      rows: auto,
      table.cell(colspan: 3)[],
      stack(dir: ttb, spacing: 0.4em, desc("PROJECT"), stack(
        dir: ltr,
        spacing: 1fr,
        "==",
        project_id,
      )),
      table.cell(colspan: 3)[],
      stack(dir: ttb, spacing: 0.4em, desc("FUNCTION"), stack(
        dir: ltr,
        spacing: 1fr,
        "=",
        scope_id,
      )),
      table.cell(colspan: 3)[],
      stack(dir: ttb, spacing: 0.4em, desc("DOC TYPE"), stack(
        dir: ltr,
        spacing: 1fr,
        "&",
        iec_61355_type,
      )),
      table.cell(colspan: 3)[],
      stack(dir: ttb, spacing: 0.4em, desc("DOC NUM"), stack(
        dir: ltr,
        spacing: 1fr,
        align(left, sym.dash),
        doc_num,
      )),
    )

    table(
      columns: (30mm, 20mm, 25mm, 25mm),
      rows: (auto, auto, auto),

      // Row 1: Identification Number (The 81346 Full String)
      table.cell(colspan: 3)[
        #desc([IDENTIFICATION NUMBER (ISO 81346)]) \
        #text(size: 1.4em, weight: "bold", mono(full_id))
      ],
      [
        #desc([REVISION]) \
        #text(size: 1.4em, weight: "bold", mono(revision))
      ],

      // Row 2: Document Type and Status
      table.cell(colspan: 2)[
        #desc([DOCUMENT TYPE (IEC 61355)]) \
        Control Narrative (&EFE)
      ],
      table.cell(colspan: 2, align: center)[
        #desc([LEGAL OWNER]) \
        #text(size: 8pt, weight: "bold", owner)
      ],

      // Row 3: Workflow
      [
        #text(size: 5pt, gray)[CREATOR] \
        #creator
      ],
      [
        #text(size: 5pt, gray)[APPROVED] \
        #approver
      ],
      table.cell(colspan: 2)[
        #text(size: 5pt, gray)[DATE OF ISSUE] \
        #datetime.today().display()
      ],
    )
  })
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

