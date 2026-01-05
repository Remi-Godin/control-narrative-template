#import "./template.typ": *

= Permissives<permissives>
== Permissive Levels<permissive_levels>
The permissives will control the operations of the main PLC.

#grid(
  columns: (1fr, 1fr),
  [
    #figure(
      image("./assets/drawings/permissive_pyramid.svg", width: 95%),
      caption: [Permissive levels hierarchy],
    )
  ],
  grid(
    columns: (auto, 1fr),
    strong("Level 1"),
    column-gutter: 1em,
    row-gutter: 1em,
    [_Safety permissives_. Loss of these permissives MUST cause the system to fault and go into an immediate shutdown, and run safety routines. *This requires a manual reset to put the system back into an operating state.*],
    strong("Level 2"),

    [_Utility permissives_. Loss of these permissives MUST cause the affected systems to stop normally. *This requires a manual reset to put the system back into an operating state.*],
    strong("Level 3"),

    [_Operation permissives_. Loss of these permissives MUST cause the affected systems to stop normally. *This level will auto-reset upon permissive conditions being re-established.*],
  ),
)
== Nested Permissives
In the visual representation of the permissives stacks, nested permissives means that all inner permissives are dependent on the outer permissives being met
#internal("Outer")[
  - This trips OUTER and INNER
  #internal("Inner")[
    - This trips INNER only
  ]
]
== Level 1 Permissive Stack<safety_stack>
#figure(
  safety("System Wide")[
    + #ok[All emergency stop]
    + #ok[All gas detector]
    + #ok[All flame detector]
    #safety("LH2 Tank")[
      + #ok[No instruments ZHH or ZLL alarms]
      #safety("Burckhardt and PDC")[
        + #ok[No faults from Nikkiso PLC]
      ]
      #safety("Brine System")[
        + #ok[No instruments ZHH or ZLL alarms]
      ]
      #safety("Bosch Pump")[
        + #ok[No instruments ZHH or ZLL alarms]
      ]
      #safety("MHI Pump")[
        + #ok[No instruments ZHH or ZLL alarms]
      ]
      #safety("Ebara Pump")[
        + #ok[No instruments ZHH or ZLL alarms]
      ]
      #safety("Fill stalls")[
        + #ok[No faults from Nikkiso PLC]
      ]
    ]
  ],
  caption: [Permissive safety stack.],
)

=== Level 1: System Wide<ss_all>
=== Level 1: LH2 Tank<ss_lh2>
=== Level 1: Burckhardt and PDC<ss_pdc>
=== Level 1: Brine system<ss_brine>
=== Level 1: Bosch pump<ss_bosch>
=== Level 1: MHI pump<ss_mhi>
=== Level 1: Ebara pump<ss_ebara>
=== Level 1: Fill stalls<ss_fill_stalls>

#colbreak()
== Level 2 Permissive Stack<utility_stack>
#figure(
  [
    #utilities("Power")[
      + #ok[Main Power]
      + #ok[Control Power]
    ]
    #utilities("Pneumatic")[
      + #ok[Air supply]
      + #ok[Air compressor]
    ]
    #utilities("LH2 tank")[
      + #ok[No instruments HH or LL alarms]
    ]
    #utilities("Brine System")[
      + #ok[No instruments HH or LL alarms]
    ]
    #utilities("Bosch")[
      + #ok[No instruments HH or LL alarms]
    ]
    #utilities("MHI")[
      + #ok[No instruments HH or LL alarms]
    ]
    #utilities("Ebara")[
      + #ok[No instruments HH or LL alarms]
    ]
    #utilities("PDC and Burckhardt")[
      + #ok[No faults from Nikkiso PLC]
    ]
    #utilities("Fill stalls")[
      + #ok[No faults from Nikkiso PLCs]
    ]
  ],
  caption: [Permissive utilities stack.],
)

=== Level 2: Power<us_power>
=== Level 2: Penumatic<us_pneumatic>
=== Level 2: LH2 tank<us_lh2>
=== Level 2: Burckhardt and PDC<us_pdc>
=== Level 2: Brine system<us_brine>
=== Level 2: Bosch pump<us_bosch>
=== Level 2: MHI pump<us_mhi>
=== Level 2: Ebara pump<us_ebara>
=== Level 2: Fill stalls<us_fill_stalls>

#colbreak()
== Level 3 Permissive Stack<operation_stack>
#figure(
  [
    #operations("LH2 Tank")[
      #operations("Burckhardt and PDC")[
        + #ok[System ready from Nikkiso PLC]
      ]
      #operations("Brine System")[
        + #ok[System ready]
        + #ok[System enabled]
      ]
      #operations("Bosch")[
        + #ok[System ready]
        + #ok[System enabled]
      ]
      #operations("MHI")[
        + #ok[System ready]
        + #ok[System enabled]
        + #ok[Last pump stop time was more than time:param17 ago]
      ]
      #operations("Ebara")[
        + #ok[System ready]
        + #ok[System enabled]
      ]
    ]
    #operations("Fill stalls")[
      #internal("ANY OF")[
        - #ok[@os_pdc]
        - #ok[@os_mhi]
        - #ok[@os_bosch]
        - #ok[@os_ebara]
      ]
    ]
  ],
  caption: [Permissive operations stack.],
)

=== Level 3: LH2 tank<os_lh2>
=== Level 3: Burchardt and PDC<os_pdc>
=== Level 3: Brine system<os_brine>
=== Level 3: Bosch pump<os_bosch>
=== Level 3: MHI pump<os_mhi>
=== Level 3: Ebara pump<os_ebara>
=== Level 3: Fill stalls<os_fill_stalls>
