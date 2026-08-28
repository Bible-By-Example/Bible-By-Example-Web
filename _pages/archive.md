---
title: Archive
description: "Past articles and episodes."
---

## Recent Articles

<div class="entries-list">
  {% for post in site.posts limit: 5 %}
    {% include archive-single.html %}
  {% endfor %}
</div>

[Full Article Archive]({% link _pages/history.md %})

## Episodes

{% include episode_zero.html %}

{% assign series = site.data.series | sort: "order" %}

<div class="series-list">
  {% for item in series %}
    <h3>
      <a href="/series/{{ item.slug }}/">
        {{ item.name }} ({{ item.abbreviation }})
      </a>
    </h3>
  {% endfor %}
</div>
