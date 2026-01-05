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
  #permissives(
    "safety_stack",
    ("us_power", "us_pneumatic", "us_brine", "us_ebara"),
    ("os_lh2", "os_ebara"),
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
