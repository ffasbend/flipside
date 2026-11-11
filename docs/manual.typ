// The flipside manual. Build it with docs/build.sh (renders the images first).

#let version = "0.1.0"

#set document(title: "flipside – manual", author: "Frank Fasbender")
#set page(paper: "a4", margin: (x: 22mm, top: 22mm, bottom: 24mm),
  numbering: "1",
  header: context if counter(page).get().first() > 1 {
    set text(size: 8pt, fill: gray.darken(30%))
    [flipside #version #h(1fr) manual]
  })
#set text(font: "New Computer Modern", size: 10.5pt, lang: "en")
#set par(justify: true, leading: 0.6em)
#set heading(numbering: "1.1")
#show heading.where(level: 1): it => { pagebreak(weak: true); v(4mm); text(size: 17pt, it); v(2mm) }
#show heading.where(level: 2): it => { v(3mm); text(size: 12.5pt, it); v(1mm) }
#show raw: set text(font: "DejaVu Sans Mono", size: 8.2pt)
#show raw.where(block: false): box.with(fill: luma(240), inset: (x: 2pt), outset: (y: 2pt), radius: 2pt)
#show raw.where(block: true): block.with(fill: luma(245), inset: 7pt, radius: 3pt, width: 100%,
  stroke: 0.4pt + luma(210), breakable: false)
#show link: set text(fill: rgb("#0b5394"))

// ── Helpers ──

// The code of a snippet, exactly as it was compiled for the pictures
#let code(file, lang: "typ") = raw(read(file), lang: lang, block: true)

// A part of a rendered page: the region (x, y, w, h) of an image of a page
// of size (page-w, page-h), shown `width` wide.
#let crop(path, page-w, page-h, x, y, w, h, width: 166mm) = {
  let f = width / w
  box(width: width, height: h * f, clip: true, stroke: 0.4pt + luma(180),
    place(top + left, dx: -x * f, dy: -y * f,
      image(path, width: page-w * f, height: page-h * f, fit: "stretch")))
}
// A whole page, with a thin frame
#let shot(path, width: 80mm) = box(stroke: 0.4pt + luma(180), image(path, width: width))
#let caption(body) = align(center, text(size: 8.5pt, fill: gray.darken(40%), body))

// The first row of the question page and of the answer page of an A8 deck
#let a8 = (w: 297mm, h: 210mm, cw: 297mm / 4, ch: 210mm / 4)
#let front-back(name, rows: 1, width: 166mm) = {
  crop("img/" + name + "-1.png", a8.w, a8.h, 0mm, 0mm, a8.w, a8.ch * rows, width: width)
  caption[question page (odd page)]
  v(1mm)
  crop("img/" + name + "-2.png", a8.w, a8.h, 0mm, 0mm, a8.w, a8.ch * rows, width: width)
  caption[answer page (even page): the columns are mirrored]
}
// The first rows of a list page (A4 portrait)
#let list-rows(name, rows: 2, width: 120mm) = align(center,
  crop("img/" + name + "-1.png", 210mm, 297mm, 8mm, 8mm, 194mm, 4mm + rows * 52.5mm + 2mm, width: width))

#let tip(body) = block(fill: rgb("#eef5e9"), inset: 8pt, radius: 3pt, width: 100%,
  stroke: (left: 2pt + rgb("#6aa84f")), body)
#let warn(body) = block(fill: rgb("#fdf3e6"), inset: 8pt, radius: 3pt, width: 100%,
  stroke: (left: 2pt + rgb("#e69138")), body)

// ── Title page ──

#v(30mm)
#align(center)[
  #text(size: 36pt, weight: "bold")[flipside]
  #v(2mm)
  #text(size: 14pt)[Double-sided flash cards that line up when printed]
  #v(6mm)
  #text(size: 11pt)[Manual · version #version]
  #v(2mm)
  #text(size: 10pt)[Frank Fasbender]
]
#v(12mm)
#align(center, shot("img/template-1.png", width: 140mm))
#v(8mm)

#align(center, box(width: 140mm, align(left)[
  flipside lays out flash cards for double-sided printing. The odd pages hold the
  questions with cutting lines, the even pages the answers, placed so that each
  answer lands exactly behind its question. The same file also gives a *list* to
  check every card before printing, and a *calibration sheet* to make up for
  printers that shift the back side.
]))

