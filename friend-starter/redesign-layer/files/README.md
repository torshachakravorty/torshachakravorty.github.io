# files/ — put your PDFs here

Drop your documents (CV, résumé, job-market paper, slides) into this folder in your
repo, then link to them **directly** from your pages — never link to a PDF sitting in
a GitHub repo (`github.com/.../blob/...`). Hosting them here means they live on your
own domain, open inline in a new tab, and keep a stable URL. See
`../../DEPLOY-AND-GOTCHAS.md` §8 for the full reasoning.

## Naming rules
- **No spaces, no special characters** (clean URLs). Use hyphens: `Jane-Doe-CV.pdf`.
- **Descriptive** — the filename is what a visitor sees when they save it. `cv.pdf`
  lands in their Downloads as a meaningless "cv.pdf"; `Jane-Doe-CV.pdf` is clear.
- **No dates or version numbers** — overwrite the *same* file each time you update, so
  the link on your site never has to change. (`Jane-Doe-CV.pdf`, not `CV_2026_v2.pdf`.)

## What the pages already expect
`_pages/cv.md` and `_pages/about.md` are pre-wired to these two paths:

```
/files/Your-CV.pdf
/files/Your-Resume.pdf
```

So either **rename your PDFs to match those names**, or edit the `href="..."` values
in `cv.md` (both cards) and `about.md` (the link-row) to match your filenames. Each
document gets two links, already set up for you:

```html
<a href="/files/Your-CV.pdf" target="_blank" rel="noopener">View ↗</a>  <!-- opens inline in a new tab -->
<a href="/files/Your-CV.pdf" download>Download</a>                       <!-- saves the file -->
```

(This `README.md` is just a note — you can leave it in the folder or delete it; it
won't appear on your site.)
