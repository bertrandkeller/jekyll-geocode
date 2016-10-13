# Jekyll Geocode

Making a interactive maps with adresses is impossible you need the coordinates.  
Making a file writing by redactors with directly the coordinates of your data is impossible or too slow.

So you need a processus for generating coordinates form addresses by calling a service. 

For speed reasons you‘d rather writing the coordinates in files during the build. You will probably generate a JSON file with coordinates in your HTML page displaying map.

I took the [Nominatim](https://nominatim.openstreetmap.org/) open source service from Open Street Map for calling the data. 

## Example of YAML : _data/members.yml

```yaml
- name: "John Doe"
  address: "rue Mendès France"
  postcode: 76190
  city: "Yvetot"
  region: "normandy"
  country: "france"  
- name: "Samuel Le Bihan"
  address: "place du général de Gaulle France"
  postcode: 76000
  city: "Rouen"
  region: "Normandy"
  country: "france"
```

> For key matching, avoid accent in name or create a key in members.yml (ex: geoname) without space and accent.

## Example of configuration _config.yml

```yaml
jekyll_geocode:
  file-name: members.yml # Name of the YML store inside _data with a list of datas (required)
  file-path: _data # Path of the YML file, folder of your data (_data) by default (optional)
  name: name # Name of the field from the YML that will gave the name of the generated file (the name will be downcase and space replace by a dash) (required)
  address: address # Name of the address (street + city) or only street field (if city field exists) from the YML (required)
  postcode: postcode # Postcode from the YML (optional)
  city: city # Name of the town field from the YML, if you have a separated field address and city (optional)
  region: region # Name of the region, county or state or all in the same field from the YML (optional)
  country: country # Name of the country from the YML (optional)
  cache: true # Test if a file already exist
  outputfile: place.yml # Give the name of the file for an yml output (otherwise it will be JSON) <= usefull for jekyll-map
```
> The service is very slow (when you have lot of entries) but you can generate files with the cache option. Be carefull, ignore this files in your git tracking files !

## Example of loop with JSON : map.html with google map

```liquid
{% for row in site.data.members | sort: 'name' %}
    {% assign geoname = row.name | replace: ' ', '-' | downcase %}
    var point = new google.maps.LatLng({% for coordinates in site.data.[geoname] %}{{ coordinates.lat }}, {{ coordinates.lon }}{% endfor %});
{% endfor %}
```

## Example of loop with YAML : map.html with google map
```liquid
{% for row in site.data.members | sort: 'name' %} 
    {% assign geoname = row.name | replace: ' ', '-' | downcase %}    
    {% assign places = site.data.place | where:"title", geoname %} 
    {% for coordinates in places %}
      var point = new google.maps.LatLng({{ coordinates.location.latitude }}, {{ coordinates.location.longitude }});
    {% endfor %}
{% endfor %}
```

This plugin is used in a production website and working well. You are invited for improvement proposals.