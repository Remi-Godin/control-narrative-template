#import "./template.typ": *

#show: narrative


#include "./docs/hub_info.typ"
#include "./docs/permissives.typ"

#include "docs/des1.typ"

= System Settings
== Summary
The parameters and commands referenced in the @safety_routines and @operation_routines sections are defined in this section.

#sheet(
  no_margin: true,
  name: "Parameter List",
  function_scope: none,
  iec_61355_type: "EFQ",
  creator: "Remi Godin",
  product: "PARAM1",
  approver: none,
)[
  #render-param-table(params, start: 0, stop: 100)
]

#sheet(
  no_margin: true,
  name: "Commands List",
  function_scope: none,
  iec_61355_type: "EFQ",
  creator: "Remi Godin",
  product: "CMD1",
  approver: none,
)[
  #render-command-table(commands, start: 0, stop: 100)
]


= Safety Routines<safety_routines>
== Summary
Safety routines are routines that are executed upon a loss of level 1 permissives.

#include "./safety_routines/seq1.typ"

= Operation Routines<operation_routines>
#link(label("&EFA-DES1"))[Test]

#include "./ops_routines/seq2.typ"
#include "./ops_routines/seq3.typ"
#include "./ops_routines/seq4.typ"
#include "./ops_routines/seq5.typ"
#include "./ops_routines/seq6.typ"
#include "./ops_routines/seq9.typ"
#include "./ops_routines/seq10.typ"
#include "./ops_routines/seq11.typ"
#include "./ops_routines/seq12.typ"


= Communications
== Summary
This section will define methods of communicating data between systems, as well as other considerations when it comes to connection monitoring.

#include "./comms/seq7.typ"
#include "./comms/seq8.typ"

