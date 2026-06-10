# DEPLOY & GOTCHAS — the hard-won lessons (for Claude)

This redesign has now been **built, merged, and deployed live** on the original
author's site. This file is the field guide to the things that actually went wrong
during build and deploy — read it *before* you start, and again before the user
pushes to production. None of these are hypothetical; every one of them cost real
time. They are ordered roughly by how likely they are to bite.

---

## 1. The local-vs-live Sass split (the big one)

There are **two different build environments**, and they are not the same:

| | Local preview | Live site (GitHub Pages) |
|---|---|---|
| Built by | native **Jekyll 4** + **Dart Sass** | GitHub Pages' **classic build** (old **Ruby Sass / LibSass**, "safe mode") |
| Triggered by | `bundle exec jekyll serve` | every push to the deploy branch (usually `master`/`main`) |

The classic GitHub Pages builder uses an **older Sass engine** than the user runs
locally. So a stylesheet that compiles perfectly on their laptop can **fail to build
on GitHub** — and when a Pages build fails, GitHub silently keeps serving the
*previous* version and just emails the repo owner. The result looks like "my redesign
didn't deploy."

**What LibSass / old Ruby Sass does NOT support** — keep `_redesign.scss` and the
palette free of all of these:
- `@use` / `@forward` (Dart-only module system) — use plain `@import`.
- `math.div(...)` — use the `/` division operator.
- The modern module functions: `color.adjust()`, `color.scale()`, `map.get()`,
  `list.*`, `string.*`, etc. Use the old global forms (`darken()`, `lighten()`,
  `map-get()`) if you need them at all.

The shipped `_redesign.scss` already obeys this (it was checked). If you *add* SCSS,
stay in the old dialect. **Quick self-check before pushing:**
```
grep -REn '@use|@forward|math\.div|color\.(adjust|scale|mix)|map\.get' _sass/
```
If that returns anything, the live build may break even though local is fine.

> Dart-Sass **deprecation warnings** during local `serve` are harmless — they're
> local-only and GitHub Pages ignores them. (The original silenced them with
> `quiet_deps: true` and `sass: { silence_deprecations: [...] }` in `_config.yml`;
> GitHub Pages ignores unknown `_config.yml` keys, so those are safe to leave in.)

### The permanent fix (recommended): build with GitHub Actions instead

The cleanest way to make this whole class of problem disappear is to **stop using the
classic builder** and build the site with a GitHub Actions workflow that runs the
*same* Jekyll the user runs locally. Then local == live, forever. If the user is
willing, add this file as **`.github/workflows/jekyll.yml`** and then, in the repo's
**Settings → Pages → "Build and deployment" → Source**, switch from "Deploy from a
branch" to **"GitHub Actions"**:

```yaml
name: Build and deploy Jekyll site
on:
  push:
    branches: [master]   # or main — match their deploy branch
  workflow_dispatch:
permissions:
  contents: read
  pages: write
  id-token: write
concurrency:
  group: pages
  cancel-in-progress: false
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ruby/setup-ruby@v1
        with: { ruby-version: '3.3', bundler-cache: true }
      - uses: actions/configure-pages@v5
      - run: bundle exec jekyll build --baseurl "${{ steps.pages.outputs.base_path }}"
        env: { JEKYLL_ENV: production }
      - uses: actions/upload-pages-artifact@v3
  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - id: deployment
        uses: actions/deploy-pages@v4
```

This needs a working `Gemfile`/`Gemfile.lock` in the repo (the user already builds
locally, so they have one). Only do this if they're comfortable — the classic builder
works fine *as long as* the SCSS stays in the old dialect (section 1).

---

## 2. `@import "redesign";` must be the LAST line of `assets/css/main.scss`

The entire visual layer hangs off this one line. If it's missing, or not last, you
get a page that's *almost* styled (base Minimal Mistakes) but missing all the `rd-*`
components — which reads as "the spacing and layout are wrong." If styles don't apply,
**check this first.**

---

## 3. "The live site looks like the OLD design!" → it's browser cache

This caused a real panic. After deploying, the author opened the live URL and it
looked like the *old* site — wrong spacing, layout, colors. The deploy was actually
fine. The cause: **browser cache.** They had visited the site many times before the
redesign, so their browser had the **old stylesheet** saved and kept reusing it
(new HTML + old CSS = a broken-looking mash-up). `localhost` never looked wrong
because it had never cached an old version of that address.

**The fix is always the same — do this before assuming anything is broken:**
1. **Hard refresh:** `Ctrl+F5` (or `Ctrl+Shift+R`). This forces a re-download of CSS/JS.
2. **Incognito/Private window** (`Ctrl+Shift+N` / `Ctrl+Shift+P`) — ignores cache
   entirely; this is the *definitive* test.

First-time visitors never hit this (no old cache), so it's purely a local annoyance,
not a real bug. **Don't go editing files to "fix" a cache problem.**

How to *truly* tell live from stale: pick a string you changed in the last commit
(e.g. a heading you just edited) and check whether the live page shows the new or old
version. Don't trust an analysis of the giant minified `main.css` — it gets truncated.

---

## 4. Deploys take a few minutes — and you must check the build status

