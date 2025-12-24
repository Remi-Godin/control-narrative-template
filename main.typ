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

#sheet(
  landscape: true,
  name: "Brine System Pumps Strategy 1: MHI Control",
  function_scope: "FEF",
  iec_61355_type: "EFF",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ2",
)[
  #columns(2)[
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
]

#sheet(
  landscape: true,
  name: "Brine System Pumps Strategy 2: Bosch Control",
  function_scope: "FEF",
  iec_61355_type: "EFF",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ3",
)[
  #columns(2)[
    === Summary
    This routine defines the operation of the brine system pumps when controlled by the Bosch system.

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
      - Brine system strategy = 2
    ]
    #let stop = [ANY OF:
      - Stop of run conditions
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
    + Activate #tag[P310] contactor
    + Activate #tag[P311] contactor
    + LOOP
      + IF brine_run_signal:cmd4
        + THEN
          + Set #tag[P310] at speed setpoint defined by Bosch
          + Set #tag[P311] at speed setpoint defined by Bosch
          + Accelerate/Decelerate towards speed setpoint at rate define by Bosch
      + ELSE
        + THEN
          + Stop #tag[P310] immediately
          + Stop #tag[P311] immediately

    ==== Shutdown Narrative
    + Stop brine_heaters_ops
    + Stop #tag[P310]
    + Stop #tag[P311]
    + Deactivate #tag[P310] contactor
    + Deactivate #tag[P311] contactor

  ]
]

#sheet(
  landscape: true,
  name: "Brine System Heaters Operation",
  function_scope: "FEF",
  iec_61355_type: "EFF",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ4",
)[
  #columns(2)[

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
]
