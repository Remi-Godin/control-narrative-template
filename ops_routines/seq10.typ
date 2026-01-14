#import "../template.typ": *

#sheet(
  name: "MHI Pump Strategy 2: Manual Speed Ramp Up",
  function_scope: "FEF",
  iec_61355_type: "EFE",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ10",
)[
  === Summary
  This routine defines the operations of the MHI pump when the manual speed ramp up strategy is selected.

  ==== Permissives
  #permissives(
    "safety_stack",
    ("us_power", "us_pneumatic", "us_lh2", "us_mhi"),
    ("os_lh2", "os_mhi"),
  )

  ==== Run conditions
  #let run = [ALL:
    - MHI pump strategy == 2
    - MHI Pump in auto mode
    - `PCV-520` in auto mode
    - `PCV-520` strategy == 1 | 2
    - #command(3)

  ]

  #let stop = [
    ANY:
    - #command(2)
    - #command(4)
    - `MOTO-1` running for more than time:param15
    - `PT-440` > target pressure param16

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
  + [LABEL: pump_start]
  + Enable #tag[MOTO-1] VFD contactor
  + WAIT for #param(1)
  + Request #tag[MOTO-1] VFD to start at speed #param(2)
  + [LABEL: ramp_up]
  + LOOP:
    + Set #tag[MOTO-1] speed to mhi_pump_strat2_speed:cmd20
    + IF #tag[MOTO-1] speed >= #param(19)
      + THEN request #tag[PCV-520] auto control

  ==== Shutdown Narrative
  + Stop #tag[MOTO-1] VFD
  + Stop #tag[PCV-520] auto controls
  + Disable #tag[MOTO-1] VFD contactor
  + EXIT

]

