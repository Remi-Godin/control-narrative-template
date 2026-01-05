/*
    This section contains any functions or content that can be used to display different things in the document.
    These functions are meant to be used to display things directly in the document by wrapping them, as opposed
    to being rules.
*/
#import "/internal/common_vars.typ": *

/***********************
    TEXTBOX WRAPPER
***********************/

// Wraps the content in a textbox with the given data
#let textbox(icon, name, content, col) = {
  figure(
    kind: name,
    supplement: name,
    {
      set par(justify: true, hanging-indent: 0pt, first-line-indent: (
        amount: 0pt,
        all: true,
      ))
      v(0.3em)
      block(
        layout(size => {
          let note = box(
            width: size.width,
            stroke: col,
            radius: 0.5em,
            inset: 1.5em,
            content,
          )
          let header = {
            stack(
              dir: ltr,
              spacing: 0.3em,
              icon,
              align(
                horizon,
                text(
                  fill: col,
                  size: 1.2em,
                  name
                    + " "
                    + context { counter(figure.where(kind: name)).display() },
                ),
              ),
            )
          }
          note
          context {
            let m = measure(note)
            place(
              dy: -m.height - 1em,
              dx: 1em,
              box(
                fill: white,
                inset: (left: 0.4em, right: 0.4em),
                height: 2em,
                header,
              ),
            )
          }
        }),
      )
    },
  )
}

#let note(content) = {
  let col = accent_color
  let icon = circle(
    stroke: col + 2pt,
    radius: 1em,
    align(center + horizon, text(fill: col, size: 1.2em, weight: 700, "!")),
  )
  textbox(icon, "Note", content, col)
}

#let important(content) = {
  let col = purple
  let icon = circle(
    stroke: col + 2pt,
    radius: 1em,
    align(center + horizon, text(fill: col, size: 1.2em, weight: 700, "!")),
  )
  textbox(icon, "Important", content, col)
}

#let warn(content) = {
  let col = orange
  let icon = circle(
    stroke: col + 2pt,
    radius: 1em,
    align(center + horizon, text(fill: col, size: 1.2em, weight: 700, "!")),
  )
  textbox(icon, "Warning", content, col)
}

#let danger(content) = {
  let col = red
  let icon = circle(
    stroke: col + 2pt,
    radius: 1em,
    align(center + horizon, text(fill: col, size: 1.2em, weight: 700, "!")),
  )
  textbox(icon, "Danger", content, col)
}

#let incomplete(content) = {
  let col = red
  let icon = circle(
    stroke: col + 2pt,
    radius: 1em,
    align(center + horizon, text(fill: col, size: 1.2em, weight: 700, "!")),
  )
  textbox(icon, "Incomplete", content, col)
}

#let question(content) = {
  let col = purple
  let icon = circle(
    stroke: col + 2pt,
    radius: 1em,
    align(center + horizon, text(fill: col, size: 1.5em, weight: 700, "?")),
  )
  textbox(icon, "Question", content, col)
}

#let draft(doc) = {
  set page(background: rotate(45deg, text(
    size: 15em,
    fill: luma(240),
    "DRAFT",
  )))
  doc
}

/***********************
        BLOCKS
***********************/
#let broken-block(col, stroke, supplement, title, content) = layout(bounds => {
  let width = measure(..bounds, block(content)).width

  // I'm using a block here instead of a line so that a
  // possible `show line: set block(spacing: ..)` rule
  // doesn't interfere with the spacing set to this block.
  let line = block.with(
    height: stroke.thickness / 2,
    width: 100%,
    fill: col,
    stroke: stroke,
    sticky: true,
  )
  let title_stack = stack(
    grid(
      columns: (auto, auto),
      column-gutter: 0.2em,
      align: bottom,
      text(font: title_font, fill: col, size: 1.2em, supplement),
      text(
        font: body_font,
        fill: col.darken(2%),
        title,
      ),
    ),
    v(1em),
  )
  let top_space = 1em
  if (supplement == none) and (title == none or title.len() == 0) {
    title_stack = none
    top_space = 1em
  }

  line(below: stroke.thickness / 2)
  block(
    width: 100%,
    fill: col.transparentize(92%),
    inset: (top: top_space, x: 1em, bottom: 1em),
    stroke: (x: stroke),
    stack(
      title_stack,
      content,
    ),
  )
  line(above: stroke.thickness / 2)
})

#let conditional(name, content) = {
  let col = orange
  broken-block(col, col + 1pt, "Conditional:", name, content)
}

#let faults(content) = {
  let col = red
  broken-block(col, col + 1pt, "faults", none, content)
}

#let safety(name, content) = {
  let col = red
  broken-block(col, col + 1pt, name, none, content)
}

#let operations(name, content) = {
  let col = purple
  broken-block(col, col + 1pt, name, none, content)
}

#let utilities(name, content) = {
  let col = orange
  broken-block(col, col + 1pt, name, none, content)
}

#let alerts(content) = {
  let col = orange
  broken-block(col, col + 1pt, "alerts", none, content)
}

#let events(content) = {
  let col = purple
  broken-block(col, col + 1pt, "events", none, content)
}

#let internal(name, content) = {
  let col = rgb("#0971ce")
  broken-block(col, col + 1pt, name, none, content)
}

#let concurrent = {
  set line(length: 100%, stroke: accent_color)
  set text(fill: accent_color)
  grid(
    align: horizon,
    columns: (1fr, auto, 1fr),
    column-gutter: 1em,
    line(), text(size: 1.2em, font: title_font, "and"), line(),
  )
}

#let otherwise = {
  set line(length: 100%, stroke: orange)
  set text(fill: orange)
  grid(
    align: horizon,
    columns: (1fr, auto, 1fr),
    column-gutter: 1em,
    line(), text(size: 1.2em, font: title_font, "else"), line(),
  )
}

#let check(target, content) = {
  box({
    content
    box(width: 1fr, repeat("."))
    sym.wj // prevent a page number on the new line without fill
    strong(upper(text(fill: red, target)))
  })
}

#let ok(content) = grid(check([OK], content))

#let permissives(safety, utility, operational) = {
  if type(safety) != array {
    safety = (safety, none)
  }
  if type(utility) != array {
    utility = (utility, none)
  }
  if type(operational) != array {
    operational = (operational, none)
  }
  let row_count = 1
  if safety != none {
    row_count = safety.len()
  }
  if utility != none {
    if utility.len() > row_count {
      row_count = utility.len()
    }
  }
  if operational != none {
    if operational.len() > row_count {
      row_count = operational.len()
    }
  }
  figure(
    table(
      columns: (1fr, 1fr, 1fr),
      rows: row_count,
      table.header(
        table.cell(fill: red, "Level 1"),
        table.cell(fill: orange, "Level 2"),
        table.cell(fill: purple, "Level 3"),
      ),
      ..for i in range(row_count) {
        (
          if safety != none {
            if i < safety.len() {
              if safety.at(i) != none {
                ref(label(str(safety.at(i))))
              }
            } else []
          } else { none },
          if utility != none {
            if i < utility.len() {
              if utility.at(i) != none {
                ref(label(str(utility.at(i))))
              }
            } else []
          },
          if operational != none {
            if i < operational.len() {
              if operational.at(i) != none {
                ref(label(str(operational.at(i))))
              }
            } else []
          },
        )
      },
    ),
  )
}

