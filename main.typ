#import "./template.typ": *

#show: narrative

= Scope Definitions
== Summary
This document defines the following scopes:
#table(
  columns: (1fr, 3fr),
  align: (x, y) => { if x == 0 { center + horizon } else { left } },
  table.header("Scope", "Description"),
  mono("==LIV "),
  "The Livermore HUB site. Includes the operations and testing operations. When referencing this scope, it covers the station as a whole.",

  mono("=CTRL "),
  "This scope includes everything within the Livermore HUB site operations, including normal and testing operations.",

  mono("=FEF  "),
  "This scope focuses on the The FEF balance of plant elements.",

  mono("=BOSCH"), "This scope focuses on the  Bosch pump elements.",
  mono("=MHI  "), "This scope forcues on the MHI pump elements.",
  mono("=EBAR "), "This scope forcues on the Ebara pump elements.",
  mono("=NIKK "), "This scope forcues on the Nikkiso system elements.",
)


#show: main


= Operations Routines
#routine(
  landscape: true,
  function_id: "PM1",
  doctype: "EFE",
  docnum: 1,
  creator: "Remi Godin",
  approver: none,
  legal_owner: "TrueZero",
  issue_date: "2025-10-02",
)[
  == Test
  === Test
  #lorem(50)
]

#routine(
  landscape: false,
  function_id: "PM1",
  doctype: "EFE",
  docnum: 1,
  creator: "Remi Godin",
  approver: none,
  legal_owner: "TrueZero",
  issue_date: "2025-10-02",
)[
  == Test
  #lorem(50)
]

