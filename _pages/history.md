---
title : Article History
description: "Full list of previous posts."
toc: true
toc_label: "Post History"
toc_icon: "fa-regular fa-calendar-days"
toc_sticky: true
---

<div id="archives">

  {% assign current_year = "" %}
  {% assign current_month = "" %}

  {% for post in site.posts %}

    {% assign post_year = post.date | date: "%Y" %}
    {% assign post_month = post.date | date: "%B" %}

    {% if post_year != current_year %}
      {% unless forloop.first %}
        </div>
      {% endunless %}

      <h2 id="{{ post_year }}">{{ post_year }}</h2>
      <div class="entries-list">

      {% assign current_year = post_year %}
      {% assign current_month = "" %}
    {% endif %}

    {% if post_month != current_month %}
      <h3>{{ post_month }}</h3>
      {% assign current_month = post_month %}
    {% endif %}

    {% include archive-single.html %}

  {% endfor %}

  </div>
</div>
