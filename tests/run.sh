#!/bin/sh
# Tests for the flipside package.
#
#   tests/run.sh            compile everything, compare with the reference images
#   tests/run.sh --update   make the reference images anew (check them first!)
#
# Uses `typst` from the PATH, or the one in $TYPST. The reference images in
# tests/ref were made with Typst 0.15.1 (the package also works with 0.13); another Typst version may draw some
# pixels differently: then look at tests/out and run with --update.
#
# What is tested:
#   1. every example, the template and the test cases compile without errors
#      or warnings, as cards, list and calibration sheet;
#   2. a small deck in every card size, both orientations and both papers;
#   3. wrong arguments give the expected error message (tests/errors);
#   4. the pages look exactly like the reference images (tests/ref).

cd "$(dirname "$0")/.." || exit 1
TYPST=${TYPST:-typst}
OUT=tests/out
REF=tests/ref
UPDATE=0
[ "${1:-}" = "--update" ] && UPDATE=1

rm -rf "$OUT"; mkdir -p "$OUT/pdf" "$OUT/png"
failed=0; passed=0
ok()   { passed=$((passed + 1)); }
fail() { failed=$((failed + 1)); echo "FAIL  $*"; }

# The template imports @local/flipside: give Typst this folder as that package
PKG=$(mktemp -d)
trap 'rm -rf "$PKG"' EXIT
VERSION=$(sed -n 's/^version = "\(.*\)"/\1/p' typst.toml)
mkdir -p "$PKG/local/flipside"
ln -s "$PWD" "$PKG/local/flipside/$VERSION"

# compile NAME FILE [typst options...]: must succeed without any message
compile() {
  name=$1; file=$2; shift 2
  msg=$("$TYPST" compile --root . --package-path "$PKG" --ignore-system-fonts "$@" "$file" "$OUT/pdf/$name.pdf" 2>&1)
  if [ $? -ne 0 ] || [ -n "$msg" ]; then fail "$name"; echo "$msg" | head -8; else ok; fi
}
# render NAME FILE [options...]: PNG pages to compare with the references
render() {
  name=$1; file=$2; shift 2
  "$TYPST" compile --root . --package-path "$PKG" --ignore-system-fonts --ppi 30 "$@" "$file" "$OUT/png/$name-{n}.png" 2>/dev/null \
    || fail "render $name"
}

echo "1. Examples, template and test cases"
for f in examples/*.typ template/main.typ tests/cases/*.typ; do
  base=$(basename "$(dirname "$f")")-$(basename "$f" .typ)
  for layout in cards list calibrate; do
    compile "$base-$layout" "$f" --input layout=$layout
    render "$base-$layout" "$f" --input layout=$layout
  done
done

echo "2. Every card size"
for card in "DIN A8" "DIN A7" "DIN A6" "DIN A5" "US 3x5" "US 4x6" "US business" "EU business"; do
  for orientation in landscape portrait; do
    for paper in auto a4 us-letter; do
      [ "$paper" = auto ] && p="" || p="--input paper=$paper"
      name="size-$(echo "$card" | tr ' ' '_')-$orientation-$paper"
      # shellcheck disable=SC2086
      compile "$name" tests/cases/sizes.typ --input "card=$card" --input orientation=$orientation $p
      [ "$paper" = auto ] && render "$name" tests/cases/sizes.typ --input "card=$card" --input orientation=$orientation
    done
  done
done
compile size-custom tests/cases/sizes.typ --input card=A8 # short name still works

echo "3. Error messages"
for f in tests/errors/*.typ; do
  expect=$(sed -n 's|^// expect: ||p' "$f")
  msg=$("$TYPST" compile --root . "$f" "$OUT/pdf/error.pdf" 2>&1)
  if [ $? -ne 0 ] && echo "$msg" | grep -q "$expect"; then ok
  else fail "$f: expected an error with \"$expect\""; echo "$msg" | head -4; fi
done

echo "4. Reference images"
if [ $UPDATE -eq 1 ]; then
  rm -rf "$REF"; cp -r "$OUT/png" "$REF"
  echo "      $(ls "$REF" | wc -l | tr -d ' ') reference images written to $REF"
else
  for f in "$REF"/*.png; do
    [ -e "$f" ] || { fail "no reference images: run tests/run.sh --update"; break; }
    n=$(basename "$f")
    if [ ! -e "$OUT/png/$n" ]; then fail "page missing: $n"
    elif cmp -s "$f" "$OUT/png/$n"; then ok
    else fail "page differs: $n (see $OUT/png/$n)"; fi
  done
  for f in "$OUT"/png/*.png; do
    [ -e "$REF/$(basename "$f")" ] || fail "new page, not in the references: $(basename "$f")"
  done
fi

echo
echo "$passed passed, $failed failed"
[ $failed -eq 0 ]
