---
title: Series List
description: "A list of all series published by Bible By Example."
permalink: /series/
share: false
---

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
