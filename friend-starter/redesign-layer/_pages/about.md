---
permalink: /
excerpt: "ONE-LINE SITE DESCRIPTION — shown in search results and link previews."
author_profile: false
redirect_from:
  - /about/
  - /about.html
---

<!-- ================================================================
     HOME — hero + two columns
     Replace every [PLACEHOLDER] with your own content. Keep the HTML
     tags/classes as-is. Photo: drop your image in /images/ and update
     the filename in the <img src=...> line below.
     ================================================================ -->

<div class="rd-hero">
  <div class="rd-hero__photo rd-photo">
    <img src="{{ '/images/profile.jpg' | relative_url }}"
         alt="[YOUR NAME] — short description of the photo." />
  </div>
  <div class="rd-hero__text">
    <h1 class="rd-hero__name">[YOUR NAME]</h1>
    <p class="rd-hero__lede">[ONE-LINE TAGLINE — who you are in a single sentence.]</p>
  </div>
</div>

<div class="rd-about" markdown="1">
[ABOUT PARAGRAPH — a few sentences, first person. What you study or do, what
you're working on now, and your background. Rewrite freely in your own voice.]
</div>

<ul class="rd-linkrow">
  <li><a href="/files/Your-CV.pdf" target="_blank" rel="noopener">CV</a></li>
  <li><a href="{{ '/cv/' | relative_url }}">Résumé</a></li>
  <li><a href="https://github.com/YOUR-USERNAME">GitHub</a></li>
  <li><a href="https://www.linkedin.com/in/YOUR-HANDLE">LinkedIn</a></li>
  <li><a href="mailto:you@example.com">Email</a></li>
</ul>

<hr class="rd-divider" />

<div class="rd-cols">

  <section class="rd-col">
    <h2 class="rd-subhead">Selected research</h2>
    <span class="rd-eyebrow">[Category label]</span>
    <p class="rd-paper-title">[Featured item title]</p>
    <p class="rd-finding">[One-line summary of the finding or work.]</p>
    <ul class="rd-reslinks">
      <!-- Use a real link OR a status. Delete the one you don't need. -->
      <li><span class="rd-reslinks__state">Draft coming soon</span></li>
      <li><a href="{{ '/research/' | relative_url }}">More research →</a></li>
    </ul>
  </section>

  <section class="rd-col">
    <h2 class="rd-subhead">Selected projects</h2>

    <p class="rd-project__title">[Project one title]</p>
    <p class="rd-project__desc">[One-line description.]</p>
    <ul class="rd-tags">
      <li class="rd-pill">[Tag]</li>
      <li class="rd-pill">[Tag]</li>
    </ul>

    <p class="rd-project__title" style="margin-top:1.25rem;">[Project two title]</p>
    <p class="rd-project__desc">[One-line description. <span class="rd-reslinks__state">(optional status)</span>]</p>
    <ul class="rd-tags">
      <li class="rd-pill">[Tag]</li>
      <li class="rd-pill">[Tag]</li>
    </ul>

    <ul class="rd-reslinks" style="margin-top:1rem;">
      <li><a href="{{ '/projects/' | relative_url }}">All projects →</a></li>
    </ul>
  </section>

</div>
