---
icon: fas fa-briefcase
order: 3
layout: page
title: Experience
permalink: /experience/
---

{% assign cv = site.data.cv %}

{% for role in cv.experience %}
<section class="post-preview position-relative overflow-hidden rounded mb-4">
  <div class="position-relative z-1 p-3 p-md-4">
    <header class="d-flex flex-column flex-md-row justify-content-between align-items-start gap-2">
      <div>
        <h3 class="h4 mb-1">{{ role.title }}</h3>
        <div class="text-muted">{{ role.company }}</div>
      </div>

      <div class="text-muted small">
        <div>
          <i class="far fa-calendar-alt me-1"></i>
          <span>{{ role.start }} – {{ role.end }}</span>
        </div>
        <div>
          <i class="fas fa-location-dot me-1"></i>
          <span>{{ role.location }}</span>
        </div>
      </div>
    </header>

    {% if role.highlights and role.highlights.size > 0 %}
    <div class="mt-3">
      <div class="text-muted mb-2"><strong>Highlights</strong></div>
      <ul class="mb-0">
        {% for bullet in role.highlights %}
          <li>{{ bullet }}</li>
        {% endfor %}
      </ul>
    </div>
    {% endif %}

    {% if role.tech and role.tech.size > 0 %}
    <div class="mt-3">
      <div class="text-muted mb-2"><strong>Tech</strong></div>
      <div class="post-tags d-flex flex-wrap gap-2">
        {% for t in role.tech %}
          {% assign tech_name = t.name | default: t %}
          {% assign tech_icon = t.icon_class %}
          <span class="post-tag">
            {% if tech_icon %}
              <i class="{{ tech_icon }} me-1"></i>
            {% endif %}
            {{ tech_name }}
          </span>
        {% endfor %}
      </div>
    </div>
    {% endif %}
  </div>
</section>

{% endfor %}


