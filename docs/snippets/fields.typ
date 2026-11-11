#import "@preview/flipside:0.2.0": *

#let number(c) = if c.number != none [#c.number/#c.total]

#flipside(
  footer: (left: c => c.theme, right: number),
  (
    (theme: "Europe"),      // no card: the theme of the cards below
    (q: [France], a: [Paris]),
    (q: [Germany], a: [Berlin]),
    (theme: "Asia"),
    (q: [Japan], a: [Tokyo]),
    (q: [], a: []),         // a blank card
  ),
)
