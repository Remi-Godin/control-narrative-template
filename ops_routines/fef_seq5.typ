#import "../template.typ": *

#sheet(
  name: "Ebara Pump Operations",
  function_scope: "FEF",
  iec_61355_type: "EFE",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ5",
)[
  === Summary
  This routine defines the operation of the Ebara pump.

  ==== Permissives
  // #safety("Level 1 Permissives")[
  //   - #ok[@safety_stack]
  // ]
  // #utilities("Level 2 Permissives")[
  //   - #ok[@us_power]
  //   - #ok[@us_pneumatic]
  //   - #ok[@us_lh2]
  //   - #ok[@us_ebara]
  // ]
  // #operations("Level 3 Permissives")[
  //   - #ok[@os_lh2]
  //   - #ok[@os_ebara]
  // ]
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

  ==== Run conditions

  #let run = [ALL:
    - Ebara pump is enabled
    - Request for GH2 by fill stalls
  ]

  #let stop = [Loss of run conditions]

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
  + WAIT UNTIL request handshake to LH2 tank complete
    - #sym.arrow.r Request LH2 tank for LH2
    - #sym.arrow.l LH2 tank acknowledge request
  + Send START signal to Ebara
  + WAIT UNTIL run conditions are no long active
  + Send STOP signal to Ebara

]