#pagebreak()
#outline(indent: auto, depth: 2)

= Getting started

== What you get

A deck is a list of cards, each with a question side `q` and an answer side `a`.
flipside puts as many cards as fit on a sheet (16 for the default DIN A8 size on
A4), the questions on one page and the answers on the next. When the sheet is
printed double-sided and cut along the lines, every card has its question on
the front and its answer on the back.

#front-back("first")

The answer page is the question page *mirrored left to right*: the first card
of a row is at the right on the answer page. That is what makes the answer land
behind its question when the sheet is turned over like a book page.

== Installing

Once the package is on Typst Universe, nothing has to be installed: the import
below downloads it the first time you compile.

```typ
#import "@preview/flipside:0.1.0": *
```

To start a new deck from the template:

```sh
typst init @preview/flipside:0.1.0 my-cards
```

#tip[*Before publication, or to use your own copy:* put the package folder into
Typst's local package folder (macOS:
`~/Library/Application Support/typst/packages/local/flipside/0.1.0`, Linux:
`~/.local/share/typst/packages/local/flipside/0.1.0`) and import
`@local/flipside:0.1.0` instead. A relative import such as
`#import "flipside/lib.typ": *` works too, and also in the Typst web app.]

== A first deck

#code("snippets/first.typ")

Compile it with `typst compile cards.typ`, or in the Typst web app or your
editor. The result is the sheet shown above: page 1 with the questions, page 2
with the answers. Print *all pages double-sided* (see @printing).

= Writing cards

== Several lines, small print, lists

Write one printed line per source line and end every line but the last with
`\`. Everything Typst can do works inside a card: maths, bold, lists, images.

#code("snippets/lines.typ")

#front-back("lines")

The helpers `small[…]` (72 %) and `tiny[…]` (60 %) make text smaller,
`block-left[…]` aligns a longer text left and justifies it (cards are centred
by default).

#warn[A line starting with `1.` or `-` becomes a numbered or bulleted list in
Typst. To print "1." as plain text at the start of a line, write `1\.`.]

== Themes and other fields

An entry *without* `q` and `a` is no card and takes no place on the sheet. Its
fields are given to every card after it, until another entry changes them. Use
it for themes, chapters, levels, anything the header and footer should show
(@slots).

#code("snippets/fields.typ")

#crop("img/fields-1.png", a8.w, a8.h, 0mm, 0mm, a8.w, a8.ch)
#caption[`c.theme` in the footer; `(q: [], a: [])` is a blank card: an empty place on the sheet, without number]

Every card also gets `number` (1, 2, …; `none` for blank cards) and `total`
(the number of cards without the blank ones).

== Cards made by a function

When many cards look alike, let a function make them:

```typ
#let element(symbol, name, number) = (
  q: text(size: 2.4em, weight: "bold", symbol),
  a: [#name \ #small[atomic number #number]],
)

#flipside((
  element("Li", "Lithium", 3),
  element("Na", "Sodium", 11),
))
```

The same goes for questions with a common pattern:

```typ
#let digit(d) = [Which place has the digit #d \ in the number 1'234'056.789?]
#flipside((
  (q: digit(6), a: [units]),
  (q: digit(5), a: [tens]),
))
```

#tip[Typst turns `'` after a digit into a prime (′). To get a typographic
apostrophe as thousands separator, write `’` (or `\u{2019}`) in that number.]

== Cards from a CSV file <csv>

A word list from Excel, LibreOffice or Google Sheets, saved as CSV, can be used
directly: Typst reads CSV files itself.

#grid(columns: (1fr, 1fr), gutter: 4mm,
  code("snippets/words.csv", lang: "csv"),
  code("snippets/csv.typ"))

#crop("img/csv-1.png", a8.w, a8.h, 0mm, 0mm, a8.w, a8.ch)
#caption[The answer side (page 2) shows "le vendeur / la vendeuse" on two lines.]

- Columns `q` and `a` are the two sides; every other column (here `theme`)
  becomes a field of the card.
- An *empty cell* keeps the value of the rows above, so the theme is written
  only once.
- A row with *no question and no answer* but other cells only sets those
  fields, like `(theme: …)` above.
