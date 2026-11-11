// Maths: formulas, several lines per side, small print, left-aligned answers.
// DIN A8 cards (16 per A4 sheet); sides that are too large are shrunk.
//
//   typst compile --root .. maths.typ
#import "../lib.typ": *

#let number(c) = if c.number != none [#c.number/#c.total]

#flipside(
  title: "Algebra",
  card: "DIN A8",
  lang: "en",
  header: (left: smallcaps[Maths · Year 8], right: c => c.at("theme", default: none)),
  footer: (right: number),
  back-footer: (right: c => text(fill: gray, number(c))),
  stripe: ("Powers": rgb("#0072B2"), "Equations": rgb("#E69F00"), "Fractions": rgb("#009E73")),
  (
    (theme: "Powers"),
    (q: [$a^m dot a^n = ?$], a: [$a^(m + n)$]),
    (q: [$(a^m)^n = ?$], a: [$a^(m n)$]),
    (q: [$a^0 = ?$ \ #small[($a != 0$)]], a: [$1$]),
    (q: [$a^(-n) = ?$], a: [$1 / a^n$]),
    (
      q: [Write as one power: \ $2^3 dot 2^4$],
      a: [$2^3 dot 2^4 = 2^(3 + 4) = 2^7 = 128$],
    ),
    (theme: "Equations"),
    (q: [Solve: \ $3x + 5 = 20$], a: [$3x = 15$ \ $x = 5$]),
    (q: [Solve: \ $2(x - 1) = x + 4$], a: [$2x - 2 = x + 4$ \ $x = 6$]),
    (
      q: [What may you do to both \ sides of an equation?],
      a: block-left[
        - add or subtract the same number
        - multiply or divide by the same number #small[(not 0)]
      ],
    ),
    (
      q: [Solve: \ $x^2 = 49$],
      a: [$x = 7$ or $x = -7$ \ #small[(two solutions)]],
    ),
    (theme: "Fractions"),
    (q: [$a / b + c / d = ?$], a: [$(a d + b c) / (b d)$]),
    (q: [$a / b dot c / d = ?$], a: [$(a c) / (b d)$]),
    (q: [$a / b : c / d = ?$], a: [$a / b dot d / c = (a d) / (b c)$]),
    (
      q: [Simplify: \ $18 / 24$],
      a: block-left[
        Divide numerator and denominator by their greatest common divisor 6:
        $ 18 / 24 = 3 / 4 $
        #small[A long explanation like this one is shrunk automatically when it does not fit on the card, so nothing is cut off at the bottom.]
      ],
    ),
    (q: [Is $0.5 = 1/2$?], a: [Yes: $1/2 = 5/10 = 0.5$]),
  ),
)
