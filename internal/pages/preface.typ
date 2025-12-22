#let mono(it) = upper(text(font: "DejaVu Sans", weight: "bold")[#it])
#let id_legend(
  operational_scope: none,
  system_scope: none,
  iec_61355_type: none,
  doc_num: none,
) = {
  set align(center)
  grid(
    columns: (auto, auto, 1em, auto, 1em, auto, 1em, auto),
    rows: 5,
    inset: 0.5em,
    stroke: (x, y) => (
      bottom: if (y == 0 and (1, 3, 5, 7).contains(x))
        or y == 1 and x < 1
        or y == 2 and x < 3
        or y == 3 and x < 5
        or y == 4 and x < 7 { black },
      left: if (y == 1 and x == 1)
        or (y > 0 and y < 3 and x == 3)
        or (y > 0 and y < 4 and x == 5)
        or (y > 0 and y < 5 and x == 7) { black },
    ),
    none,
    mono("==") + text(weight: "bold", mono(operational_scope)),
    none,
    mono("=") + text(weight: "bold", mono(system_scope)),
    none,
    mono("&") + text(weight: "bold", mono(iec_61355_type)),
    none,
    mono("-") + text(weight: "bold", mono(doc_num)),

    align(left, "Operational Scope"), none, none, none, none, none, none, none,
    align(left, "System Scope"), none, none,

    none, none, none, none,

    none, align(left, "IEC 61355 Type"), none, none, none, none, none, none,
    none, align(left, "Document Number"), none, none, none, none, none,

    none, none,
  )
  v(1em)
}

#let preface_page(
  operational_scope: none,
  system_scope: none,
  iec_61355_type: none,
  doc_num: none,
) = {
  [
    #show table.cell: it => {
      set align(left) if it.x > 0 and it.y > 0
      it
    }
    = Preface

    == Standards
    This document attempts to follow the following standards:


    === IEC 81345
    The IEC 81345 standard provides a structure to create identifiers using aspects.
    #figure(caption: "IEC 81345 aspects.", table(
      columns: (1fr, 4fr),
      table.header(strong("Aspect"), strong("Description")),
      "==", "Functional (High level).",
      "=", "Functional.",
      "&", "Document kind.",
      "+", "Location.",
      "-", "Product.",
      "#", "Number.",
      "%", "Type.",
    ))
    This documents is identified using the following scheme:
    #figure(caption: "Document reference ID description", id_legend(
      operational_scope: operational_scope,
      system_scope: system_scope,
      iec_61355_type: iec_61355_type,
      doc_num: doc_num,
    ))
    Sequences and routines will use a similar format.
    === IEC 61355
    The #link("https://en.wikipedia.org/wiki/IEC_61355", text(fill: blue, "IEC 61355")) standard provides categorization for document types. Among others, the following types may be used within this document:

    #figure(
      caption: "Non-exhaustive lists of document types used within this document.",
      table(
        columns: (1fr, 4fr),
        table.header(strong("Code"), strong("Description")),
        "EFE", "Function descriptions.",
        "EFA", "Functional overview diagrams.",
        "EFF", "Function diagrams.",
        "EFB", "Flow diagrams.",
        "EFP", "Signal list.",
        "EFQ", "Setting list.",
      ),
    )

    === ISO 7200
    The ISO 7200 document provides guidelines on title blocks of document.

    ==== Notice of non-compliance
    This document does not aim to be fully compliant with ISO 7200. Efforts will be made to include the necessary information as define by the standard, but this document does not aim to comply with any formatting constraints.

    === RFC 2119
    The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL
    NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED",  "MAY", and
    "OPTIONAL" in this document are to be interpreted as described in #link("https://www.rfc-editor.org/rfc/rfc2119", text(fill: blue, "RFC 2119")).

  ]
}
