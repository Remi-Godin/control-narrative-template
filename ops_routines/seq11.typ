#import "../template.typ": *

#sheet(
  name: "PCV-520 Strategy 1: MHI Periodic Auto Adjust",
  function_scope: "FEF",
  iec_61355_type: "EFE",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ11",
)[
  === Summary
  This routine defines the operation of #tag[PCV-520] when adjusting opening based on error sampled at fixed intervals.

  ==== Permissives
  #permissives(
    "safety_stack",
    ("us_power", "us_pneumatic", "us_lh2", "us_mhi"),
    ("os_lh2", "os_mhi"),
  )

  ==== Run conditions
  #let run = [ALL:
    - #tag[PCV-520] strategy == 1
    - #tag[PCV-520] control mode in auto
    - #tag[MOTO-1] VFD running
    - Auto request active
  ]

  #let stop = [
    - Loss of run conditions
  ]

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
  + IF #tag[MOTO-1] VFD speed >= #param(18)
    + THEN IF signal:ft_420_low_flow
      + THEN
        + Set #tag[PCV-520] to #param(21)
        + [GOTO: speed_check]
      + ELSE
        + [GOTO: opening_control]
    + ELSE
      + Set #tag[PCV-520] to #param(21)
  + [LABEL: opening_control]
  + IF #param(34) elapsed since last time this was done:
    + LET diff = #tag[MN4] setpoint - #tag[MN4] actual
    + IF #param(24) <= (diff \* -1) <= #param(25)
      + THEN
        + [GOTO: speed_check]
      + ELSE
        + IF diff > #param(30)
          + THEN add #param(27) \* (#param(34) as secs) to #tag[PCV-520]
        + ELIF diff > #param(31)
          + THEN add #param(28) \* (#param(34) as secs) to #tag[PCV-520]
        + ELIF diff > #param(32)
          + THEN add #param(29) \* (#param(34) as secs) to #tag[PCV-520]
        + ELIF diff < #param(33)
          + THEN add #param(26) \* (#param(34) as secs) to #tag[PCV-520]
        + IF bool:cmd5 AND #tag[PCV-520] opening < #param(36)
          + Set #tag[PCV-520] to #param(36)
        + [GOTO: speed_check]

]