- A *line break inside a cell* is a line break on the card.
- Without a header row, `csv("words.csv")` gives rows of (question, answer).
- Excel often uses `;` as separator: `csv("words.csv", delimiter: ";")`.
- Cells are plain text. With `markup: true` they are read as Typst markup, so
  `$x^2$`, `*bold*` or `_italic_` work.
- CSV cards and written cards can be mixed:
  ```typ
  #flipside(
    csv("words.csv", row-type: dictionary)
      + ((theme: "Extra"), (q: [Hallo], a: [Salut]))
  )
  ```

= Header and footer <slots>

Each side of a card has a header and a footer with three places, called
*slots*: `left`, `center` and `right`.

#table(columns: 3, stroke: 0.4pt + luma(180), inset: 5pt,
  [*Parameter*], [*Side*], [*Example*],
  [`header`], [question side, top], [`(left: logo, right: [Class 7a])`],
  [`footer`], [question side, bottom], [`(left: c => c.theme)`],
  [`back-header`], [answer side, top], [`(right: [Answers])`],
  [`back-footer`], [answer side, bottom], [`(right: number)`],
)

A slot is content (the same on every card) or a *function* that gets the card
and returns content. The card has `q`, `a`, `number`, `total` and the fields
of the entries above it.

#code("snippets/slots.typ")

#front-back("slots")

- The card number appears as "1/3". It is `none` on blank cards, which is
  why the `number` function checks it.
- Printing the number on the answer side helps to put the cards back in order
  and to find a card in the list.
- Slots are designed for a DIN A8 card and grow with larger cards. Their text
  is `slot-font` / `slot-size` (default 7 pt); `text(size: …)[…]` inside a slot
  overrides it.
- On small cards there is little room: a long centre slot runs into the
  corner slots.
- `c.theme` fails on a card without theme; `c.at("theme", default: none)`
  does not.

= Language, fonts and size

#code("snippets/lang.typ")

`lang` sets the language for hyphenation and quotation marks: `"fr"` for both
sides, or one per side with `(q: "de", a: "fr")`. Above, the German side gets
German quotes „…“ and the French side French ones «…» with the right spaces.

#crop("img/lang-1.png", a8.w, a8.h, 0mm, 0mm, a8.w / 2, a8.ch, width: 110mm)
#crop("img/lang-2.png", a8.w, a8.h, a8.w / 2, 0mm, a8.w / 2, a8.ch, width: 110mm)

- `font` and `size` set the text of the cards (default: New Computer Modern,
  13 pt). The fonts built into Typst are New Computer Modern, Libertinus Serif
  and DejaVu Sans Mono; with them the cards look the same on every computer.
- The text does *not* grow with the card size. For large cards raise `size`,
  e.g. `size: 18pt` for DIN A7, `size: 22pt` for DIN A6.

= Text that is too large <fit>

With `fit: true` (the default) a side whose content is too large for the card
is shrunk until it fits, so nothing is cut off or runs into the footer.

#code("snippets/fit.typ")

#crop("img/fit-2.png", a8.w, a8.h, a8.w / 2, 0mm, a8.w / 2, a8.ch, width: 110mm)
#caption[The answer of card 2 shrunk to fit]

The list (@list) shows these cards under their number, e.g. `A 84%`: the
answer side is printed at 84 %. With `fit: false` nothing is shrunk, and the
list marks the cards that are too large in red ("A too large"), so you can
shorten them yourself.

#list-rows("fit-list", rows: 2)

= Coloured stripes per theme <stripe>

A coloured stripe on one edge of the card makes it easy to sort cut cards. The
stripe is printed on the same edge on both sides.

#code("snippets/stripe.typ")

#front-back("stripe")

- `stripe: auto`: one colour per theme, in the order the themes appear (a
  palette that stays distinguishable for colour-blind readers).
- `stripe: ("Europe": blue, "Asia": orange)`: your own colours, by theme;
  themes not named get no stripe.
- `stripe: c => if c.number > 10 { red }`: any rule, as a function of the card.
- `stripe-width` sets its width (2.5 mm on an A8 card; it grows with the card).

= Card sizes and paper <sizes>

== The sizes

