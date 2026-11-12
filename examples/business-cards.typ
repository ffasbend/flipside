// Chemical elements on perforated business-card sheets (85 × 54 mm, 10 per
// A4): no cutting, just tear the cards apart. Colour per group of elements.
//
//   typst compile business-cards.typ
#import "@preview/flipside:0.2.1": *

#let element(symbol, name, number) = (
  q: [#text(size: 2.4em, weight: "bold", symbol)],
  a: [#name \ #small[atomic number #number]],
)

#flipside(
  title: "Chemical elements",
  card: "EU business",
  stripe: (
    "Alkali metals": rgb("#D55E00"),
    "Noble gases": rgb("#56B4E9"),
    "Halogens": rgb("#009E73"),
  ),
  footer: (left: c => c.theme),
  back-footer: (left: c => c.theme),
  (
    (theme: "Alkali metals"),
    element("Li", "Lithium", 3),
    element("Na", "Sodium", 11),
    element("K", "Potassium", 19),
    (theme: "Noble gases"),
    element("He", "Helium", 2),
    element("Ne", "Neon", 10),
    element("Ar", "Argon", 18),
    (theme: "Halogens"),
    element("F", "Fluorine", 9),
    element("Cl", "Chlorine", 17),
    element("Br", "Bromine", 35),
    element("I", "Iodine", 53),
  ),
)
