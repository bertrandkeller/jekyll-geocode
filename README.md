# Jekyll Geocode

```yaml
jekyll_geocode:
  file-name: members.yml # Name of the YML store inside _data
  file-path: _data # Path of the YML file, folder of your data by default (optional)
  name: nom_entier # Name of the file wich will generated (in memory or with json extension) which be called by site.data.[name_for_field]
  address: adresse-geo # Name of the address field in the YML
  town: ville # Name of the town field in the YML, if you have a seperated field address and town (optional)
  region: region # Insert the name of a region, a country or both separated by a comma(optional)
  cache: true # Test idf a file already exist
```