---
layout: archive
title: "Selected Research"
permalink: /research/
author_profile: false
description: "Research by Torsha Chakravorty (UCSD Economics): state capacity, brokers in public service delivery in India, and highways and innovation."
---

<p class="rd-meta" style="margin-top:-0.5rem;"></p>

<div class="rd-featured">
  <span class="rd-eyebrow">Job market paper</span>
  <h2 class="rd-paper-title">Building State Capacity in Stages: Brokers in Public Service Delivery</h2>
  <p class="rd-coauthors"><span class="rd-reslinks__state">With Parminder Pal Singh Sandhu · Walter Heller Memorial Prize (Best 3rd Year Paper)</span></p>
  <p class="rd-finding"></p>

  <ul class="rd-reslinks">
    <li><a href="{{ '/files/Torsha-Chakravorty-JMP.pdf' | relative_url }}" target="_blank" rel="noopener">Draft (frequently updated) &#8599;</a></li>
  </ul>

  <!-- JMP abstract is always shown (no button, no 'hidden'). -->
  <div class="rd-abs-body" id="abs-1">
    <p>Citizens need to establish eligibility for public benefits, and many pay private agents (brokers) to help obtain them. We study how this broker market responds when the government makes it easier to apply directly. A staffing reform in a large Indian state added workers who help submit applications, while leaving approving officials unchanged. Using pre-existing differences in district exposure to the reform, we find that a 1 percent staffing increase raises broker-mediated applications by 1.7 percent, compared to 1.1 percent for direct applications, and induces broker entry. Yet direct applications become faster, reducing brokers’ average speed advantage. These patterns rule out a model where public workers purely substitute for brokers and, under maintained assumptions, one where brokers only obtain priority from approvers. A model where public workers make brokers more productive can explain joint results. Our findings highlight the role of informal markets in building state capacity.</p>
  </div>
</div>

<h2 class="rd-subhead">Work in progress</h2>

<ul class="rd-paperlist">
  <li>
    <h3 class="rd-paper-title">Highways and Innovation in India</h3>
    <p class="rd-coauthors"><span class="rd-reslinks__state">With Ishani Chatterjee</span></p>
    <p class="rd-finding"></p>

    <ul class="rd-reslinks">
      <li>
        <button class="rd-abs-toggle" type="button" aria-expanded="false" aria-controls="abs-2"
                data-label-open="Hide abstract" data-label-closed="Abstract">
          <span class="rd-abs-toggle__label">Abstract</span>
        </button>
      </li>
    </ul>

    <div class="rd-abs-body" id="abs-2" hidden>
      <p>In this project, we document higher district-level patenting activity with increasing access to road transport networks in India. We explore mechanisms behind this and observe the growth of higher educational institutions, as well as increasing firm size measured by authorized capital, in response to increasing highway exposure at the district level. Newer and smaller firms are seen to come up in districts that are farther away, which suggests spatial spillovers into districts farther away from national highway networks.</p>
    </div>
  </li>
</ul>

{% comment %}
==================================================================
HOW TO ADD ANOTHER PAPER

Copy the block between the dashed lines, paste it INSIDE
<ul class="rd-paperlist"> above (just before its closing </ul>),
then fill in the CAPITALISED parts.

>>> THE ONE THING THAT WILL BREAK IT <<<
Each abstract needs its OWN id. The two places reading "abs-N"
must both be changed to the next unused number - abs-3, then
abs-4, and so on. If two papers share an id, clicking one
opens the other's abstract.

Don't want an abstract on a paper? Delete the <li> holding the
button AND the <div class="rd-abs-body"> block.
------------------------------------------------------------------

  <li>
    <h3 class="rd-paper-title">PAPER TITLE</h3>
    <p class="rd-coauthors"><span class="rd-reslinks__state">With CO-AUTHOR &#183; STATUS</span></p>
    <p class="rd-finding">One plain sentence saying what you find.</p>

    <ul class="rd-reslinks">
      <li>
        <button class="rd-abs-toggle" type="button" aria-expanded="false" aria-controls="abs-N"
                data-label-open="Hide abstract" data-label-closed="Abstract">
          <span class="rd-abs-toggle__label">Abstract</span>
        </button>
      </li>
      <li><span class="rd-reslinks__state">Draft available on request</span></li>
    </ul>

    <div class="rd-abs-body" id="abs-N" hidden>
      <p>ABSTRACT TEXT.</p>
    </div>
  </li>

------------------------------------------------------------------
TO ADD A WHOLE NEW SECTION (e.g. "Publications" or "Policy work"),
paste this at the bottom of the page and put entries inside it:

  <h2 class="rd-subhead">SECTION NAME</h2>

  <ul class="rd-paperlist">
    ... one or more <li> blocks like the one above ...
  </ul>

Sections appear in the order they sit in this file.
==================================================================
{% endcomment %}
