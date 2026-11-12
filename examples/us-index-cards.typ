// US history on 3 × 5 inch index cards, printed on Letter paper (4 per sheet).
//
//   typst compile us-index-cards.typ
#import "@preview/flipside:0.2.1": *

#let number(c) = if c.number != none [#c.number/#c.total]

#flipside(
  title: "US history",
  card: "US 3x5",
  size: 16pt,
  font: "Libertinus Serif",
  header: (left: smallcaps[US history], right: number),
  (
    (q: [In which year was the \ Declaration of Independence signed?], a: [1776]),
    (q: [Who was the first \ President of the United States?], a: [George Washington \ #small[(1789–1797)]]),
    (q: [Which purchase doubled \ the size of the US in 1803?], a: [The Louisiana Purchase]),
    (q: [When did the \ Civil War end?], a: [1865]),
    (q: [Which amendment abolished slavery?], a: [The 13th Amendment \ #small[(1865)]]),
    (q: [In which year did women \ win the right to vote?], a: [1920 \ #small[(19th Amendment)]]),
  ),
)
