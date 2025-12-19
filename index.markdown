---
layout: page
title: Home
permalink: /
description: "Alvaro Alday — Senior Backend Engineer specializing in AI automation: RPA with AI, chatbots, AI-enhanced web scraping, and custom AI solutions."
image: /assets/img/alvaro_alday.jpeg
---

{% assign cv = site.data.cv %}

## {{ cv.name }}

**{{ cv.tagline }}**

<span class="text-muted">
  <i class="fas fa-map-marker-alt fa-fw"></i>
  {{ cv.location.city }}, {{ cv.location.region }}, {{ cv.location.country }}
</span>

{{ cv.introduction }}

{% assign contact_email = cv.contact.email %}
{% assign contact_phone = cv.contact.phone %}
{% assign contact_linkedin = cv.contact.linkedin %}
{% assign contact_github = cv.contact.github %}
{% assign contact_phone_href = contact_phone | replace: ' ', '' | replace: '(', '' | replace: ')', '' | replace: '-', '' %}

> **Let’s talk**
>
> - <i class="fas fa-envelope fa-fw"></i> [{{ contact_email }}](mailto:{{ contact_email }})
> - <i class="fas fa-phone fa-fw"></i> [{{ contact_phone }}](tel:{{ contact_phone_href }})
> - <i class="fab fa-linkedin fa-fw"></i> [LinkedIn]({{ contact_linkedin }})
> - <i class="fab fa-github fa-fw"></i> [GitHub]({{ contact_github }})
{: .prompt-info }

## Services
{% include home/services-preview.html %}

## Explore
{% include home/explore.html %}
