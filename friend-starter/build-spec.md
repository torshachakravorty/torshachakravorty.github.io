# Website redesign — build spec (template)

**Base:** Jekyll / Minimal Mistakes (AcademicPages flavor)
**Purpose:** Hand to Claude Code to apply a clean, token-driven redesign onto an existing Minimal Mistakes fork. This is a *generic* version of a spec that was already built and shipped on a real site — the design system is proven; you fill in your own palette, fonts, and content.

> Adapted from a friend's site. The structure and CSS layer come ready-made in
> `redesign-layer/`. This spec explains the design *decisions* so you (and your
> Claude) can adjust them to your own taste and field.

---

## 0. Workflow — preview before going live

- GitHub Pages builds the live site from your main branch. Do all redesign work on a **separate branch** (e.g. `redesign`). Nothing is public until you merge.
- Preview locally: `bundle exec jekyll serve --livereload` → http://localhost:4000.
- Commit as you go — git history is your safety net.

---

## 1. Design tokens

### Color (light theme, single accent)

The whole palette is **9 values** in `_sass/_variables.scss` (see `_palette-snippet.scss`). Pick your own accent — keep it a light theme with one accent for cohesion.

| Role | Token | Example (plum) |
|---|---|---|
| Page background | `$rd-page-bg` | `#faf8f6` |
| Body text (ink) | `$rd-ink` | `#221f24` |
| Muted text | `$rd-muted` | `#56525c` |
| Faint text / meta | `$rd-faint` | `#8a8590` |
| **Accent** — links, rules, eyebrows | `$rd-accent` | `#6b4e71` |
| Accent fill — pills, photo bg | `$rd-accent-fill` | `#efe9f1` |
| Featured tint — highlighted block | `$rd-featured-tint` | `#f6f1f7` |
| Pill / accent-on-fill text | `$rd-pill-text` | `#4a3550` |
| Hairline border | `$rd-hairline` | `rgba(0,0,0,0.12)` |

**Accessibility (keep this):** accent on the page background should be ≥ 4.5:1 contrast (the plum example is ~6.6:1). Links must be **underlined**, never distinguished by color alone — so the design works for colorblind readers.

### Typography
- Headings / display: **serif** (example: Source Serif 4).
- Body / UI: **sans** (example: Inter).
- Mono (rare): JetBrains Mono.
- Sentence case for all headings. Two weights only (regular + medium).
- Fonts are loaded in `_includes/head/custom.html` and assigned in `_variables.scss`.

### Shape & spacing
- Border radius: 8px general, 12px cards. All borders 0.5px hairline.
- Profile photo: an **arched duotone** treatment (your photo tinted to the accent over the accent-fill color); shape `border-radius: 44px 44px 10px 10px`. Always give it descriptive alt text. *(Optional — a plain photo is fine too.)*

---

## 2. Navigation

Lives in `_data/navigation.yml`. The example set is `Research · Projects · Teaching · CV`. **Change this to your own pages** — comment a line out with `#` to hide it, add a line to show one. Each `url` must match that page's `permalink`.

---

## 3. Pages (adjust to your field)

The original is an academic site. Keep what fits you, rename/drop the rest.

### Home (`_pages/about.md`)
- Photo (left) beside your name (serif).
- One-line **hero tagline** — who you are in a sentence.
- **About paragraph** — first person, a few sentences.
- **Links row**: CV · GitHub · LinkedIn · Email (accent, underlined).
- Hairline divider, then two columns of "selected" highlights linking to full pages.

### Research / Work (`_pages/research.md`)
- A featured item in a tinted block: eyebrow label, serif title, one-line summary (always visible), then a meta row with an **expandable abstract** (real `<button>` + `aria-expanded`, keyboard operable) and links.
- A plain list of further items below.
- *Non-academic? Rename to "Work" / "Writing" and use the same expandable-card pattern.*

### Projects (`_pages/projects.html`)
- Each entry: category eyebrow, title, one-line description, tech-tag pills, and a **link slot that varies by what exists** — `GitHub ↗`, `Draft · Slides`, `In progress`, or `proprietary`. **No dead links / empty placeholder repos.**

### Teaching (`_pages/teaching_new.md`)
- Simple list of courses. *Drop this page if it doesn't apply — remove it from navigation.yml too.*

### CV / résumé (`_pages/cv.md`)
- Clickable cards linking to PDF(s), each with a one-line "who it's for" + format/date.
- A short highlights strip (Now / Background / Toolkit) for skimmers.
- The full CV text lives in the **PDF**, not on the page.

---

## 4. Accessibility checklist (keep all of these)

- Links underlined, not color-only.
- Contrast ≥ 4.5:1 (check your accent against the page bg).
- Photo has descriptive alt text.
- Expandable sections use real `<button>` + `aria-expanded`, keyboard operable.
- Never encode meaning by color alone — pair with text or an icon.

---

## 5. Things to fill in before launch

- Your 9 palette values (and fonts, if changing).
- Your real content in each page (the included pages have the original author's
  text as a working example — replace it).
- Per-project link states (public repo vs slides vs in-progress).
- Your CV/résumé PDF(s) and their "updated" dates.
- Trim navigation to the pages you actually have.
