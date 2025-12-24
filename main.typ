#import "./template.typ": *

#show: narrative


= Safety Routines
#sheet(
  name: "Safety Protocol 1",
  function_scope: "FEF",
  iec_61355_type: "EFF",
  creator: "Remi Godin",
  product: "SEQ1",
  approver: none,
)[
  === Summary
  This routine inhibit all requests for device operations made by any non-safety routines.

  === Run Condition
  - Loss of safety_stack

  === Stop Condition
  - safety_stack OK

  #line(length: 100%)
  === Narrative
  + Inhibit all requests that are not coming from safety routines for all devices in the affected sub-systems.
  #align(center + horizon, image("./safety_protocol_1.svg"))
]

= Operation Routines<operation_routines>
#ref(label("==LIV=CTRL&EFA-DES1"))

#sheet(
  name: "Brine System Pumps Strategy 1: MHI Control",
  function_scope: "MHI",
  iec_61355_type: "EFF",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ1",
)[
  === Brine System Pumps Strategy 1: MHI Control
  ==== Summary
  This routine defines the operation of the brine system pumps when controlled by the MHI system.

  ==== Permissives
  // #safety("Level 1 Permissives")[
  //   - #ok[@safety_stack]
  // ]
  // #utilities("Level 2 Permissives")[
  //   - #ok[@us_power]
  //   - #ok[@us_pneumatic]
  //   - #ok[@us_brine]
  // ]
  // #operations("Level 3 Permissives")[
  //   - #ok[@os_lh2]
  //   - #ok[@os_brine]
  // ]

  ==== Run conditions
  - ALL:
    - Brine system in auto
    - Brine system strategy = 1
    - brine_start_signal:cmd4

  ==== Stop conditions
  - ANY:
    - brine_stop_signal:cmd5
  #line(length: 100%)
  ==== Narrative
  + Activate `P310` contactor
  + Activate `P311` contactor
  + WAIT for time:param38
  + Start `P310` at percent:param39
  + Start `P311` at percent:param40
  + Request to start brine_heaters_ops
  + WAIT for time:param41
  + Set `P310` speed at percent:param42
  + Set `P311` speed at percent:param43
  + WAIT for time:param44
  + Set `P310` speed at percent:param45
  + Set `P311` speed at percent:param46

  ==== Shutdown Narrative
  + Stop brine_heaters_ops
  + Stop `P310`
  + Stop `P311`
  + Deactivate `P310` contactor
  + Deactivate `P311` contactor

]

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

#sheet(
  function_scope: "BOSCH",
  iec_61355_type: "EFF",
  creator: "Remi Godin",
  approver: none,
)[

]