#table(columns: 5, stroke: 0.4pt + luma(180), inset: 5pt, align: (left, left, left, center, left),
  [*`card:`*], [*Card*], [*Paper*], [*Per sheet*], [*Sheet*],
  [`"DIN A8"` (default)], [74 × 52 mm], [A4], [16], [landscape],
  [`"DIN A7"`], [105 × 74 mm], [A4], [8], [portrait],
  [`"DIN A6"`], [148 × 105 mm], [A4], [4], [landscape],
  [`"DIN A5"`], [210 × 148 mm], [A4], [2], [portrait],
  [`"US 3x5"`], [5 × 3 in], [Letter], [4], [landscape],
  [`"US 4x6"`], [6 × 4 in], [Letter], [2], [portrait],
  [`"US business"`], [3.5 × 2 in], [Letter], [10], [portrait],
  [`"EU business"`], [85 × 54 mm], [A4], [10], [portrait],
)

"DIN" can be left out (`"A8"`), and case and spaces do not matter. The DIN
sizes fill the A4 sheet exactly. The other sizes are centred; the business
cards match the usual *perforated business-card sheets*, so no cutting is
needed.

#let sizes = ("DIN_A8", "DIN_A7", "DIN_A6", "DIN_A5", "US_3x5", "US_4x6", "US_business", "EU_business")
#grid(columns: 4, gutter: 3mm, align: center + bottom,
  ..sizes.map(s => [#shot("img/size-" + s + "-1.png", width: 37mm) \ #text(size: 8pt, s.replace("_", " "))]))

== Paper

The paper follows the card: A4 for DIN and EU sizes, Letter for US sizes.
`paper:` chooses another one: `"a4"`, `"us-letter"`, `"a3"`, `"a5"` or
`"us-legal"`. The number of cards and the way the sheet is turned are worked
out for that paper.

```typ
#flipside(card: "DIN A7", paper: "us-letter", …)   // 6 per sheet
```

== Upright cards

`orientation: "portrait"` turns any size upright, e.g. 16 upright A8 cards on
a portrait sheet (right), or DIN A7 on Letter paper (left, above):

#grid(columns: 2, gutter: 6mm, align: center + bottom,
  [#shot("img/size-A7-letter-1.png", width: 55mm) \ #text(size: 8pt)[DIN A7 on Letter]],
  [#shot("img/size-A8-portrait-1.png", width: 55mm) \ #text(size: 8pt)[DIN A8, `orientation: "portrait"`]])

== A size of your own

```typ
#flipside(card: (width: 90mm, height: 60mm), …)
```

As many cards as fit are centred on the sheet. For a perforated sheet you
have, give its layout exactly:

```typ
card: (
  width: 85mm, height: 55mm,       // one card
  cols: 2, rows: 5,                // cards per row and column
  gap: (x: 5mm, y: 0mm),           // space between the cards (or gap: 3mm)
  margin: (left: 15mm, top: 13.5mm), // first card, from the sheet's corner
)
```

The answer page is mirrored, so its left margin is the right margin of the
question page; nothing else has to be given.

= Printing <printing>

== Duplex settings

Print *all pages* double-sided, at 100 % ("actual size"):

#table(columns: 2, stroke: 0.4pt + luma(180), inset: 5pt,
  [*Sheet*], [*Duplex setting*],
  [landscape (DIN A8, A6, US 3x5)], [*flip on short edge*],
  [portrait (DIN A7, A5, US 4x6, business cards)], [*flip on long edge*],
)

The sheet is turned over like a book page: left and right swap, the top stays
at the top.

#warn[Test with the first sheet before printing everything: hold it against
the light, the answer behind the top-left card must belong to the top-left
question. *Answers upside down?* Choose the other duplex setting. *Answers
behind the wrong cards?* Check that the printer is not set to "booklet" or
"several pages per sheet", and that the scale is 100 %.]

*Printer without duplex:* print the odd pages, put the stack back into the
tray turned over like a book page, print the even pages. How the paper has to
go in depends on the printer: try it with one sheet.

*Cutting:* cut along the lines of the question page. Printers leave a few mm
unprinted at the paper edge, so the outer lines may be missing; that does not
matter.

== Calibration: when the back side is shifted

Many duplex printers shift the back side by up to a millimetre or two, so the
answers are not centred behind the questions. The *calibration sheet*
measures it:

```sh
typst compile --input layout=calibrate cards.typ calibrate.pdf
```

Print its two pages double-sided at 100 % and hold the sheet against the
light. Each card has an *x ruler* and a *y ruler* on the front and two lines
on the back; seen through the paper, the lines cross the rulers at the values,
in mm, to add to `back-offset`. The front also shows the `back-offset` the
sheet was made with.

#grid(columns: 2, gutter: 6mm,
  [#crop("img/calibrate-1.png", a8.w, a8.h, 0mm, 0mm, a8.cw, a8.ch, width: 78mm)
   #caption[front: the rulers]],
  [#crop("img/calibrate-2.png", a8.w, a8.h, 3 * a8.cw, 0mm, a8.cw, a8.ch, width: 78mm)
   #caption[back of the same card: the lines]])

If the vertical back line crosses the x ruler at −0.5 and the horizontal one
crosses the y ruler at 1, write:

```typ
#flipside(back-offset: (x: -0.5mm, y: 1mm), …)
```

or, when compiling, `--input back-offset=-0.5mm,1mm`. Print the calibration
sheet again with the new values: the lines should now cross at 0. The values
belong to the printer (and its paper tray), not to the deck; keep them in a
note or put the line in all your decks for that printer.

== Reprinting some cards

A card got lost, or a few were corrected? `only` prints just these cards,
packed onto as few sheets as needed:

```sh
typst compile --input only=5-12,17 cards.typ reprint.pdf
```

In the file: `only: "5-12,17"`, `only: (3, 8)`, or a function such as
`only: c => c.theme == "Asia"`. The numbers and the total stay those of the
whole deck, so the reprinted cards fit back in. It works with the list too.

= The list: checking the cards <list>

Proof-reading cut cards is tedious. The list shows every card on one row: its
number, the sheet it is printed on (F1, F2, …), the question side and the
answer side, each exactly as printed.

```sh
typst compile --input layout=list cards.typ cards-list.pdf
```

#align(center, shot("img/template-list-1.png", width: 105mm))

- Or in the file: `layout: "list"`. The `--input` always wins over the file,
  so the file can stay on `"cards"`.
- The list is on the same paper as the cards, landscape for large cards; large
  cards are shown smaller, so that both sides fit next to each other.
- Cards shrunk to fit, or too large with `fit: false`, are marked under their
  number (@fit).
- `title` names the deck in the list's page footer.

= Command line <cli>

Everything that changes between two printouts can be chosen when compiling;
it always wins over the file:

#table(columns: 2, stroke: 0.4pt + luma(180), inset: 5pt,
  [*Input*], [*Example*],
  [`layout`], [`--input layout=list`, `--input layout=calibrate`],
  [`card`], [`--input card=A7`, `--input card="US 3x5"`],
  [`paper`], [`--input paper=us-letter`],
  [`orientation`], [`--input orientation=portrait`],
  [`only`], [`--input only=5-12,17`],
  [`back-offset`], [`--input back-offset=0.8mm,-0.5mm` (plain numbers are mm)],
)

A deck file can also take its settings from variables at the top, which is
handy in the Typst web app:

```typ
#let layout = "cards"   // "cards", "list" or "calibrate"
#let card = "DIN A8"

#flipside(layout: layout, card: card, …)
```

= Reference <reference>

```typ
#flipside(cards, header: (:), footer: (:), back-header: (:), back-footer: (:),
  title: none, lang: "en", font: "New Computer Modern", size: 13pt,
  slot-font: "New Computer Modern", slot-size: 7pt, back-borders: false,
  fit: true, stripe: none, stripe-width: 2.5mm, markup: false,
  back-offset: (x: 0mm, y: 0mm), only: none, layout: "cards",
  card: "A8", paper: auto, orientation: "landscape")
```

#set par(justify: false)
#table(columns: (auto, auto, 1fr), stroke: 0.4pt + luma(180), inset: 5pt,
  [*Parameter*], [*Default*], [*Meaning*],
  [`cards`], [—], [the cards: `(q: […], a: […])`, entries with fields only, blank cards `(q: [], a: [])`, CSV rows],
  [`header`, `footer`], [`(:)`], [slots of the question side: `(left:, center:, right:)`, content or `c => …`],
  [`back-header`, `back-footer`], [`(:)`], [slots of the answer side],
  [`title`], [`none`], [name of the deck, in the list's page footer],
  [`lang`], [`"en"`], [`"fr"`, or one per side: `(q: "de", a: "fr")`],
  [`font`, `size`], [New Computer Modern, 13 pt], [text of the cards],
  [`slot-font`, `slot-size`], [New Computer Modern, 7 pt], [text of the slots (on an A8 card)],
  [`back-borders`], [`false`], [outline the answer cards too],
  [`fit`], [`true`], [shrink a side that is too large],
  [`stripe`], [`none`], [`auto`, `("Theme": colour)` or `c => colour`],
  [`stripe-width`], [`2.5mm`], [width of the stripe on an A8 card],
  [`markup`], [`false`], [read strings (CSV cells) as Typst markup],
  [`back-offset`], [`(x: 0mm, y: 0mm)`], [shift of the answer pages for the printer],
  [`only`], [`none`], [only some cards: `"5-12,17"`, `(3, 8)` or `c => bool`],
  [`layout`], [`"cards"`], [`"cards"`, `"list"` or `"calibrate"`],
  [`card`], [`"A8"`], [a size name (@sizes) or `(width:, height:, cols:, rows:, gap:, margin:)`],
  [`paper`], [`auto`], [`"a4"`, `"us-letter"`, `"a3"`, `"a5"`, `"us-legal"`],
  [`orientation`], [`"landscape"`], [`"portrait"` for upright cards],
)

*Helpers:* `small[…]` (72 %), `tiny[…]` (60 %), `block-left[…]` (left-aligned,
justified). *Values:* `card-sizes` (the size table), `papers`,
`stripe-palette` (the colours of `stripe: auto`).

#set par(justify: true)

= Examples <examples>

The folder `examples` of the package holds complete decks. Compile them from
the package folder with `typst compile --root . examples/<name>.typ`.

#let example(name, title, body) = block(breakable: false, {
  heading(level: 2, title)
  body
  v(1mm)
  grid(columns: 2, gutter: 4mm, align: center + bottom,
    shot("img/example-" + name + "-1.png", width: 80mm),
    shot("img/example-" + name + "-list-1.png", width: 56mm))
  caption[#raw("examples/" + name + ".typ"): first sheet, and the list]
})

#example("vocabulary", "Vocabulary from a CSV file")[
  German–French words read from `vocabulary.csv`, DIN A7 cards (8 per sheet,
  text at 18 pt), a stripe per theme, German hyphenation and quotes on the
  question side, French on the answer side.
]

#example("maths", "Maths")[
  Formulas, several lines per side, lists and small print; a stripe colour
  chosen per theme; the theme in the header; a long answer that is shrunk
  to fit.
]

