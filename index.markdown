---
layout: page
title: Home
permalink: /
---

{% assign cv = site.data.cv %}

## {{ cv.name }}

**{{ cv.tagline }}** · {{ cv.location.city }}, {{ cv.location.region }}, {{ cv.location.country }}

{{ cv.introduction }}

{% assign current = cv.experience[0] %}

<div class="row g-3 my-4">
  <div class="col-12 col-lg-6">
    <a class="post-preview position-relative overflow-hidden d-block rounded text-decoration-none" href="{{ '/experience/' | relative_url }}">
      <div class="position-relative z-1 p-3">
        <h3 class="h5 mb-2">Current role</h3>
        <p class="mb-1"><strong>{{ current.title }}</strong> @ {{ current.company }}</p>
        <p class="mb-0 text-muted">{{ current.start }} – {{ current.end }}</p>
      </div>
    </a>
  </div>

  <div class="col-12 col-lg-6">
    <a class="post-preview position-relative overflow-hidden d-block rounded text-decoration-none" href="{{ '/about/' | relative_url }}">
      <div class="position-relative z-1 p-3">
        <h3 class="h5 mb-2">Contact</h3>
        <p class="mb-1"><strong>Email:</strong> <span>{{ cv.contact.email }}</span></p>
        <p class="mb-0"><strong>Phone:</strong> <span>{{ cv.contact.phone }}</span></p>
        <p class="mb-0 mt-2"><span class="text-muted">Open About for mailto links and details.</span></p>
      </div>
    </a>
  </div>
</div>

<div class="row g-3">
  <div class="col-12 col-md-6 col-xl-3">
    <a class="post-preview position-relative overflow-hidden d-block rounded text-decoration-none h-100" href="{{ '/about/' | relative_url }}">
      <div class="position-relative z-1 p-3">
        <h3 class="h5 mb-2">About</h3>
        <p class="mb-0 text-muted">Background, location, and contact links.</p>
      </div>
    </a>
  </div>

  <div class="col-12 col-md-6 col-xl-3">
    <a class="post-preview position-relative overflow-hidden d-block rounded text-decoration-none h-100" href="{{ '/skills/' | relative_url }}">
      <div class="position-relative z-1 p-3">
        <h3 class="h5 mb-2">Skills</h3>
        <p class="mb-0 text-muted">Core strengths across backend, cloud, and testing.</p>
      </div>
    </a>
  </div>

  <div class="col-12 col-md-6 col-xl-3">
    <a class="post-preview position-relative overflow-hidden d-block rounded text-decoration-none h-100" href="{{ '/experience/' | relative_url }}">
      <div class="position-relative z-1 p-3">
        <h3 class="h5 mb-2">Experience</h3>
        <p class="mb-0 text-muted">Recent roles, impact, and tech stacks.</p>
      </div>
    </a>
  </div>

  <div class="col-12 col-md-6 col-xl-3">
    <a class="post-preview position-relative overflow-hidden d-block rounded text-decoration-none h-100" href="{{ '/education/' | relative_url }}">
      <div class="position-relative z-1 p-3">
        <h3 class="h5 mb-2">Education</h3>
        <p class="mb-0 text-muted">Degrees and academic focus.</p>
      </div>
    </a>
  </div>
</div>
