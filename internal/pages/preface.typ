#import "../data_extractor.typ": *
#import "../common_vars.typ": *

#let mono(it) = upper(text(font: mono_font, weight: "bold")[#it])
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
    none, align(left, "Product Type & Number"), none, none, none, none, none,

    none, none,
  )
  v(1em)
}

#let preface_page = {
  [
    #show table.cell: it => {
      set align(left) if it.x > 0 and it.y > 0
      it
    }
    = Standards
    This document attempts to follow the following standards:


    == IEC 81345
    The IEC 81345 standard provides a structure to create identifiers using aspects.
    #figure(caption: "IEC 81345 aspects.", table(
      columns: (1fr, 4fr),
      align: (x, y) => if x == 0 or y == 0 { center } else { left },
      table.header(strong("Aspect"), strong("Description")),
      strong("=="), "Functional (High level).",
      strong("="), "Functional.",
      strong("&"), "Document kind.",
      strong("+"), "Location.",
      strong("-"), "Product.",
      strong("#"), "Number.",
      strong("%"), "Type.",
    ))
    This documents is identified using the following scheme:
    #figure(caption: "Document reference ID description", id_legend(
      operational_scope: operational_scope,
      system_scope: system_scope,
      iec_61355_type: iec_61355_type,
      doc_num: doc_num,
    ))
    Sequences and routines will use a similar format.
    == IEC 61355
    The #link("https://en.wikipedia.org/wiki/IEC_61355", text(fill: blue, "IEC 61355")) standard provides categorization for document types. Among others, the following types may be used within this document:

    #figure(
      caption: "Non-exhaustive lists of document types used within this document.",
      table(
        columns: (1fr, 4fr),
        align: (x, y) => if x == 0 or y == 0 { center } else { left },
        table.header(strong("Code"), strong("Description")),
        strong("EFE"), "Function descriptions.",
        strong("EFA"), "Functional overview diagrams.",
        strong("EFF"), "Function diagrams.",
        strong("EFB"), "Flow diagrams.",
        strong("EFP"), "Signal list.",
        strong("EFQ"), "Setting list.",
      ),
    )

    == ISO 7200
    The ISO 7200 document provides guidelines on title blocks of document.

    === Notice of non-compliance
    This document does not aim to be fully compliant with ISO 7200. Efforts will be made to include the necessary information as defined by the standard, but this document does not aim to comply with any formatting constraints.

    == RFC 2119
    The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL
    NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED",  "MAY", and
    "OPTIONAL" in this document are to be interpreted as described in #link("https://www.rfc-editor.org/rfc/rfc2119", text(fill: blue, "RFC 2119")).

    = Document Control
    == Document Status
    There are two status: Draft, and Released. Documents with the Draft status MUST NOT be used for final logic implementation.

    == Revision control
    === Revision Schema<revision_schema>
    The document revision number follows a `v<major>.<minor>` scheme, where a major revision change indicates a change in narrative logic, while minor revision changes indicates small corrections such as formatting issues, diagram cleanup, and typos. A `-<rc#>` suffix indicates that the document is a release candidate and is currently being reviewed.
    === Draft Changes
    When the document status is "Draft", the revision number will be accompanied with a diff count, such as "`v1.8 (+8)`". In this example, this indicate that the current draft has 8 changes recorded since version 1.8 was released. Once ready for release, the version will be incremented according to the @revision_schema.
    === Revision Lockstep
    All documents nested within this documents will use the same revision number as the overall document.

    == Build hash and revision mismatch
    This document has a build hash on the title page to the left of the revision number, and in the footer of each subsequent pages. In the event that a build hash and revision number mismatch between two compiled document instances, i.e. two documents have the same revision number but different build hash, or vice versa, then contact the document creator, approver, or legal owner.

    #if scopes != none [
      = IEC 81345 Scope Definitions
      == Summary
      This document defines the following scopes:


      #figure(
        table(
          columns: (1fr, 4fr),
          align: (x, y) => { if x == 0 { center + horizon } else { left } },
          table.header(strong("Functional Scope"), strong("Description")),
          ..scopes.map(item => (strong(mono(item.name)), item.desc)).flatten(),
        ),
        caption: "List of scopes defined in this document.",
      )
    ]

    #if products != none [
      = IEC 81345 Product Definitions
      == Summary
      This document defines the following products:

      #figure(
        table(
          columns: (1fr, 4fr),
          align: (x, y) => { if x == 0 { center + horizon } else { left } },
          table.header(strong("Product"), strong("Description")),
          ..products
            .map(item => (strong(mono(item.name)), item.desc))
            .flatten(),
        ),
        caption: "List of products defined in this document.",
      )
    ]

  ]
}
