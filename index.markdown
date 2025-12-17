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

{% assign contact_email = cv.contact.email %}
{% assign contact_phone = cv.contact.phone %}
{% assign contact_phone_href = contact_phone | replace: ' ', '' | replace: '(', '' | replace: ')', '' | replace: '-', '' %}

> **Let’s talk**
>
> - Email: [{{ contact_email }}](mailto:{{ contact_email }})
> - Phone: [{{ contact_phone }}](tel:{{ contact_phone_href }})
{: .prompt-info }

## Current role

**{{ current.title }}** @ {{ current.company }}
{{ current.start }} – {{ current.end }}

More details: [Experience]({{ '/experience/' | relative_url }})

## Explore

- [Skills]({{ '/skills/' | relative_url }})
- [Experience]({{ '/experience/' | relative_url }})
- [Education]({{ '/education/' | relative_url }})
