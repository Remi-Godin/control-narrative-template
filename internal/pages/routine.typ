#import "../common_vars.typ": *
#import "../data_extractor.typ": *
#let mono(it) = upper(text(font: mono_font, weight: "bold")[#it])
#let sheet(
  landscape: false,
  name: "sheet_name",
  function_scope: "function_scope",
  iec_61355_type: "iec_61355_type",
  product: "1",
  creator: "creator",
  approver: "approver",
  it,
) = {
  let entry(desc, value) = {
    stack(
      spacing: 0.20em,
      text(size: 0.8em, font: title_font, fill: luma(150), desc),
      text(size: 0.8em, fill: black, mono(value)),
    )
  }

  let function_id = str(
    "=="
      + operational_scope
      + "="
      + system_scope
      + if type(function_scope) == array {
        "=" + function_scope.join("=")
      } else if function_scope != none {
        "=" + function_scope
      }
      + "&"
      + iec_61355_type
      + "-"
      + product,
  )

  let info_table = align(right, table(
    fill: none,
    rows: 4,
    columns: (auto, 3fr, 2fr),
    table.cell(colspan: 1, rowspan: 4, align(center + horizon, image(
      "../assets/tz.png",
      height: 8em,
    ))),
    table.cell(colspan: 1, align(right, entry(
      "SHEET NAME",
      name,
    ))),
    table.cell(colspan: 1, align(right, entry("FUNCTION ID", function_id))),
    entry("CREATOR", creator),
    entry("DATE OF ISSUE", issue_date),
    entry("APPOVER", approver),
    entry("STATUS", mono(status)),
    entry("LEGAL OWNER", owner),
    entry("REVISION", mono(
      stack(
        dir: ltr,
        spacing: 1fr,
        text(fill: luma(200), "" + hash),
        revision,
      ),
    )),
  ))

  page(
    flipped: landscape,
    margin: 40pt,
  )[
    #block(height: 0pt, below: 0pt)[
      #hide(heading(level: 2, name))
    ]
    #show heading.where(level: 2): it => {
      text(size: 0.8em, it.body)
    }
    #figure(grid(
      rows: (1fr, auto),
      box(
        inset: 10pt,
        stroke: (top: black, left: black, right: black),
        width: 100%,
        height: 100%,
        it,
      ),
      info_table,
    )) #label(function_id)
  ]
}
