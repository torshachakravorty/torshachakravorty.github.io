# HANDOFF — read me first (for Claude)

You're helping someone apply a finished, proven redesign onto **their own fork of
Minimal Mistakes** (AcademicPages flavor). A friend of theirs built this redesign
on the same base template and is sharing it. Your job is to transplant the design
*layer* onto their repo, set it up so they can pick their own colors, and port the
page structures with their content to fill in. **Do not rebuild from scratch — the
design system already exists in `redesign-layer/`.**

This redesign has been **built, deployed, and is live** on the original author's
site — it's production-tested, not a draft. **Read `DEPLOY-AND-GOTCHAS.md` before you
start and again before the user pushes to production** — it documents every problem
that actually came up during build and deploy (the Sass/Ruby split, GitHub auth, the
browser-cache scare, etc.). It will save you the same hours it cost the first time.

## What's in this folder

```
friend-starter/
  HANDOFF.md            ← this file
  DEPLOY-AND-GOTCHAS.md ← READ THIS — every problem that hit during build + deploy
  build-spec.md         ← the design system explained (palette, type, per-page structure, a11y)
  EDITING.md            ← plain-English guide to editing each page's content
  redesign-layer/       ← the actual files to transplant (mirrors real repo paths)
    _sass/_redesign.scss          ← the entire visual component layer
    _sass/_palette-snippet.scss   ← palette tokens + wiring to merge into _variables.scss
    _includes/head/custom.html    ← loads the webfonts (+ favicons/mathjax from the original)
    _data/navigation.yml          ← nav menu (example set)
    _pages/about.md               ← Home
    _pages/research.md            ← Research/Work (expandable-abstract pattern)
    _pages/projects.html          ← Projects (tag pills + variable link slot)
    _pages/teaching.md            ← Teaching
    _pages/cv.md                  ← CV/résumé cards (PDF links pre-wired to /files/)
    files/README.md               ← where their CV/résumé/paper PDFs go
```

The page files are **placeholder skeletons** — the structure and CSS classes are
real and working, but the text is `[PLACEHOLDER]` markers. Keep the markup, replace
the placeholders with the user's own content.

## How the redesign works (the key idea)

It's a **layer on top of stock Minimal Mistakes**, and every visual choice routes
through `$rd-*` SCSS tokens. So re-theming = changing **9 hex values** in one block.
The user already has identical copies of all the *base* MM files (layouts, the other
sass partials, plugins) — you only touch the files in `redesign-layer/`.

## Steps

1. **Read `DEPLOY-AND-GOTCHAS.md`, `build-spec.md`, and `EDITING.md`** to understand
   the failure modes, the design system, and the per-page structure before touching
   anything.

2. **Confirm the base.** Check the user's repo is a Minimal Mistakes / AcademicPages
   fork (look for `_sass/_variables.scss`, `assets/css/main.scss`, `_config.yml`,
   `_data/navigation.yml`). If it's a meaningfully different version, adapt paths
   rather than assuming.

3. **Work on a branch.** `git checkout -b redesign` so nothing touches their live site.

4. **Transplant the layer:**
   - Copy `_sass/_redesign.scss` into their `_sass/`.
   - Add `@import "redesign";` as the **last** line of their `assets/css/main.scss`
     (it must load after the base styles so it overrides them).
   - Merge the contents of `_palette-snippet.scss` into their `_sass/_variables.scss`
     (the palette tokens block + the wiring assignments + the typography vars). Don't
     paste the file as-is — integrate it into the existing Colors/Typography sections,
     replacing MM's defaults for those specific variables.
   - Copy `_includes/head/custom.html` — but **keep the user's own favicons** if they
     have them; the parts you need are the webfont `<link>` and the `theme-color` meta.
     Merge, don't blindly overwrite.

5. **Port the pages.** For each page in `redesign-layer/_pages/`, bring the structure
   into the user's `_pages/`, keep the front-matter `permalink` consistent with their
   `navigation.yml`, and replace the example content with placeholders for the user to
   fill (or their real content if they give it to you). Drop pages they don't need
   (e.g. Teaching) and remove those nav entries.

6. **Set navigation.** Edit `_data/navigation.yml` to the user's actual pages.

7. **Leave colors easy to change.** Make sure the 9 `$rd-*` tokens are clearly
   commented so the user can pick their own palette. Offer to set an accent for them —
   ask for a color they like, keep it a light theme, and verify the accent has ≥4.5:1
   contrast on the page background.

8. **Preview, then deploy.** Have them run `bundle exec jekyll serve --livereload`
   and open http://localhost:4000. If styles don't apply, the most common cause is the
   `@import "redesign";` line missing or not being last in `main.scss`. When it looks
   right locally, deploy per `DEPLOY-AND-GOTCHAS.md` — push to their deploy branch,
   confirm **Settings → Pages** shows a green build, then **hard-refresh (`Ctrl+F5`)**
   the live URL before judging it (a stale browser cache will make a perfect deploy
   look broken — see §3 of that file).

## Gotchas

**See `DEPLOY-AND-GOTCHAS.md` for the full field guide** — the Sass/Ruby local-vs-live
split (the one most likely to break the deploy), GitHub PAT auth + the 403/credential
trap, the browser-cache "it looks like the old site!" scare, what does and doesn't
hot-reload, permalink rules, hosting PDFs locally, and the content gotchas (MathJax
`$`, unique abstract ids, closing every HTML tag, WCAG contrast). Don't deploy without
skimming it.

## What "done" looks like

The site builds locally, every nav page renders in the new style, links are
underlined, the palette is driven by the 9 tokens, and the user knows that editing
those 9 values re-themes everything. Then hand them `EDITING.md` for ongoing content
edits.
