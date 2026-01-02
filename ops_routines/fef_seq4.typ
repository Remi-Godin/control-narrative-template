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
  //

  #figure(
    table(
      columns: (1fr, 1fr, 1fr),
      table.header(
        table.cell(fill: red, "Level 1"), table.cell(fill: orange, "Level 2"), table.cell(fill: purple, "Level 3")
      ),
      lorem(4), lorem(4), lorem(4),
      lorem(4), lorem(4), none,
      lorem(4), lorem(4), none,
      none, lorem(4), none,
    ),
    // caption: [Permissives required for this routine.],
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
    + IF #tag[TT3x2] <= temp:param47
      + THEN
        + Start #tag[HTR3x0]
    + IF #tag[TT3x2] >  temp:param48
      + THEN
        + Stop #tag[HTR3x0]

]
