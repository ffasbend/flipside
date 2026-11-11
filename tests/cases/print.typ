// back-offset, only, stripe as a function, fit: false with a card too large
#import "../../lib.typ": *
#flipside(
  back-offset: (x: 2mm, y: -1mm),
  only: "2-4,7",
  fit: false,
  stripe: c => if calc.even(c.number) { red } else { blue },
  back-borders: true,
  footer: (right: c => [#c.number]),
  range(1, 9).map(i => (
    q: [Question #i],
    a: if i == 3 { [#for j in range(14) [line #j \ ]] } else [Answer #i],
  )),
)
