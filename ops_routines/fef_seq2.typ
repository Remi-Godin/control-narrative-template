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

  ==== Permissives
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
    ALL OF:
    - Brine system in auto
    - Brine system strategy = 1
    - brine_start_signal:cmd4
  ]

  #let stop = [
    ANY OF:
    - brine_stop_signal:cmd5
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
  + WAIT for time:param38
  + Start #tag[P310] at percent:param39
  + Start #tag[P311] at percent:param40
  + Request to start brine_heaters_ops
  + WAIT for time:param41
  + Set #tag[P310] speed at percent:param42
  + Set #tag[P311] speed at percent:param43
  + WAIT for time:param44
  + Set #tag[P310] speed at percent:param45
  + Set #tag[P311] speed at percent:param46

  ==== Stop Narrative
  + Stop brine_heaters_ops
  + Stop #tag[P310]
  + Stop #tag[P311]
  + Deactivate #tag[P310] contactor
  + Deactivate #tag[P311] contactor
]
