---
icon: fas fa-briefcase
order: 3
layout: page
title: Experience
permalink: /experience/
---

{% assign cv = site.data.cv %}

{% for role in cv.experience %}
### {{ role.title }} — {{ role.company }}

**{{ role.start }} – {{ role.end }}** · {{ role.location }}

{% if role.highlights and role.highlights.size > 0 %}
#### Highlights

{% for bullet in role.highlights %}
- {{ bullet }}
{% endfor %}
{% endif %}

{% if role.tech and role.tech.size > 0 %}
#### Tech

{% assign tech_names = "" %}
{% for t in role.tech %}
  {% assign tech_name = t.name | default: t %}
  {% if forloop.first %}
    {% assign tech_names = tech_name %}
  {% else %}
    {% assign tech_names = tech_names | append: " · " | append: tech_name %}
  {% endif %}
{% endfor %}

{{ tech_names }}
{: .text-muted }
{% endif %}

---

{% endfor %}


