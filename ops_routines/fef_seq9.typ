#import "../template.typ": *

#sheet(
  name: "Brine System Contactor Strategy 2: Bosch Control",
  function_scope: "FEF",
  iec_61355_type: "EFE",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ9",
)[
  === Summary
  The MHI controls the contactors as part of the startup of the brine system routine. Bosch requires the contactors to be active prior to the start signal being received.

  ==== Permissives
  #permissives(
    "safety_stack",
    ("us_power", "us_pneumatic", "us_brine"),
    ("os_lh2", "os_brine"),
  )

  #let run = [
    ALL OF:
    - Brine system in auto
    - Brine system strategy = 2
  ]
  #let stop = [ANY OF:
    - Loss of run conditions
  ]
  ==== Start and stop conditions
  #figure(
    table(
      columns: (1fr, 1fr),
      table.header[Run Conditions][Stop Conditions],
      run, stop,
    ),
    // caption: "Start and stop conditions for this routine.",
  )

  ==== Narrative
  + Energize #tag[P310] contactor
  + Energize #tag[P311] contactor

  ==== Shutdown Narrative
  + De-energize #tag[P310] contactor
  + De-energize #tag[P311] contactor
]
