#import "../common_vars.typ": *
#import "../data_extractor.typ": *
#let mono(it) = upper(text(font: mono_font, weight: "bold")[#it])
#let routine(
  landscape: false,
  function_scope: "function_scope",
  iec_61355_type: "iec_61355_type",
  doc_num: 1,
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
    "="
      + if type(function_scope) == array {
        function_scope.join("=")
      } else {
        function_scope
      }
      + "&"
      + iec_61355_type
      + "-"
      + str(doc_num),
  )

  // let image_height = if landscape {
  //   17.4%
  // } else {
  //   11.8%
  // }
  page(
    flipped: landscape,
    margin: 40pt,
  )[

    #figure(grid(
      rows: (1fr, auto),
      box(
        inset: 10pt,
        stroke: (top: black, left: black, right: black),
        width: 100%,
        height: 100%,
        it,
      ),
      align(right, table(
        fill: none,
        rows: 4,
        columns: (auto, 1fr, 1fr),
        table.cell(colspan: 1, rowspan: 4, align(center + horizon, image(
          "../assets/tz.png",
          height: 8em,
        ))),
        table.cell(colspan: 2, align(right, entry("FUNCTION_ID", function_id))),
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
      )),
    )) #label(function_id)//.replace("=", "").replace("&", ""))
  ]
}
