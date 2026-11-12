// Upright cards in a size of your own: 60 × 90 mm, 3 × 3 per A4 sheet with
// gaps between the cards. Good for lists, e.g. irregular verbs.
//
//   typst compile upright-cards.typ
#import "@preview/flipside:0.2.1": *

#let verb(infinitive, forms, meaning) = (
  q: [#text(size: 1.4em, infinitive) \ #small[(#meaning)]],
  a: block-left[
    #set par(justify: false)
    #forms.map(f => [#f]).join(linebreak())
  ],
)

#flipside(
  title: "Irregular verbs",
  card: (width: 90mm, height: 60mm, gap: (x: 4mm, y: 4mm)),
  orientation: "portrait",
  size: 15pt,
  lang: "en",
  footer: (center: smallcaps[irregular verbs]),
  (
    verb("to be", ("was / were", "been"), "sein"),
    verb("to go", ("went", "gone"), "gehen"),
    verb("to see", ("saw", "seen"), "sehen"),
    verb("to take", ("took", "taken"), "nehmen"),
    verb("to write", ("wrote", "written"), "schreiben"),
    verb("to begin", ("began", "begun"), "beginnen"),
  ),
)
