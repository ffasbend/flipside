// Vocabulary German → French, read from a CSV file (e.g. saved from Excel).
// DIN A7 cards (8 per A4 sheet), a coloured stripe per theme.
//
//   typst compile --root .. vocabulary.typ
//   typst compile --root .. --input layout=list vocabulary.typ vocabulary-list.pdf
#import "../lib.typ": *

#let number(c) = if c.number != none [#c.number/#c.total]

#flipside(
  title: "Vokabeln Deutsch – Französisch",
  card: "DIN A7",
  lang: (q: "de", a: "fr"),
  size: 18pt,
  stripe: auto,
  header: (right: [Deutsch → Français]),
  footer: (left: c => c.theme, right: number),
  back-footer: (left: c => c.theme, right: c => text(fill: gray, number(c))),
  csv("vocabulary.csv", row-type: dictionary),
)
