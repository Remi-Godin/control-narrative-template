#import "../template.typ": *

#sheet(
  name: "Brine System Heaters Operation",
  function_scope: "FEF",
  iec_61355_type: "EFE",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ4",
)[

  === Summary
  This routine defines the operation of the brine system heaters.

  ==== Permissives
  #permissives(
    "safety_stack",
    ("us_power", "us_pneumatic", "us_brine"),
    ("os_lh2", "os_brine"),
  )

  #let run = [
    - Brine system in auto
    - Internal request from brine system
  ]

  #let stop = [
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

  #colbreak()
  ==== Narrative
  + LOOP
    + IF #tag[TT3x2] <= #param(47)
      + THEN
        + Start #tag[HTR3x0]
    + IF #tag[TT3x2] >  #param(48)
      + THEN
        + Stop #tag[HTR3x0]

]
