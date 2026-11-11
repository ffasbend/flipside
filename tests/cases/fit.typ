// fit: true (default): the large sides are shrunk; the list shows by how much
#import "../../lib.typ": *
#flipside((
  (q: [short], a: [#for j in range(14) [line #j \ ]]),
  (q: [#lorem(60)], a: [short]),
  (q: [fits], a: [fits]),
))
