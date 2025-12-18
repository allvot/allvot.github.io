---
layout: page
title: Home
permalink: /
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

{% include home/services-preview.html %}

## Explore

- <i class="fas fa-bolt fa-fw"></i> [Skills]({{ '/skills/' | relative_url }})
- <i class="fas fa-briefcase fa-fw"></i> [Experience]({{ '/experience/' | relative_url }})
- <i class="fas fa-graduation-cap fa-fw"></i> [Education]({{ '/education/' | relative_url }})
- <i class="fas fa-handshake fa-fw"></i> [Services]({{ '/services/' | relative_url }})

---

