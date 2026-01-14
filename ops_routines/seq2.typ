#import "../template.typ": *

#sheet(
  name: "Brine System Pumps Strategy 1: MHI Control",
  function_scope: "FEF",
  iec_61355_type: "EFE",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ2",
)[
  === Summary
  This routine defines the operation of the brine system pumps when controlled by the MHI system.

  ==== Permissives
  #permissives(
    "safety_stack",
    ("us_power", "us_pneumatic", "us_brine"),
    ("os_lh2", "os_brine"),
  )

  #let run = [
    ALL OF:
    - Brine system in auto
    - Brine system strategy = 1
    - #command(1)
  ]

  #let stop = [
    ANY OF:
    - #command(2)
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

  ==== Run Narrative
  + Activate #tag[P310] contactor
  + Activate #tag[P311] contactor
  + WAIT for #param(38)
  + Start #tag[P310] at #param(39)
  + Start #tag[P311] at #param(40)
  + Request to start brine heaters
  + WAIT for #param(41)
  + Set #tag[P310] speed at #param(42)
  + Set #tag[P311] speed at #param(43)
  + WAIT for #param(44)
  + Set #tag[P310] speed at #param(45)
  + Set #tag[P311] speed at #param(46)

  ==== Stop Narrative
  + Stop brine heaters
  + Stop #tag[P310]
  + Stop #tag[P311]
  + Deactivate #tag[P310] contactor
  + Deactivate #tag[P311] contactor
]
