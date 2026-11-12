// Vocabulary German ↔ French, read from a CSV file (e.g. saved from Excel),
// learnt and printed both ways (dir: "both"). DIN A7 cards (8 per A4 sheet),
// a coloured stripe per theme.
//
// In the CSV file:
// - "[? …]" is shown only when its side is asked: "laut [? (m/f)]" asks for
//   both forms, and is just "laut" as the answer;
// - "[! …]" is shown only when its side is the answer: "l'ascenseur,
//   [! un ascenseur]" shows the article in the answer only;
// - the column "dir" limits a card to one way ("die Möbel" only de → fr);
// - an empty cell keeps the value of the row above, for "theme" and "dir"
//   alike: that is why "die Möbel" is the last row.
//
//   typst compile vocabulary.typ
//   typst compile --input layout=list vocabulary.typ vocabulary-list.pdf
#import "@preview/flipside:0.2.1": *

#let number(c) = if c.number != none [#c.number/#c.total]
// The direction of a printed card, for its header
#let direction(c) = if c.direction == "forward" [Deutsch → Français] else [Français → Deutsch]

#flipside(
  title: "Vokabeln Deutsch – Französisch",
  card: "DIN A7",
  lang: (q: "de", a: "fr"),
  dir: "both",
  size: 18pt,
  stripe: auto,
  header: (right: direction),
  footer: (left: c => c.theme, right: number),
  back-footer: (left: c => c.theme, right: c => text(fill: gray, number(c))),
  csv("vocabulary.csv", row-type: dictionary),
)
