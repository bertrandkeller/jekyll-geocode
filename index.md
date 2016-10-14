---
layout: default
title: Jekyll Geocode
---

## Example of map generated with Jekyll Geocode and Jekyll Map

### Take a Yaml

```yaml

- name: "Bertrand Keller"
  street: "place du vieux marché"
  postcode: "76000"
  city: "Rouen"
  region: "normandy"
  country: "france" 
- name: "John Doe"
  street: "rue Mendès France"
  postcode: "76190"
  city: "Yvetot" 
  region: "normandy"
  country: "france"  
- name: "Samuel Le Bihan"
  street: "Place Niemeyer" 
  city: "Le Havre"
  postcode: "76600"
  region: "normandy"
  country: "france"
```

### Configurate Jekyll

**_config.yml**

```yaml
jekyll_geocode:
  file-name: members.yml
  file-path: _data
  name: name
  address: street
  ville: city
  region: region
  postcode: postalcode
  outputfile: places.yml

gems:
  - jekyll-geocode
  - jekyll-maps

exclude:
    - _data/places.yml # Maybe stop watching this file
```

**Index.html**

```
{% raw %}{% google_map data_set:01 width:100% id:places %}{% endraw %}
```

### It will generate another Yaml which can be called by Jekyll Map

{% google_map data_set:01 width:100% id:places %}

Discover Jekyll Map : <a href="https://github.com/ayastreb/jekyll-maps">Jekyll Map Github repositery</a>

For more information : <a href="https://github.com/bertrandkeller/jekyll-geocode">Visit the repository for more information</a>
