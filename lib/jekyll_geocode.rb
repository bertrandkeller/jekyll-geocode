require "rubygems"
require 'json'
require 'yaml'
require 'open-uri'
require "i18n"

module Jekyll_Geocode
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def request_service(url)
      JSON.load(open(URI.encode(url)))
    end

    def generate(site)

      #regEx for removing empty line
      regEx = /^[\s]*$\n/

      #force locale
      I18n.config.available_locales = :en

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

      #Path
      path_yaml = "#{data_source}/#{outputfile}"

      # if File.file?(path_yaml) && outputfile
      #   File.open(path_yaml, 'w') {|file| file.truncate(0) }
      # end

      # Load YML file
      members = YAML.load_file("#{data_source}/#{filename}")

      # Loop YML file
      members.each do |d|
        # Test if a JSON file exists for performance issues
        if !File.file?("#{data_source}/#{d[geo_name]}.json")
          geo_name_field = d[geo_name].downcase.tr(" ", "-")
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
          source = JSON.load(open(json))

          # Loop for an YML output
          if outputfile
            source.each do |coordinates|
              data = [ "title" => "#{d[geo_name]}", "url" => "##{d[geo_name]}", "data_set" => "01", "location" => { "latitude" => "#{coordinates["lat"]}","longitude" => "#{coordinates["lon"]}" } ]
              data_yml = data.to_yaml
              # Test if there is any yaml files and create file
              if !File.file?(path_yaml)
                File.open(path_yaml, "w") {|f| f.write(data_yml) }
              end
              # Test if there is yaml files and add data recursively
              if File.file?(path_yaml)
                File.open(path_yaml, 'a') { |f|
                  data_yml_simple = data_yml.gsub("---", "").gsub(regEx, '')
                  f.puts data_yml_simple
                }
                # Load YML file and remove duplicate entries
                file_yaml = YAML.load(File.open(path_yaml))
                file_yaml_uniq = file_yaml.uniq { |s| s.first }
                File.open(path_yaml, "w") {|f| f.write(file_yaml_uniq.to_yaml) }
              end
            end
          # Loop for an JSON output
          else
            site.data[geo_name_field] = source
            #Create a JSON  files if cache is enabled
            if site.config['jekyll_geocode']['cache']
              path_json = "#{data_source}/#{geo_name_field}.json"
              open(path_json, 'wb') do |file|
                file << JSON.generate(site.data[geo_name_field])
              end
            end
          end
        end
      end
    end
  end
end
