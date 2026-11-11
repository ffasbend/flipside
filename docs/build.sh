#!/bin/sh
# Builds the manual: renders the snippets and examples to PNG images in
# docs/img, then compiles docs/manual.typ to docs/manual.pdf.
#
#   docs/build.sh            (uses `typst` from the PATH, or $TYPST)
#
# The snippets import @preview/flipside like a user would; this folder is
# given to Typst as that package, so nothing is downloaded.

cd "$(dirname "$0")/.." || exit 1
TYPST=${TYPST:-typst}
VERSION=$(sed -n 's/^version = "\(.*\)"/\1/p' typst.toml)
PKG=$(mktemp -d)
trap 'rm -rf "$PKG"' EXIT
mkdir -p "$PKG/preview/flipside" "$PKG/local/flipside"
ln -s "$PWD" "$PKG/preview/flipside/$VERSION"
ln -s "$PWD" "$PKG/local/flipside/$VERSION"

rm -rf docs/img; mkdir -p docs/img
# png PPI NAME FILE [options]: pages 1 and 2 of FILE as docs/img/NAME-1.png, -2.png
# (150 ppi for pictures cropped to single cards, 90 ppi for whole pages)
png() {
  ppi=$1; name=$2; file=$3; shift 3
  "$TYPST" compile --root . --package-path "$PKG" --ignore-system-fonts --pages 1-2 --ppi "$ppi" "$@" "$file" "docs/img/$name-{n}.png" \
    || { echo "error in $file"; exit 1; }
}

for f in docs/snippets/*.typ; do
  n=$(basename "$f" .typ)
  png 150 "$n" "$f"
  png 150 "$n-list" "$f" --input layout=list
done
png 150 calibrate docs/snippets/first.typ --input layout=calibrate
for card in "DIN A8" "DIN A7" "DIN A6" "DIN A5" "US 3x5" "US 4x6" "US business" "EU business"; do
  png 90 "size-$(echo "$card" | tr ' ' '_')" tests/cases/sizes.typ --input "card=$card"
done
png 90 size-A8-portrait tests/cases/sizes.typ --input orientation=portrait
png 90 size-A7-letter tests/cases/sizes.typ --input "card=DIN A7" --input paper=us-letter
for f in examples/*.typ; do
  n=$(basename "$f" .typ)
  png 90 "example-$n" "$f"
  png 90 "example-$n-list" "$f" --input layout=list
done
png 90 template template/main.typ
png 90 template-list template/main.typ --input layout=list

"$TYPST" compile --root . --package-path "$PKG" --ignore-system-fonts docs/manual.typ docs/manual.pdf \
  && echo "docs/manual.pdf written"

