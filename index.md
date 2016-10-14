---
layout: default
title: Jekyll Geocode
---

## Example of map generated with Jekyll-Geocode and Jekyll-Map

### Take a Yaml

```yaml

- name: "Bertrand Keller"
  street: "place du vieux marché"
  postcode: "76000"
  city: "Rouen"
  region: "normandie"
  country: "france" 
- name: "John Doe"
  street: "rue Mendès France"
  postcode: "76190"
  city: "Yvetot" 
  region: "normandie"
  country: "france"  
- name: "Samuel Le Bihan"
  street: "rue de rivoli" 
  postcode: "75000"
  city: "Paris"
  region: "Ile de France"
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
  - jekyll-maps

exclude:
    - _data/places.yml
```

**Index.html**

```
{% raw %}{% google_map data_set:01 width:100% id:places %}{% endraw %}
```

### It will generate another Yaml which can be called by Jekyll Map

{% google_map data_set:01 width:100% id:places %}

For more information : <a href="https://github.com/bertrandkeller/jekyll-geocode">Visit the repository for more information</a>
