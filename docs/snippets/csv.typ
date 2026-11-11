#import "@preview/flipside:0.2.0": *

#flipside(
  lang: (q: "de", a: "fr"),
  footer: (left: c => c.theme),
  csv("words.csv", row-type: dictionary),
)
