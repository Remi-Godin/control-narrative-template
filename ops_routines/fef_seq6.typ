#import "../template.typ": *

#sheet(
  name: "MHI Pump Strategy 1: Auto Speed Ramp Up",
  function_scope: "FEF",
  iec_61355_type: "EFE",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ6",
)[
  === Summary
  This routine defines the operation of MHI pump when it automatically ramps the speed as defined in the MHI operation procedure document.

  ==== Permissives
  #permissives(
    "safety_stack",
    ("us_power", "us_pneumatic", "us_lh2", "us_mhi"),
    ("os_lh2", "os_mhi"),
  )

  ==== Run conditions
  #let run = [ALL:
    - MHI Pump in auto mode
    - #tag[PCV-520] in auto mode
    - #tag[PCV-520] strategy == 1 | 2
    - #command(3)
    - MHI pump strategy == 1

  ]

  #let stop = [
    - ANY:
      - #command(4)
      - #command(2)
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
  + WAIT for #param(3)
  + Request #tag[MOTO-1] VFD to start at speed #param(2)
  + [LABEL: ramp_up]
  + WAIT for #param(4)
  + Set #tag[MOTO-1] speed to #param(5)
  + WAIT for #param(6)
  + Set #tag[MOTO-1] speed to #param(7)
  + WAIT for #param(8)
  + Set #tag[MOTO-1] speed to #param(9)
  + WAIT for #param(10)
  + Set #tag[MOTO-1] speed to #param(11)
  + WAIT for #param(12)
  + Set #tag[MOTO-1] speed to #param(13)
  + Start #tag[PCV-520] auto mode

  ==== Shutdown Narrative
  + Stop #tag[MOTO-1] VFD
  + Stop #tag[PCV-520] auto controls
  + Disable #tag[MOTO-1] VFD contactor
  + EXIT

]

