#import "@preview/flipside:0.1.0": *

#let number(c) = if c.number != none [#c.number/#c.total]
#let logo = box(fill: rgb("#7a9a01"), inset: 2pt, text(fill: white)[*LOGO*])

#flipside(
  header: (left: logo, center: [Geography], right: [Class 7a]),
  footer: (left: c => c.theme, center: [·], right: number),
  back-header: (right: c => text(fill: gray)[#c.theme]),
  back-footer: (right: c => text(fill: gray, number(c))),
  (
    (theme: "Capitals"),
    (q: [France], a: [Paris]),
    (q: [Peru], a: [Lima]),
    (theme: "Rivers"),
    (q: [The longest river \ in Europe?], a: [The Volga]),
  ),
)
