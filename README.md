# Jekyll Geocode

Making a interactive maps with adresses is impossible you need the coordinates.  
Making a file writing by redactors with directly the coordinates of your data is impossible or too slow.

So you need a processus for generating coordinates form addresses by calling a service. 

For speed reasons you‘d rather writing the coordinates in files during the build. You will probably generate a JSON file with coordinates in your HTML page displaying map.

I took the [Nominatim](https://nominatim.openstreetmap.org/) open source service from Open Street Map for calling the data. 

The service is very slow (when you have lot of entries) but you can generate files with the cache option. Be carefull, ignore this files in your git tracking files !

Example of configuration in the _config.yml

```yaml
jekyll_geocode:
  file-name: members.yml # Name of the YML store inside _data with a list of data
  file-path: _data # Path of the YML file, folder of your data (_data) by default (optional)
  name: name # Name of the field  in the YML that will gave the name of the generated file (called in a loop by site.data.[name_of_field])
  address: adresse # Name of the address field in the YML
  town: town # Name of the town field in the YML, if you have a separeted field address and town (optional)
  region: region # Name of the region or country or the both field in the YML (optional)
  cache: true # Test if a file already exist
```

This plugin is used in a production website. You are invited for improvement proposals.