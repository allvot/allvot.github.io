---
icon: fas fa-tools
order: 2
layout: page
title: Skills
permalink: /skills/
toc: true
---

{% assign cv = site.data.cv %}

{% for group in cv.skills %}
## {{ group.category }}
{: #{{ group.category | slugify }} }

<div class="row g-3">
  {% for item in group.items %}
    <div class="col-12 col-lg-6">
      <section class="post-preview position-relative overflow-hidden rounded h-100">
        <div class="position-relative z-1 p-3">
          <header class="d-flex align-items-start justify-content-between gap-2">
            <div class="flex-grow-1">
              <h3 class="h6 mb-1">
                {% if item.icon_class %}
                  <i class="{{ item.icon_class }} fa-fw me-2 text-muted"></i>
                {% endif %}
                {{ item.name }}
                {% if item.years %}
                <span class="post-tag">{{ item.years }}+ yrs</span>
                {% endif %}
              </h3>

              {% if item.description %}
                <p class="mb-0 text-muted">{{ item.description }}</p>
              {% endif %}
            </div>
          </header>

          {% if item.details %}
            <div class="mt-3">
              <div class="text-muted small mb-2"><strong>Focus</strong></div>
              <div class="post-tags d-flex flex-wrap gap-2">
                {% assign parts = item.details | split: "," %}
                {% for p in parts %}
                  <span class="post-tag">{{ p | strip }}</span>
                {% endfor %}
              </div>
            </div>
          {% endif %}
        </div>
      </section>
    </div>
  {% endfor %}
</div>

---
{% endfor %}


