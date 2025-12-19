#import "./internal/pages/title_page.typ": *
#import "./internal/pages/routine.typ": *

#let formatting(it) = {
  set heading(numbering: "1-1-1-A-I")
  set page(numbering: "1")
  set text(font: "FreeSans")
  it
}
