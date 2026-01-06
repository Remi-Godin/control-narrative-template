#import "./template.typ": *

#show: narrative

#include "changelog.typ"

= Livermore HUB Station Information
== Fueling Operations<fueling_operations>
The Livermore site act as a hub to refill gaseous trailers that are then sent to refill our gaseous stations.

== Testing Operations<testing_operations>
3rd parties are also able to test their own equipment at this site, so we have to integrate with a lot of different systems. More on that in @summary_of_testing

=== Design Considerations
Since the testing operations makes us a multi-tenant site that is subject to change often, the program SHOULD be designed with flexibility in mind.

== Summary of Auxiliary Equipment

=== Air Compressor
Provides compressed air to supply pneumatic equipment.

=== N2 Generator
Generates nitrogen for use in purging our system.

== Summary of HUB Operations Equipment
=== LH2 Tank<lh2_tank>
The LH2 tank system stores the liquid hydrogen and handles distribution to the different equipment. It can send both liquid from the liquid space of the tank, or gas from the vapor space of the tank.

==== Next
===== Gaseous Outlets
- @vertical_vaporizers
===== Liquid Outlets
- @vertical_vaporizers
- @mhi
- @bosch
- @ebara

=== Vertical Vaporizers<vertical_vaporizers>
==== From Liquid
Takes in the liquid and transforms it to gaseous hydrogen at around 5 psi.

==== From Gas
Takes in the gas and reduces it to 5 psi.

==== Next
- @burckhardt

=== Burckhardt Compressor<burckhardt>
Takes in the gas from the vaporizers and compresses it to 1000 psi, and then sends it to the PDC.

==== Next
- @pdc

=== PDC Compressor<pdc>
The PDC takes in the 1000 psi gas and discharge it at 7500 psi.

==== Next
- @fill_stalls

=== Fill Stalls<fill_stalls>
Takes in the gaseous hydrogen and fills the gaseous trailers.

== Summary of Testing Operations Equipment<summary_of_testing>
=== MHI Pump<mhi>
Takes in liquid hydrogen from the @lh2_tank, and pumps out gaseous hydrogen at 1000 bar.

==== Next
- @horizontal_vaporizers
- @brine

=== Bosch Pump<bosch>
Takes in liquid hydrogen from the @lh2_tank, and pumps out gaseous hydrogen at 1000 bar.

==== Next
- @horizontal_vaporizers
- @brine

=== Ebara Pump<ebara>
Takes in liquid hydrogen from the @lh2_tank, and pumps out gaseous hydrogen at 1000 bar.

==== Next
- @horizontal_vaporizers
- @brine

=== Horizontal Vaporizers<horizontal_vaporizers>
Takes in the gaseous hydrogen from the pumps and warms it up passively.

==== Next
- @fill_stalls

==== Brine System<brine>
The brine system is used to warm up the gaseous hydrogen, and to cool down other equipment, using active heaters and by transferring thermal energy between equipment.

==== Next
- @fill_stalls

== Running third party pumps
Only one pump MUST be allowed to run at once.


#include "./permissives.typ"

#sheet(
  name: "Livermore system overview",
  function_scope: none,
  iec_61355_type: "EFA",
  creator: "Remi Godin",
  product: "DES1",
  approver: none,
)[
  #set align(center + horizon)
  #image("./assets/drawings/ctrl_des1.svg")
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
  #align(center + horizon, image("./assets/drawings/fef_seq1.svg"))
]

= Operation Routines<operation_routines>
#link(label("&EFA-DES1"))[Test]

#include "./ops_routines/fef_seq2.typ"
#include "./ops_routines/fef_seq3.typ"
#include "./ops_routines/fef_seq4.typ"
#include "./ops_routines/fef_seq5.typ"
#include "./ops_routines/fef_seq6.typ"


= Communications
== Summary
This section will define methods of communicating data between systems, as well as other considerations when it comes to connection monitoring.

#sheet(
  name: "Ebara Watchdog Operations for FEF Comms",
  function_scope: ("FEF", "EBARA"),
  iec_61355_type: "EFF",
  creator: "Remi Godin",
  product: "SEQ7",
  approver: none,
)[
  #set align(center + horizon)
  #image("./assets/drawings/fef_ebara_seq7.svg")
]

#sheet(
  name: "Ebara Start Signal From FEF",
  function_scope: ("FEF", "EBARA"),
  iec_61355_type: "EFF",
  creator: "Remi Godin",
  product: "SEQ8",
  approver: none,
)[
  #set align(center + horizon)
  #image("./assets/drawings/fef_ebara_seq8.svg")
]
