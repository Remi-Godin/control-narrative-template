#import "./pages/title_page.typ": *
#import "heading_rules/heading_1.typ": *
#import "heading_rules/heading_2.typ": *
#import "heading_rules/heading_3.typ": *
#import "heading_rules/heading_4.typ": *
#import "footer.typ": *
#import "./pages/preface.typ": *

#let narrative(
  // Title information
  issuing_dept: "issuing_dept",
  title: "title",
  document_type: "document_type",
  // Document info
  project_id: "project_id",
  scope_id: "scope_id",
  iec_61355_type: "iec_61355_type",
  doc_num: "doc_num",
  status: "draft",
  creator: "creator",
  approver: "approver",
  owner: "owner",
  revision: "revision",
  extract_metadata: true,
  // Style overrides
  title_font: "Bebas Neue",
  body_font: "Roboto",
  mono_font: "Noto Sans Mono",
  accent_color: rgb("#0971ce"),
  doc,
) = {
  title_page(
    issuing_dept: issuing_dept,
    title: title,
    document_type: document_type,
    project_id: project_id,
    scope_id: scope_id,
    iec_61355_type: iec_61355_type,
    doc_num: doc_num,
    status: status,
    creator: creator,
    approver: approver,
    owner: owner,
    font: title_font,
    mono_font: mono_font,
    accent_color: accent_color,
    revision: revision,
  )

  set page(background: rotate(-45deg, text(
    size: 15em,
    "DRAFT",
    luma(230),
  ))) if status == "draft"

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
  set page(numbering: "i", margin: 60pt, footer: footer(
    doc_id: full_id,
    body_font: body_font,
    title_font: title_font,
    legal_owner: owner,
  ))
  set par(justify: true)
  set text(font: body_font)
  set underline(offset: 1.5pt)
  set heading(numbering: "1-1-1-A-I")

  show figure: it => {
    box(
      inset: 1em,
      width: 100%,
      it.body,
    )
    v(-0.8em)
    emph(it.caption)
    v(0.2em)
  }
  outline(title: none)

  show heading.where(level: 1): it => heading_rule_1(
    accent_color: accent_color,
    title_font: title_font,
    it,
  )
  show heading.where(level: 2): it => heading_rule_2(
    accent_color: accent_color,
    title_font: title_font,
    it,
  )
  show heading.where(level: 3): it => heading_rule_3(
    accent_color: accent_color,
    it,
  )
  show heading.where(level: 4): it => heading_rule_4(
    accent_color: accent_color,
    it,
  )

  show raw.line: it => {
    set text(fill: orange.darken(10%)) if it
      .fields()
      .at("text")
      .starts-with("x")
    it
  }
  set list(
    indent: 20pt,
    body-indent: 10pt,
  )
  set enum(
    indent: 20pt,
    body-indent: 10pt,
    numbering: "(i-1-a-i)",
    number-align: left,
  )

  set footnote(numbering: " [1]")
  show footnote.entry: it => {
    let num = numbering(
      it.note.numbering,
      ..counter(footnote).at(it.note.location()),
    )
    let body = it.note.body
    num + h(1em) + body
  }

  preface_page(
    operational_scope: project_id,
    system_scope: scope_id,
    iec_61355_type: iec_61355_type,
    doc_num: doc_num,
  )


  doc
}
