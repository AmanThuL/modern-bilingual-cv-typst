# CLAUDE.md

Project-specific instructions for Claude Code when working in this repo.

## Project Overview

`modern-cv-cn-en` is a Typst package providing bilingual (Chinese/English) resume templates. It combines two upstream templates:

- **Chinese layout** ported from [OrangeX4/Chinese-Resume-in-Typst](https://github.com/OrangeX4/Chinese-Resume-in-Typst) — sidebar-based with serif fonts
- **English layout** ported from [ptsouchlos/modern-cv](https://github.com/ptsouchlos/modern-cv) — justified headers with sans-serif fonts

The package also includes an English cover letter template. Each language keeps its native design; only the accent color and SVG icon utilities are shared.

## Architecture

```
lib.typ                 # Package entry — re-exports all public functions
src/
├── common.typ          # Shared: accent color, SVG icon system (make-icon + data constants)
├── cn/resume.typ       # Chinese template (sidebar layout)
└── en/
    ├── helpers.typ     # Internal: colors, FA icons, layout helpers, contact formatting, footers
    ├── resume.typ      # English resume template
    └── coverletter.typ # English cover letter template
icons/                  # SVG files used by the Chinese template
template/               # 6 working examples (photo × no-photo × 3 document types)
```

**Key design decisions:**

1. **Two independent layouts, not one unified one.** Chinese and English resumes differ in sections, ordering, and cultural expectations. Forcing a shared layout would compromise both.
2. **Minimal shared layer.** Only accent color and icon system are in `common.typ`. Layout logic, fonts, and content functions stay per-template.
3. **SVG data + `make-icon()`**, not `icon(path)`. Typst's `read()` resolves relative to the source file, not the caller. Storing raw SVG data at compile time (via `read()` in `common.typ`) avoids path-resolution bugs and lets users re-color icons with any accent color.
4. **`photograph` takes image content, not a string path.** Same reason as above — `image(path)` inside a library file doesn't resolve relative to the user's file.
5. **English template internals are in `helpers.typ`.** The helpers are shared between resume and coverletter. Private helpers are prefixed with `__`.

## Common Commands

```bash
# Compile all 6 template examples
for f in resume-cn resume-cn-no-photo resume-en resume-en-no-photo coverletter-en coverletter-en-no-photo; do
  typst compile --root . template/${f}.typ template/${f}.pdf
done

# Compile a single template
typst compile --root . template/resume-en.typ

# Check what fonts Typst can see
typst fonts | grep -i "ibm plex\|noto serif cjk\|source sans\|roboto\|font awesome"
```

**Important:** Always compile with `--root .` from the repo root. Without it, Typst refuses to import `../lib.typ` from the template files.

## Required Fonts

Templates depend on these fonts being installed at the system level:

| Font | Used by | Install |
|---|---|---|
| IBM Plex Serif | Chinese body | `brew install --cask font-ibm-plex` |
| IBM Plex Mono | Chinese mono | `brew install --cask font-ibm-plex` |
| Noto Serif CJK SC | Chinese CJK | `brew install --cask font-noto-serif-cjk` |
| Source Sans 3 | English body | **Static OTF** from https://github.com/adobe-fonts/source-sans/releases |
| Roboto | English headers | **Static TTF** from https://github.com/googlefonts/roboto-3-classic/releases |
| Font Awesome 7 Free | English icons | `brew install --cask font-fontawesome` |

**Gotcha:** The Homebrew casks `font-source-sans-3` and `font-roboto` install *variable* fonts which Typst warns about. Use the static OTF/TTF versions from the GitHub release pages instead. The static fonts go in `~/Library/Fonts/` (macOS) or `~/.local/share/fonts/` (Linux).

## Coding Conventions

- **Typst style:** Follow the upstream templates' style. Existing code uses 2-space indentation, lowercase kebab-case identifiers, `#let` bindings, and `show` rules for layout.
- **Private helpers:** Prefix with `__` (e.g. `__justify_align`, `__format_author_name`). These are internal to `src/en/` and not re-exported through `lib.typ`.
- **Shared state:** Keep `common.typ` minimal. Don't add English-specific things there.
- **Imports:** Use separate `#import` lines per source file rather than wildcard imports where practical. `lib.typ` uses aliased imports (`resume as cn-resume`) to avoid name collisions.

## Testing

This is a template/library project, not application code. "Testing" means compilation:

1. All 6 files in `template/` must compile cleanly.
2. Compilation should produce zero warnings with the required fonts installed.
3. If you change a helper, recompile all affected examples — helpers in `src/en/helpers.typ` are used by both `resume.typ` and `coverletter.typ`.

When making changes, always run the compile loop above before committing.

## Publishing

When publishing to Typst Universe (`@preview`):

1. Update example files in `template/*.typ` to import from `@preview/modern-cv-cn-en:0.1.0` instead of `../lib.typ`.
2. Ensure `typst.toml` metadata is accurate (version, authors, repository, description).
3. Create a `thumbnail.png` at the repo root (referenced in `typst.toml`).
4. Remove or relocate `docs/superpowers/` before packaging (not needed in the published package).

## Known Issues

- **FontAwesome icons in `icons/`** — Some of the bundled SVGs were extracted from Font Awesome Pro 6.4.0 (commercial license). Before publishing to Typst Universe, these need to be replaced with Font Awesome Free SVGs or the package should use the `@preview/fontawesome` package for CN icons too.
- **LinkedIn/Scholar contact items** in `src/en/helpers.typ` always use Western name order (`firstname lastname`) regardless of the `language` setting. `__format_author_name` handles CJK order correctly but isn't used for these specific contact items.
- **`lflib._linguify` is a private API** of the `linguify` package. Used for PDF document metadata. A minor version bump of linguify could break it silently.

## Files to Read First

When starting work in this repo:

1. `src/common.typ` — understand the icon system first (SVG data + `make-icon`)
2. `src/cn/resume.typ` — Chinese template show rule + content functions
3. `src/en/helpers.typ` — English template shared internals
4. `src/en/resume.typ` and `src/en/coverletter.typ` — English show rules
5. `lib.typ` — see what's exported publicly
