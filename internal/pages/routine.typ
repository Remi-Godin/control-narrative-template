#let mono(it) = upper(text(font: "JetBrains Mono", weight: "bold")[#it])
#let routine(
  landscape: false,
  function_id: "function_id",
  doctype: "doctype",
  docnum: "docnum",
  creator: "creator",
  approver: "approver",
  date_of_issue: "date_of_issue",
  legal_owner: "legal_owner",
  it,
) = {
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
      box(inset: 5pt, stroke: (top: black, left: black, right: black), width: 100%, height: 100%, it),
      align(right, table(
        rows: auto,
        columns: (auto, 1fr, 1fr),
        table.cell(colspan: 1, rowspan: 3, align(center + horizon, image("../assets/tz.png", height: image_width))),
        table.cell(colspan: 2, entry("FUNCTION_ID", full_id)),
        entry("CREATOR", creator),
        entry("DATE OF ISSUE", date_of_issue),
        entry("APPOVER", approver),
        entry("LEGAL OWNER", legal_owner),
      )),
    )
  ]
}
