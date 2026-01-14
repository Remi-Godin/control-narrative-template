#import "../template.typ": *

#sheet(
  name: "Testing operations fill stalls pressure summary",
  function_scope: "FEF",
  iec_61355_type: "EFE",
  creator: "Remi Godin",
  approver: none,
  product: "SEQ13",
)[
  === Summary
  This routine defines the summing of the fill stalls pressure for feedback to testing operations pumps. If a pump is supplying 2 fill stalls, the pressure of those 2 fill stalls will be sent back to the pump controls for monitoring purposes.

  ==== Run conditions
  #let run = [Always
  ]

  #let stop = [
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
  + Allow operator to select which fill stalls are being fed by the testing operations side
  + Pressure transmitters from all selected stalls shall be summed up and save it to a new variable

]

