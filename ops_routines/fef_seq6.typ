#import "../template.typ": *

#sheet(
  name: "Ebara Pump Operations",
  function_scope: "FEF",
  iec_61355_type: "EFE",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ6",
)[
  === Summary
  This routine defines the operation of `PCV-520` when adjusting opening based on error sampled at fixed intervals.


  ==== Permissives
  // #safety("Level 1 Permissives")[
  //   - #ok[@safety_stack]
  // ]
  // #utilities("Level 2 Permissives")[
  //   - #ok[@us_power]
  //   - #ok[@us_pneumatic]
  //   - #ok[@us_lh2]
  //   - #ok[@us_mhi]
  // ]
  // #operations("Level 3 Permissives")[
  //   - #ok[@os_lh2]
  //   - #ok[@os_mhi]
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
    - `PCV-520` strategy == 1
    - `PCV-520` control mode in auto
    - `MOTO-1` VFD running
    - Auto request active
  ]

  #let stop = [- Loss of run conditions]
  #figure(
    table(
      columns: (1fr, 1fr),
      table.header[Run Conditions][Stop Conditions],
      run, stop,
    ),
    // caption: "Start and stop conditions for this routine.",
  )

  ==== Narrative
  + [LABEL: speed_check]
  + IF `MOTO-1` VFD speed >= speed:param18
    + THEN IF signal:ft_420_low_flow
      + THEN
        + Set `PCV-520` to percent:param21
        + [GOTO: speed_check]
      + ELSE
        + [GOTO: opening_control]
    + ELSE
      + Set `PCV-520` to percent:param21
  + [LABEL: opening_control]
  + IF time:param34 elapsed since last time this was done:
    + LET diff = `MN4` setpoint - `MN4` actual
    + IF press:param24 <= (diff \* -1) <= press:param25
      + THEN
        + [GOTO: speed_check]
      + ELSE
        + IF diff > press:param30
          + THEN add rate:param27 \* (time:param34 as secs) to `PCV-520`
        + ELIF diff > press:param31
          + THEN add rate:param28 \* (time:param34 as secs) to `PCV-520`
        + ELIF diff > press:param32
          + THEN add rate:param29 \* (time:param34 as secs) to `PCV-520`
        + ELIF diff < press:param33
          + THEN add rate:param26 \* (time:param34 as secs) to `PCV-520`
        + IF bool:cmd5 AND `PCV-520` opening < percent:param36
          + Set `PCV-520` to percent:param36
        + [GOTO: speed_check]
]

