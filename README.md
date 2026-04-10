# modern-cv-cn-en

A bilingual (Chinese/English) resume template for [Typst](https://typst.app/), combining the sidebar-based Chinese layout from [OrangeX4/Chinese-Resume-in-Typst](https://github.com/OrangeX4/Chinese-Resume-in-Typst) with the modern justified layout from [ptsouchlos/modern-cv](https://github.com/ptsouchlos/modern-cv).

Each language keeps its native design language — serif + sidebar for Chinese, sans-serif + justified headers for English — with a unified accent color. The package also includes an English cover letter template.

## Features

- **Two distinct layouts** optimized for their language
  - **Chinese**: IBM Plex Serif + Noto Serif CJK SC, sidebar date columns, rectangular photo, SVG icon bullets
  - **English**: Source Sans 3 + Roboto, justified title/location rows, circular photo, small caps
- **Photo and no-photo variants** for every document
- **Unified accent color** (`#262F99` by default, overridable with one parameter)
- **English cover letter** with 10 language localizations (`en`, `de`, `fr`, `zh`, `ja`, etc.)
- **Package-ready** structure for publishing to Typst Universe

## Quick Start

```typst
#import "@preview/modern-cv-cn-en:0.1.0": *

// English resume
#show: en-resume.with(
  author: (
    firstname: "John",
    lastname: "Smith",
    email: "js@example.com",
    phone: "(+1) 111-111-1111",
    github: "johnsmith",
    linkedin: "johnsmith",
    positions: ("Software Engineer", "Full Stack Developer"),
  ),
  profile-picture: image("profile.png"),  // omit for no-photo version
)

= Experience
#resume-entry(
  title: "Senior Engineer",
  location: "San Francisco, CA",
  date: "2021 - Present",
  description: "Acme Corp",
)
#resume-item[
  - Led migration to microservices
  - Reduced API latency by 40%
]
```

```typst
#import "@preview/modern-cv-cn-en:0.1.0": *

// Chinese resume
#show: cn-resume.with(
  photograph: image("profile.png", width: 10em),  // omit for no-photo version
  photograph-width: 10em,
  gutter-width: 2em,
)[
  = 李明

  #info(
    color: default-accent-color,
    (icon: fa-phone, content: "(+86) 133-3333-3333"),
    (icon: fa-envelope, content: "liming@example.com", link: "mailto:liming@example.com"),
    (icon: fa-github, content: "github.com/liming-dev", link: "https://github.com/liming-dev"),
  )
][
  计算机专业学生，专注于全栈开发和云计算技术。
]

== #fa-graduation-cap 教育背景
#item([2024.06 – 2020.09], [*北京大学* · 计算机科学与技术], [GPA: 3.8/4.0])
```

## Requirements

### Typst
Typst 0.12.0 or later. Install via:

```bash
brew install typst          # macOS
cargo install --locked typst-cli   # cross-platform
```

### Fonts

For the output to render correctly (without fallbacks), install these fonts on your system:

**Chinese template:**
- [IBM Plex Serif](https://www.ibm.com/plex/) — `brew install --cask font-ibm-plex`
- [Noto Serif CJK SC](https://fonts.google.com/noto/specimen/Noto+Serif+SC) — `brew install --cask font-noto-serif-cjk`

**English template:**
- [Source Sans 3](https://github.com/adobe-fonts/source-sans/releases) — install the **static** OTF version (Typst does not fully support variable fonts yet). Download `OTF-source-sans-*.zip` from the Adobe releases page and copy the `.otf` files to `~/Library/Fonts/` (macOS) or `~/.local/share/fonts/` (Linux).
- [Roboto](https://github.com/googlefonts/roboto-3-classic/releases) — install the **static** TTF version from the latest `Roboto_v*.zip` release. Copy files from the `hinted/static/` directory to your fonts folder.
- [Font Awesome Free](https://fontawesome.com/download) — `brew install --cask font-fontawesome`

> **Note:** The Homebrew casks `font-source-sans-3` and `font-roboto` install *variable* fonts which Typst will warn about. Use the static versions from the GitHub release pages linked above.

### Typst dependencies (auto-resolved)

The English template depends on two Typst packages which are fetched automatically on first compile:
- `@preview/fontawesome:0.6.0` — contact icons
- `@preview/linguify:0.5.0` — cover letter localization

## Package Structure

```
modern-cv-cn-en/
├── lib.typ                     # Package entry — re-exports all public functions
├── typst.toml                  # Package metadata
├── lang.toml                   # 10 language localizations (used by cover letter)
├── src/
│   ├── common.typ              # Shared accent color + SVG icon system
│   ├── cn/
│   │   └── resume.typ          # Chinese resume template
│   └── en/
│       ├── helpers.typ         # Internal helpers (layout, contacts, footer)
│       ├── resume.typ          # English resume template
│       └── coverletter.typ     # English cover letter template
├── icons/                      # FontAwesome SVGs used by the Chinese template
└── template/                   # Ready-to-edit examples
    ├── resume-cn.typ           # Chinese resume with photo
    ├── resume-cn-no-photo.typ  # Chinese resume centered, no photo
    ├── resume-en.typ           # English resume with circular photo
    ├── resume-en-no-photo.typ  # English resume, no photo
    ├── coverletter-en.typ      # English cover letter with photo
    └── coverletter-en-no-photo.typ  # English cover letter, no photo
```

## Template Variants

| File | Language | Photo | Layout |
|---|---|---|---|
| `resume-cn.typ` | Chinese | Yes (rectangular, in header grid) | Sidebar with vertical dividers |
| `resume-cn-no-photo.typ` | Chinese | No (centered name) | Sidebar with vertical dividers |
| `resume-en.typ` | English | Yes (circular, top-right) | Justified title/location rows |
| `resume-en-no-photo.typ` | English | No (centered name) | Justified title/location rows |
| `coverletter-en.typ` | English | Yes (circular, top-left) | Right-aligned header |
| `coverletter-en-no-photo.typ` | English | No | Right-aligned header |

## Usage

### Local development (before publishing to `@preview`)

Clone the repo and compile directly from `template/`:

```bash
git clone https://github.com/rudyzhang/modern-cv-cn-en.git
cd modern-cv-cn-en
typst compile --root . template/resume-en.typ
```

All 6 template examples use `#import "../lib.typ": *` for local development. When the package is published, change this to `#import "@preview/modern-cv-cn-en:0.1.0": *`.

### Customizing the accent color

```typst
#show: en-resume.with(
  accent-color: rgb("#8B0000"),  // dark red
  // ...
)
```

The `accent-color` parameter works identically on `cn-resume`, `en-resume`, and `en-coverletter`.

### Customizing icons (Chinese template)

The package ships pre-rendered icon constants using the default accent color. To use a custom color, use `make-icon` with the raw SVG data:

```typst
#import "@preview/modern-cv-cn-en:0.1.0": *

#let my-color = rgb("#8B0000")
#let fa-phone = make-icon(fa-phone-svg, fill: my-color)
#let fa-github = make-icon(fa-github-svg, fill: my-color)
// ... etc
```

## Public API

### `cn-resume` (Chinese)

| Parameter | Default | Description |
|---|---|---|
| `accent-color` | `rgb("#262F99")` | Theme color |
| `photograph` | `none` | Image content (e.g. `image("photo.png")`) |
| `photograph-width` | `0em` | Photo width (set >0 when using photo) |
| `gutter-width` | `0em` | Space between header text and photo |
| `size` | `10pt` | Base font size |
| `margin` | `(top: 1.5cm, bottom: 2cm, left: 2cm, right: 2cm)` | Page margins |
| `header-center` | `false` | Center the name (incompatible with `photograph`) |

**Content helpers:** `sidebar`, `item`, `info`, `date`, `tech`

### `en-resume` (English)

| Parameter | Default | Description |
|---|---|---|
| `author` | `(:)` | Dict: `firstname`, `lastname`, `email`, `phone`, `github`, `linkedin`, `positions`, etc. |
| `accent-color` | `rgb("#262F99")` | Theme color |
| `profile-picture` | `none` | Image content |
| `colored-headers` | `true` | Color section headers with accent |
| `language` | `"en"` | Language (affects name order and localized strings) |
| `font` | `"Source Sans 3"` | Body font |
| `header-font` | `"Roboto"` | Name font |

**Content helpers:** `resume-entry`, `resume-item`, `resume-skill-item`, `resume-skill-grid`, `resume-gpa`, `resume-certification`, `github-link`

### `en-coverletter` (English)

Same parameters as `en-resume` plus `signature`, `closing`, `par-spacing`, `heading-padding`.

**Content helpers:** `hiring-entity-info`, `letter-heading`, `default-signature`, `default-closing`

## Credits

- Chinese layout based on [OrangeX4/Chinese-Resume-in-Typst](https://github.com/OrangeX4/Chinese-Resume-in-Typst)
- English layout based on [ptsouchlos/modern-cv](https://github.com/ptsouchlos/modern-cv)
- Icons: [Font Awesome](https://fontawesome.com/)

## License

MIT