A push doesn't go live instantly; the classic builder takes ~1–5 minutes, plus CDN
propagation. To see what happened, go to the repo's **Settings → Pages** (shows
"Your site is live… last deployed N minutes ago") and the **Actions** tab:
- 🟡 building → wait.
- 🔴 failed → open it, read the error (usually Sass, section 1), fix, re-push.
- 🟢 succeeded → if it still looks wrong, it's cache (section 3).

---

## 5. GitHub push authentication (HTTPS) — passwords don't work anymore

Pushing over HTTPS will fail with **"Password authentication is not supported"** —
GitHub removed password auth. The user needs a **Personal Access Token (PAT)**:
1. github.com → **Settings → Developer settings → Personal access tokens → Tokens
   (classic)** → Generate new token → tick the **`repo`** scope → copy the `ghp_…` token.
2. `git push` → when prompted, **Username** = their GitHub username, **Password** =
   the **token** (not their account password).

Then watch for a follow-up **403 "Permission denied"**: that means auth *worked* but
the **token lacks scope** — they forgot to tick `repo` (classic), or (fine-grained
token) didn't grant the repo **Contents: Read and write**. Make a token with the
right scope.

**Windows caching trap:** Windows saves the first token in **Credential Manager**, so
a bad token keeps getting reused even after they make a good one. Fix: *Start → search
"Credential Manager" → Windows Credentials → remove the `git:https://github.com`
entry*, then push again and enter the new token. (Alternative to all of this:
`winget install GitHub.cli` then `gh auth login` and pick the browser flow.)

---

## 6. What hot-reloads locally — and what does NOT

With `jekyll serve --livereload` running, edits to **page bodies, `_includes`,
`_layouts`, and SCSS** auto-rebuild and refresh the browser. But these require a
**full server restart** (`Ctrl+C`, then `serve` again):
- **`_config.yml`** — read once at startup, never re-read.
- **`_data/` files** (incl. `navigation.yml`) — loaded at startup.
- **Adding or deleting files** — the watcher often misses files appearing/disappearing.

Rule of thumb: changed *what's inside* an existing file → it hot-reloads; changed
*which files exist*, or touched `_config.yml`/`_data/` → restart. When unsure, restart.

---

## 7. Pages: permalink ≠ filename, and duplicate permalinks break the build

- A page's **URL comes from its `permalink:` front-matter, not its filename.** You can
  rename `teaching_new.md` → `teaching.md` with zero URL change as long as `permalink`
  stays the same. The filename is just tidiness.
- **Two pages with the same `permalink` is a build error.** If you replace an old
  collection-driven page (e.g. a stock `teaching.html` that loops over a `_teaching`
  collection) with a new hand-written one, **delete the old file** so only one claims
  the permalink.
- To put a page in the menu, its `permalink` must be referenced by a `url:` in
  `_data/navigation.yml`. Three things to keep in sync: the file, its `permalink`, and
  the nav entry.

---

## 8. Host documents locally — don't link CV/résumé/papers to GitHub

Put PDFs (CV, résumé, job-market paper, slides) in a **`/files/`** folder in the repo
and link to them **directly** (e.g. `/files/Their-CV.pdf`). Do **not** link to a PDF
sitting in a GitHub repo (`github.com/.../blob/...`):
- A `/blob/` link dumps the visitor into GitHub's code-viewer UI; the `/raw/` link
  forces a download. Neither is the clean "click → document opens" you want.
- A local file lives on *their* domain, opens **inline in a new tab**, has a stable
  URL, and can't break when a separate repo is renamed or made private.

Link pattern used on the cards and link-row:
```html
<a href="/files/Their-CV.pdf" target="_blank" rel="noopener">View ↗</a>
<a href="/files/Their-CV.pdf" download>Download</a>
```
**Name files descriptively, no spaces, no dates** — `Jane-Doe-CV.pdf`, not `cv.pdf`
or `CV_2026.pdf`. (No date so the URL never changes — they overwrite the same file on
each update and the site links keep working.) The `cv.md` placeholder is already wired
this way. *Reserve GitHub links for actual code/data repositories.*

---

## 9. Smaller content gotchas (carried over from the original build)

- **Dollar signs render as math.** MathJax treats `$...$` as inline math, so a literal
  `$100` in body text can render oddly. Write it as `<span>$</span>&nbsp;100`.
- **Expandable abstracts need unique ids.** Each toggle's `aria-controls="x"` must
  match its body's `id="x"`, and every id must be unique on the page or the toggle
  breaks. (See `EDITING.md`.)
- **Raw HTML in markdown = close every tag.** The pages use real HTML inside `.md`
  files; an unclosed `<p>`/`<div>`/`<li>` silently mangles the layout.
- **Contrast.** If they pick a pale accent or faint grey, verify text hits **WCAG AA
  (≥4.5:1)** against the background before calling it done.

---

## TL;DR pre-push checklist

1. SCSS in old dialect? (`grep` from section 1 returns nothing.)
2. `@import "redesign";` is the last line of `main.scss`.
3. Built locally with `jekyll serve` and every nav page looks right.
4. Restarted the server after any `_config.yml` / `_data/` / new-file change.
5. PDFs in `/files/`, linked directly — no GitHub `/blob/` document links.
6. After push: check **Settings → Pages** is green, then **`Ctrl+F5`** before judging.
