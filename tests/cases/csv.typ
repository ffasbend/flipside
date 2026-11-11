// CSV: header row with extra columns, empty cells, a theme-only row,
// rows without header and with ";", markup
#import "../../lib.typ": *
#flipside(
  markup: true,
  footer: (left: c => c.at("theme", default: none), right: c => c.at("level", default: none)),
  csv("cards.csv", row-type: dictionary)
    + ((theme: "No header"),)
    + csv("plain.csv", delimiter: ";"),
)
