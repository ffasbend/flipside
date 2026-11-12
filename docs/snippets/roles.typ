#import "@preview/flipside:0.2.1": *

#flipside(
  lang: (q: "de", a: "fr"),
  dir: "both",                    // every card both ways
  footer: (left: c => if c.direction == "forward" [de → fr] else [fr → de]),
  (
    (q: [laut [? (m/f)]], a: [bruyant, bruyante]),
    (q: [der Lift, [? ein Lift]], a: [l'ascenseur, [! un ascenseur]]),
    (q: [der Kühlschrank], a: any[le réfrigérateur][le frigo]),
    (
      q: [die Möbel #q-note[Plural]],
      a: all[les meubles][le mobilier][l'ameublement],
      dir: "forward",             // this card only one way
    ),
  ),
)
