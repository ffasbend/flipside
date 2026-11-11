// A small deck, compiled by run.sh in every size, paper and orientation
#import "../../lib.typ": *
#let number(c) = if c.number != none [#c.number/#c.total]
#flipside(
  stripe: auto,
  header: (left: [Header left], right: number),
  footer: (left: c => c.theme, center: [·], right: number),
  back-footer: (right: number),
  (
    (theme: "One"),
    (q: [Question 1], a: [Answer 1]),
    (q: [Question 2 \ on two lines], a: [Answer 2]),
    (theme: "Two"),
    (q: [Question 3], a: [Answer 3]),
    (q: [], a: []),
    (q: [Question 5], a: [Answer 5]),
  ),
)
