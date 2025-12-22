#import "data_extractor.typ": *
#import "common_vars.typ": *


#let mono(color: black, font: mono_font, it) = upper(text(
  font: font,
  fill: color,
  weight: "bold",
)[#it])
#let desc(it) = text(fill: luma(150))[#it]

#let title_block_iso7200 = {
  let full_id = (
    "=="
      + operational_scope
      + if type(system_scope) == array {
        for i in system_scope { "=" + i }
      } else {
        "=" + system_scope
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
      text(size: 1.0em, font: title_font, fill: luma(150), desc),
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
