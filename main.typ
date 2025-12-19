#import "./template.typ": *
#show: formatting

#title_page(
  // Title information
  issuing_dept: "Systems Engineering Department",
  title: "Livermore Hub",
  document_type: "Control Narrative",
  // Document info
  project_id: "HD15",
  scope_id: "LIVHUB",
  iec_61355_type: "EFE",
  doc_num: "1",
  status: "status",
  creator: "Remi Godin",
  approver: none,
  owner: "True Zero",
  // Style overrides
  font: "Bebas Neue",
  accent_color: rgb("#0971ce"),
)

#outline()

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
  = Test
  #lorem(50)
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
  = Test
  #lorem(50)
  == Test
  #lorem(50)
]
