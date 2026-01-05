#import "../template.typ": *

#sheet(
  name: "Brine System Pumps Strategy 2: Bosch Control",
  function_scope: "FEF",
  iec_61355_type: "EFE",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ3",
)[
  === Summary
  This routine defines the operation of the brine system pumps when controlled by the Bosch system.

  ==== Permissives
  #permissives(
    "safety_stack",
    ("us_power", "us_pneumatic", "us_brine"),
    ("os_lh2", "os_brine"),
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
