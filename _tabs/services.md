---
icon: fas fa-handshake
order: 4
layout: page
title: Services
permalink: /services/
toc: true
---

{% assign services = site.data.services %}

## {{ services.subtitle }}

{{ services.description | markdownify }}

---

{% if services.ai_engines and services.ai_engines.size > 0 %}
### AI Engines

<div class="post-tags d-flex flex-wrap gap-2">
  {% for engine in services.ai_engines %}
    <span class="post-tag">
      <i class="{{ engine.icon }} fa-fw me-1"></i>
      {{ engine.name }}
    </span>
  {% endfor %}
</div>

### Programming Languages
<div class="post-tags d-flex flex-wrap gap-2">
  {% for language in services.programming_languages %}
    <span class="post-tag">
      <i class="{{ language.icon }} fa-fw me-1"></i>
      {{ language.name }}
    </span>
  {% endfor %}
</div>

### Frameworks

<div class="post-tags d-flex flex-wrap gap-2">
  {% for framework in services.frameworks %}
    <span class="post-tag">
      <i class="{{ framework.icon }} fa-fw me-1"></i>
      {{ framework.name }}
    </span>
  {% endfor %}
</div>

---
{% endif %}

### Tailored Solutions

<div class="row g-3">
{% for service in services.items %}
  <div class="col-12 col-lg-6">
    <section class="post-preview position-relative overflow-hidden rounded h-100">
      <div class="position-relative z-1 p-3">
        <header class="d-flex align-items-start justify-content-between gap-2">
          <div class="flex-grow-1">
            <h3 class="h6 mb-1">
              <i class="{{ service.icon }} fa-fw me-2 text-muted"></i>
              {{ service.name }}
            </h3>
            <div class="text-muted mb-0">
              {{ service.description | markdownify }}
            </div>
          </div>
        </header>
      </div>
    </section>
  </div>
{% endfor %}
</div>


