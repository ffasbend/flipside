# Contributing to flipside

Questions, ideas and bug reports: please open an
[issue](https://github.com/ffasbend/flipside/issues).

## Tests and the manual

- `tests/run.sh` compiles the examples, the template and test decks in every
  size and layout, checks the error messages and compares every page with the
  reference images (`--update` makes them anew).
- `docs/build.sh` renders the pictures and builds `docs/manual.pdf`.
- A new version: set `version` in `typst.toml` (and the README links), build
  the manual, commit, then `git tag v<version> && git push origin v<version>`.
  GitHub then creates the release with the manual attached
  (`.github/workflows/release.yml`).
- To use a local copy, link this folder as
  `~/Library/Application Support/typst/packages/local/flipside/<version>` (Linux:
  `~/.local/share/typst/packages/local/flipside/<version>`) and import
  `@local/flipside:<version>`.

## Publishing on Typst Universe

The package is published in [typst/packages](https://github.com/typst/packages)
as `packages/preview/flipside/<version>/`. Only these files go there:
`typst.toml`, `lib.typ`, `README.md`, `LICENSE`, `LICENSE-MIT-0`, `CHANGELOG.md`, `template/`
and `thumbnail.png` (no tests, build scripts, examples or manual: the README
links to them in this repository, at the version's tag).