#example("business-cards", "Business-card sheets")[
  Chemical elements on perforated 85 × 54 mm sheets (10 per A4): no cutting.
  The cards are made by a function `element(symbol, name, number)`.
]

#example("us-index-cards", "US index cards")[
  3 × 5 inch cards on Letter paper, in Libertinus Serif.
]

#example("upright-cards", "Upright cards of your own size")[
  60 × 90 mm upright cards, 3 × 3 per sheet with gaps between them, made by a
  function: irregular verbs.
]

= Questions and answers

/ The answers are behind the wrong cards: Make sure you print all pages at
  100 %, double-sided, with the duplex setting of @printing, and not as a
  booklet. Test with one sheet first.
/ The answers are all a little off-centre: The printer shifts the back side.
  Measure it with the calibration sheet and set `back-offset`.
/ Some text is very small on a card: It did not fit and was shrunk (`fit`).
  The list shows which cards; shorten them, or use a larger card.
/ The text looks small on large cards: The text does not grow with the card;
  raise `size`.
/ I want different headers for some cards: Put a field in an entry (e.g.
  `(chapter: "2"),`) and show it with a function slot: `c => c.chapter`.
/ How do I print the same deck in two sizes?: Keep the file and choose the
  size when compiling: `--input card=A7`.
/ Can I use my own fonts?: Yes, any font installed on your computer:
  `font: "Arial"`. The built-in fonts look the same everywhere, others only
  where they are installed.
