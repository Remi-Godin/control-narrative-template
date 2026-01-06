#import "./pages/title_page.typ": *
#import "heading_rules/heading_1.typ": *
#import "heading_rules/heading_2.typ": *
#import "heading_rules/heading_3.typ": *
#import "heading_rules/heading_4.typ": *
#import "footer.typ": *
#import "header.typ": *
#import "./pages/preface.typ": *
#import "common_vars.typ": *
#import "data_extractor.typ": *

#let tag(it) = {
  text(font: mono_font, weight: "bold", fill: blue, it)
}

#let preface(doc) = {
  counter(heading).update(0)
  set heading(
    numbering: (..nums) => {
      "P" + nums.pos().map(str).join("-")
    },
  )
  set heading(supplement: "Preface")
  doc
}


#let main(doc) = {
  counter(heading).update(0)
  set heading(numbering: "1-1", supplement: "Section")
  set page(numbering: "1")
  counter(page).update(1)
  doc
}

#let narrative(
  doc,
) = {
  title_page

  set page(background: rotate(-45deg, text(
    size: 15em,
    "DRAFT",
    luma(230),
  ))) if upper(status) == "DRAFT"

  set page(
    paper: small_paper_size,
    numbering: "i",
    margin: 60pt,
    footer: footer,
    header: header,
  )
  set par(justify: true)
  set text(font: body_font)
  set underline(offset: 1.5pt)
  set heading(numbering: "1-1-1-A-I")

  show figure: it => {
    set align(left)
    box(
      width: 100%,
      it.body,
    )
    set align(center)
    if it.caption != none {
      v(-0.8em)
      emph(it.caption)
      v(0.2em)
    }
  }
  show outline.entry: it => {
    if it.level == 1 {
      set text(size: 1.3em, weight: "bold", fill: accent_color)
      block(sticky: true, v(0.7em) + it)
    } else if it.level == 2 {
      set text(size: 1.0em, weight: "bold")
      it
    } else {
      it
    }
  }

  outline(title: none)

  show heading.where(level: 1): it => heading_rule_1(it)
  show heading.where(level: 2): it => heading_rule_2(it)
  show heading.where(level: 3): it => heading_rule_3(it)
  show heading.where(level: 4): it => heading_rule_4(it)

  show regex("param\d+"): it => {
    text(font: mono_font, weight: "bold", fill: purple, it)
  }

  show regex("\b\w+:param\d+\b"): it => {
    text(font: mono_font, weight: "bold", fill: purple, it)
  }

  show raw.line: it => {
    set text(fill: orange.darken(10%)) if it
      .fields()
      .at("text")
      .starts-with("x")
    it
  }

  show ref: it => {
    if it.element == none { text(fill: red, "ERROR") } else if (
      it.element.func() == heading
    ) {
      underline(link(it.location(), it.element.body))
    } else {
      underline(link(it.location(), str(it.element.label)))
    }
  }


  set list(
    indent: 20pt,
    body-indent: 10pt,
  )
  set enum(
    indent: 10pt,
    body-indent: 10pt,
    numbering: "(i-1-a-i)",
    number-align: left,
  )

  set table(fill: (x, y) => {
    if y == 0 {
      accent_color
    }
  })

  show table.cell: it => {
    if it.y == 0 {
      set text(white)
      align(center, strong(it))
    } else {
      it
    }
  }


  set footnote(numbering: " [1]")
  show footnote.entry: it => {
    let num = numbering(
      it.note.numbering,
      ..counter(footnote).at(it.note.location()),
    )
    let body = it.note.body
    num + h(1em) + body
  }

  show: preface
  {
    show heading.where(level: 2): set heading(outlined: false)
    show heading.where(level: 3): set heading(outlined: false)
    show heading.where(level: 4): set heading(outlined: false)
    show heading.where(level: 5): set heading(outlined: false)
    set list(marker: (sym.bullet.o, sym.bullet.stroked))
    include "../changelog.typ"
  }

  preface_page


  show: main
  doc
}
