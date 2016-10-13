---
---
<html lang="fr">
<head>
<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="{{ "main.css" | prepend: site.baseurl }}">
  <link rel="dns-prefetch" href="//fonts.googleapis.com/" data-proofer-ignore>
  <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Lato:300,300italic,400,400italic,700,700italic,900">
  <link rel="canonical" href="{{ page.url | replace:'index.html','' | prepend: site.baseurl | prepend: site.url }}">
  <link rel="alternate" type="application/atom+xml" title="{{ site.title }}" href="{{ "/feed.xml" | prepend: site.baseurl | prepend: site.url }}">
  {% seo %}  
</head>
<header>
  <h1>Jekyll Geocode</h1>
  <p>Encode addresses from an YAML file and export them to a JSON or another a YAML for drawing maps</p>
</header>
<main>
  <h2>Example of map generated with Jekyll-Geocode and Jekyll-Map</h2>
  {% google_map data_set:01 width:100% id:places %}
  <a href="https://github.com/bertrandkeller/jekyll-geocode">Visit the repository for more information</a>
</main>
</html>