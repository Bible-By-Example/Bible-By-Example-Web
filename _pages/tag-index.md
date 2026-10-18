---
title: Tag Index
description: "A list of all tags used in AnonJr.com"
permalink: /tag/
share: false
toc: true
toc_label: "Tags"
toc_icon: "fa-solid fa-tag"
toc_sticky: true
---

{{ page.description }}

{% capture raw_tags %}{% for tag in site.tags %}{{ tag[0] | downcase }}#{{ tag[0] }}{% unless forloop.last %}|{% endunless %}{% endfor %}{% endcapture %}
{% assign sorted_tags = raw_tags | split: '|' | sort %}

{% assign current_letter = "" %}

{% for entry in sorted_tags %}
  {% assign tag_pair = entry | split: '#' %}
  {% assign tag_name = tag_pair[1] %}
  {% assign tag_slug = tag_name | slugify %}
  {% assign post_count = site.tags[tag_name].size %}
  {% assign first_letter = tag_name | slice: 0, 1 | upcase %}

  {% if first_letter != current_letter %}
    {% assign current_letter = first_letter %}

## {{ current_letter }}

  {% endif %}
* [{{ tag_name }}]({{ '/tag/' | append: tag_slug | append: '/' | relative_url }}) ({{ post_count }} {% if post_count == 1 %}post{% else %}posts{% endif %})
{% endfor %}
