# Editing this website

A plain-English guide to changing the content on each page. You do **not** need
to know how to code — almost every edit is "find the text, change the text, save."

- **Where the pages live:** the `_pages/` folder.
- **What the design looks like:** controlled by `_sass/_redesign.scss` (you rarely
  touch this — it's the styling, not the content).
- **Navigation menu:** `_data/navigation.yml`.

---

## 1. How to preview your changes

1. Start the local site (one time per session). In a terminal:
   ```
   bundle exec jekyll serve --livereload
   ```
   Leave it running.
2. Open **http://127.0.0.1:4000/** in your browser.
3. Edit any file, **save it**, and the browser reloads automatically.
   - If a change doesn't show up, hard-refresh: **Ctrl+Shift+R**.

Nothing you do locally is public until you commit and push the changes with git.
You can experiment freely.

---

## 2. Things that are true on every page

### The header block (don't break this)
Every page starts with a block fenced by three dashes. Example:
```
---
layout: archive
title: "Projects"
permalink: /projects/
author_profile: false
---
```
This is **configuration**, not content. Leave it alone unless you specifically
want to rename the page title or change its URL. Your editable content is
everything **below** the closing `---`.

### Comments are notes to yourself
Anything between `<!--` and `-->` is a note. It does **not** appear on the
website. You can read, edit, or delete these freely. I left several marked
`TODO:` where you need to fill in real info.

### Tags come in pairs
Content is wrapped in tags like `<p>…</p>` or `<li>…</li>`. Every opening tag
(`<p>`) needs its closing partner (`</p>`). If the page suddenly looks broken,
you almost certainly deleted half of a pair — press **Ctrl+Z** to undo and try
again.

### Reusable pieces (you'll see these everywhere)
| What it does | What it looks like |
|---|---|
| Small category label | `<span class="rd-eyebrow">Numerical methods</span>` |
| A tech-tag pill | `<li class="rd-pill">Python</li>` |
| A normal link | `<a href="https://example.com">Link text ↗</a>` |
| A status with no link | `<span class="rd-reslinks__state">In progress</span>` |

---

## 3. Home page — `_pages/about.md`

This page has four parts, top to bottom:

1. **The photo + name + tagline** (the "hero").
   - Photo file: `images/profile.jpg`. To use a different photo, drop a new
     image in the `images/` folder and change the filename in the `<img src=…>` line.
   - Change your name in `<h1 class="rd-hero__name">Your Name</h1>`.
   - Change the one-line tagline in `<p class="rd-hero__lede">…</p>`.

2. **The "About" paragraph.** It sits inside:
   ```
   <div class="rd-about" markdown="1">
   ... your paragraph here ...
   </div>
   ```
   Just rewrite the sentence(s) between those two lines. (The `markdown="1"`
   lets you write normal text here — keep it.)

3. **The links row** (CV · Résumé · GitHub · LinkedIn · Email). Each is one line:
   ```
   <li><a href="https://github.com/your-username">GitHub</a></li>
   ```
   Edit the address in `href="…"` and the label between `>` and `</a>`.

4. **Two columns: "Selected research" and "Selected projects."**
   Short highlights with links to the full pages. Edit the titles/descriptions
   the same way as elsewhere.

---

## 4. Research page — `_pages/research.md`

Two sections: a **featured item** (in the tinted box) and a **list** below it.

**To edit a paper's visible text:**
- Title → `<p class="rd-paper-title">…</p>`
- One-line summary (always shown) → `<p class="rd-finding">…</p>`

**The expandable abstract.** Each paper has a hidden abstract that opens when a
visitor clicks "Abstract." It's two connected pieces:
```
<button class="rd-abs-toggle" ... aria-controls="abs-1" ...>
  <span class="rd-abs-toggle__label">Abstract</span>
</button>
...
<div class="rd-abs-body" id="abs-1" hidden>
  <p>Your abstract text goes here.</p>
</div>
```
- To **change the abstract text**, edit the `<p>…</p>` lines inside the
  `rd-abs-body` box.
- If you **copy a paper to make a new one**, you must give its button's
  `aria-controls="…"` and its body's `id="…"` a **matching, unique** name
  (e.g. change both `abs-1` to `abs-4`). They must match each other and
  not clash with any other paper's id, or the toggle won't work.

**To add the real links** when a paper is public, replace the placeholder lines
like `<li><span class="rd-reslinks__state">PDF — draft coming soon</span></li>`
with real links:
```
<li><a href="https://link-to-your.pdf">PDF</a></li>
```

> **Note on dollar signs:** this site treats `$` as math. If you need a literal
> dollar amount in the text, write it as `<span>$</span>&nbsp;100`.
> Otherwise the page may render it oddly.

---

## 5. Projects page — `_pages/projects.html`

Every project is one repeating block. Here is one, labeled:
```html
<li class="rd-project">
  <span class="rd-eyebrow">Category label</span>                       <!-- category -->
  <p class="rd-project__title">Project title</p>                      <!-- title -->
  <p class="rd-project__desc">One-line description of the project.</p><!-- description -->
  <ul class="rd-tags">                                               <!-- tech pills -->
    <li class="rd-pill">Tag</li>
    <li class="rd-pill">Tag</li>
  </ul>
  <ul class="rd-reslinks">                                           <!-- link or status -->
    <li><span class="rd-reslinks__state">Code on request</span></li>
  </ul>
</li>
```

- **Edit wording:** change the text inside the eyebrow, title, and description.
- **Add/remove a tag:** add or delete a `<li class="rd-pill">…</li>` line.
- **The link slot** (`rd-reslinks`) — use whichever fits the project:
  - Real repo: `<li><a href="https://github.com/your-username/repo">GitHub ↗</a></li>`
  - Status only: `<li><span class="rd-reslinks__state">In progress</span></li>`
    (good values: `In development`, `Code on request`, `Proprietary`, `Draft · Slides`)
- **Add a new project:** copy a whole `<li class="rd-project"> … </li>` block
  (from `<li` down to its `</li>`) and paste it as a new one, then edit it.
- **Reorder:** cut and paste whole blocks — order in the file = order on the page.
- **Delete:** remove the project's entire `<li class="rd-project"> … </li>` block.

All project blocks must stay **between** the `<ul class="rd-projects">` line and
its closing `</ul>` at the bottom.

---

## 6. Teaching page — `_pages/teaching_new.md`

A simple list. Each course is one block:
```html
<li>
  <span class="rd-eyebrow">Graduate</span>
  <p class="rd-paper-title">COURSE 101 — Course Name</p>
  <p class="rd-finding">Institution and role. Teaching assistant, Spring 2024.</p>
</li>
```
Edit the course number/name and the description line. Copy a block to add a
course. (Write `&amp;` instead of a plain `&`.)

---

## 7. CV / résumé page — `_pages/cv.md`

Two parts:

1. **Two cards** (Academic CV and Résumé). For each card you can edit:
   - Title → `<p class="rd-card__title">…</p>`
   - Who it's for → `<p class="rd-card__who">…</p>`
   - Format/date → `<p class="rd-card__meta">…</p>`
   - The two links (`View ↗` and `Download`) → change the `href="…"` to point at
     your PDF. *(The résumé links currently point at the CV as a placeholder —
     swap them when you have a résumé PDF.)*

2. **The highlights strip** (Now / Research / Before / Toolkit). Each is one line:
   ```
   <li><span class="rd-highlights__label">Now</span> Your text here.</li>
   ```
   Edit the text after the `</span>`.

The full CV text is intentionally **not** on this page anymore — it lives in the
PDF. Update the PDF separately.

---

## 8. The navigation menu — `_data/navigation.yml`

Controls the links across the top. Each item is two lines:
```yaml
  - title: "Projects"
    url: /projects/
```
- `title` is the label shown in the menu.
- `url` is the page address (must match that page's `permalink`).
- A line starting with `#` is disabled/hidden. Remove the `#` to show it, or add
  one to hide an item.

(Your name on the left of the menu is the "Home" link — it comes from the site
title in `_config.yml`, not from this file.)

---

## 9. Colours and fonts (advanced, optional)

You normally won't touch these, but if you want to:
- **Colours** are defined once in `_sass/_variables.scss` (look for the
  `Redesign palette` block — `$rd-accent` is the plum, etc.).
- **Fonts** are loaded in `_includes/head/custom.html` and assigned in
  `_sass/_variables.scss`.
- All the layout/spacing rules live in `_sass/_redesign.scss`.

Change one value (e.g. the plum hex code) and every page updates at once.

---

## 10. Quick troubleshooting

| Problem | Fix |
|---|---|
| Change isn't showing | Save the file, then hard-refresh **Ctrl+Shift+R** |
| Page looks broken / mangled | You probably deleted half a tag pair — **Ctrl+Z** to undo |
| The abstract toggle stopped working | A paper's `aria-controls` and `id` no longer match, or two papers share the same `id` — make them matching and unique |
| A dollar amount renders strangely | Write it as `<span>$</span>&nbsp;100` |
| The site won't start | Make sure you ran `bundle exec jekyll serve --livereload` from the project folder |

---

## 11. Publishing your changes (when ready)

Editing locally never affects the live site. When you're happy with a batch of
changes, you commit and push them with git (or ask for help doing so). Until
then, experiment as much as you like.
