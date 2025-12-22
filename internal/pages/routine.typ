#let mono(it) = upper(text(font: "DejaVu Sans", weight: "bold")[#it])
#let routine(
  landscape: false,
  function_id: "function_id",
  doctype: "doctype",
  docnum: "docnum",
  creator: "creator",
  approver: "approver",
  issue_date: "issue_data",
  legal_owner: "legal_owner",
  revision: none,
  hash: none,
  it,
) = {
  let metadata = json("../../metadata.json")
  let full_id = (
    "=" + function_id + "&" + doctype + "-" + str(docnum)
  )

  let entry(desc, value) = {
    stack(
      spacing: 0.20em,
      text(size: 0.8em, font: "Bebas Neue", fill: luma(150), desc),
      text(size: 0.8em, mono(value)),
    )
  }

  let image_width = if landscape {
    12.7%
  } else {
    8.4%
  }
  page(
    flipped: landscape,
    margin: 40pt,
  )[
    #grid(
      rows: (1fr, auto),
      box(
        inset: 10pt,
        stroke: (top: black, left: black, right: black),
        width: 100%,
        height: 100%,
        it,
      ),
      align(right, table(
        rows: 4,
        columns: (auto, 1fr, 1fr),
        table.cell(colspan: 1, rowspan: 4, align(center + horizon, image(
          "../assets/tz.png",
          height: image_width,
        ))),
        table.cell(colspan: 2, entry("FUNCTION_ID", full_id)),
        entry("CREATOR", creator),
        entry("DATE OF ISSUE", issue_date),
        entry("APPOVER", approver),
        entry("STATUS", mono(metadata.at("status"))),
        entry("LEGAL OWNER", legal_owner),
        entry("REVISION", mono(
          stack(
            dir: ltr,
            spacing: 1fr,
            text(fill: luma(200), "" + metadata.at("hash")),
            metadata.at("rev"),
          ),
        )),
      )),
    )
  ]
}
