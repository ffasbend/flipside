#import "@preview/flipside:0.2.0": *

#flipside(
  stripe: auto,
  footer: (left: c => c.theme),
  (
    (theme: "Europe"),
    (q: [France], a: [Paris]),
    (q: [Spain], a: [Madrid]),
    (theme: "Asia"),
    (q: [Japan], a: [Tokyo]),
    (theme: "Africa"),
    (q: [Kenya], a: [Nairobi]),
  ),
)
