require "rubygems"
require 'json'
require 'open-uri'

module Jekyll_Get
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      #Get Config
      config = site.config['jekyll_geocode']
      geo_service = 'https://nominatim.openstreetmap.org/?format=json&q='

      if !config
        return
      end
      if !config.kind_of?(Array)
        filename       = site.config['jekyll_geocode']['file-name']
        filepath       = site.config['jekyll_geocode']['file-path']
        geo_name       = site.config['jekyll_geocode']['name']
        geo_address    = site.config['jekyll_geocode']['address']
        geo_town       = site.config['jekyll_geocode']['town']
        geo_region     = site.config['jekyll_geocode']['region']
      end

      if !filepath
        data_source = (site.config['data_source'])
      else
        data_source = (filepath)
      end

      #File.file?(filename)

      # Load YML file
      members = YAML.load_file("#{data_source}/#{filename}")
      members.each do |d|
        if !File.file?("#{data_source}/#{d[geo_name]}.json")
          if d[geo_town]
            geo_town_field = ",#{d[geo_town]}"
          end
          if d[geo_region]
            geo_region_field = ",#{d[geo_region]}"
          end
          json = URI.encode("#{geo_service}#{d[geo_address]}#{geo_town_field}#{geo_region_field}&limit=1")
          source = JSON.load(open(json))
          site.data[d[geo_name]] = source
          if site.config['jekyll_geocode']['cache']
            path = "#{data_source}/#{d[geo_name]}.json"
            open(path, 'wb') do |file|
              file << JSON.generate(site.data[d['nom_entier']])
            end
          end
        end
      end
    end
  end
end
