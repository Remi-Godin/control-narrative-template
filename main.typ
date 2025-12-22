#import "./template.typ": *

#show: narrative.with(
  issuing_dept: "Systems Engineering Department",
  title: "Livermore Hub",
  document_type: "Control Narrative",
  project_id: "LIV",
  scope_id: "NX102",
  iec_61355_type: "EFE",
  doc_num: "1",
  status: "draft",
  creator: "Remi Godin",
  approver: none,
  owner: "True Zero",
  accent_color: rgb("#0971ce"),
  revision: "1.2",
)


= Test

== Test
=== Test
==== Test
= Test

#routine(
  landscape: true,
  function_id: "PM1",
  doctype: "EFE",
  docnum: 1,
  creator: "Remi Godin",
  approver: none,
  legal_owner: "TrueZero",
  date_of_issue: "2025-10-02",
)[
  == Test
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
  date_of_issue: "2025-10-02",
)[
  == Test
  #lorem(50)
]

