// Directions, items (all / any), hints ([? …], [! …], q-only, a-only) and notes
#import "../../lib.typ": *
#let number(c) = if c.number != none [#c.number/#c.total]
#flipside(
  lang: (q: "de", a: "fr"),
  dir: "both",
  footer: (left: c => if c.direction == "forward" [de → fr] else [fr → de], right: number),
  back-footer: (right: number),
  (
    (q: [laut [? (m/f)]], a: [bruyant, bruyante]),
    (q: [der Lift, [? ein Lift]], a: [l'ascenseur, [! un ascenseur]]),
    (q: [der Kühlschrank], a: any[le réfrigérateur][le frigo]),
    (q: [die Möbel #q-note[Plural]], a: all[les meubles][le mobilier][l'ameublement], dir: "forward"),
    (q: any[Hallo][Guten Tag], a: [bonjour #a-note[aussi : salut]], dir: "forward"),
    (q: [$x^2 = 9$ #q-only[#small[(2 Lösungen)]]], a: [#all(a: "any")[$x = 3$][$x = -3$] ], dir: "forward"),
    (q: [Wie spät ist es? #note[Uhrzeit]], a: [Quelle heure est-il ? #a-only[*(familier : t'as l'heure ?)*]], dir: "reverse"),
  ),
)
