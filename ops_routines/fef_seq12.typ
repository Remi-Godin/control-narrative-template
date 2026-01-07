#import "../template.typ": *

#sheet(
  name: "PCV-520 Strategy 2: Manual Setpoint",
  function_scope: "FEF",
  iec_61355_type: "EFE",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ12",
)[
  === Summary
  This routine defines the operation of #tag[PCV-520] when using manual setpoints. This is distinct from manual operations as the setpoint is only active while the valve is in auto and the start command has been issued.

  ==== Permissives
  #permissives(
    "safety_stack",
    ("us_power", "us_pneumatic", "us_lh2", "us_mhi"),
    ("os_lh2", "os_mhi"),
  )

  ==== Run conditions
  #let run = [ALL:
    - #tag[PCV-520] strategy == 2
    - #tag[PCV-520] control mode in auto
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
  + Set valve opening to its default state
  + LOOP
    + When #command(7) is received, set valve opening to the received value
]

