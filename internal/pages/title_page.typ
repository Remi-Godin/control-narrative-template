

/********************
    TITLE PAGE
*********************/
#import "../common_vars.typ": *
#import "../data_extractor.typ": *
#import "../title_blocks.typ": *
#let title_page = {
  context {
    set text(font: title_font)
    set par(leading: 0.2em)
    page(
      paper: small_paper_size,
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
            align(bottom + right, title_block_iso7200),
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

