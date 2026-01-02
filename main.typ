#import "./template.typ": *

#show: narrative

= Livermore HUB Station Information
#sheet(
  name: "Livermore system overview",
  function_scope: none,
  iec_61355_type: "EFA",
  creator: "Remi Godin",
  product: "DES1",
  approver: none,
)[
  #set align(center + horizon)
  #image("./system_layout.svg")
]

= Safety Routines
== Summary
Safety routines are routines that are executed upon a loss of level 1 permissives.

#sheet(
  name: "Safety Protocol 1",
  function_scope: "FEF",
  iec_61355_type: "EFF",
  creator: "Remi Godin",
  product: "SEQ1",
  approver: none,
)[
  #align(center + horizon, image("./safety_protocol_1.svg"))
]

= Operation Routines<operation_routines>
#ref(label("==LIV=CTRL&EFA-DES1"))

#include "./ops_routines/fef_seq2.typ"
#include "./ops_routines/fef_seq3.typ"
#include "./ops_routines/fef_seq4.typ"
#include "./ops_routines/fef_seq5.typ"
#include "./ops_routines/fef_seq6.typ"

