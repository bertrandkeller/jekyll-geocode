require "rubygems"
require 'json'
require 'yaml'
require 'open-uri'

module Jekyll_Get
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)

      #regEx for removing empty line
      regEx = /^[\s]*$\n/

      #Get Geo service
      geo_service = 'https://nominatim.openstreetmap.org/?format=json&q='

      #Get Config
      config = site.config['jekyll_geocode']

      if !config
        return
      end
      if !config.kind_of?(Array)
        filename       = site.config['jekyll_geocode']['file-name']
        filepath       = site.config['jekyll_geocode']['file-path']
        outputfile     = site.config['jekyll_geocode']['outputfile']
        geo_name       = site.config['jekyll_geocode']['name']
        geo_address    = site.config['jekyll_geocode']['address']
        geo_postcode   = site.config['jekyll_geocode']['postcode']
        geo_city       = site.config['jekyll_geocode']['city']
        geo_region     = site.config['jekyll_geocode']['region']
        geo_country    = site.config['jekyll_geocode']['country']
      end

      # Define data source
      if !filepath
        data_source = (site.config['data_source'])
      else
        data_source = (filepath)
      end

      if File.file?("_data/place.yml")
        File.open("_data/place.yml", 'w') {|file| file.truncate(0) }
      end

      # Load YML file
      members = YAML.load_file("#{data_source}/#{filename}")

      # Loop YML file
      members.each do |d|
        # Test if a JSON file exists for performance issues
        if !File.file?("#{data_source}/#{d[geo_name]}.json")
          if d[geo_postcode]
            geo_postcode_field = ",#{d[geo_postcode]}"
          end
          if d[geo_city]
            geo_city_field = ",#{d[geo_city]}"
          end
          if d[geo_region]
            geo_region_field = ",#{d[geo_region]}"
          end
          if d[geo_country]
            geo_country_field = ",#{d[geo_country]}"
          end
          json = URI.encode("#{geo_service}#{d[geo_address]}#{geo_postcode_field}#{geo_city_field}#{geo_region_field}#{geo_country_field}&limit=1")
          geo_name_field = d[geo_name].downcase.tr(" ", "-")
          source = JSON.load(open(json))
          if outputfile
            source.each do |coordinates|
              data = [ "title" => "#{d[geo_name]}", "location" => { "latitude" => "#{coordinates["lat"]}","longitude" => "#{coordinates["lon"]}" } ]
              data_yml = data.to_yaml.gsub("---", "").gsub(regEx, '')
              # Test if there is any yaml files and create file
              if !File.file?("_data/place.yml")
                File.open("_data/place.yml", "w") {|f| f.write(data_yml) }
              end
              # Test if there is yaml files and add data recursively
              if File.file?("_data/place.yml")
                File.open('_data/place.yml', 'a') { |f|
                f.puts data_yml
              }
              end
            end
          else
            site.data[geo_name_field] = source
            #Create a JSON  file if cache is enabled
            if site.config['jekyll_geocode']['cache']
              path = "#{data_source}/#{geo_name_field}.json"
              open(path, 'wb') do |file|
                file << JSON.generate(site.data[geo_name_field])
              end
            end
          end
        end
      end
    end
  end
end
