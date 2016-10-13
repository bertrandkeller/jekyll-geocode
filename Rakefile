require "rubygems"
require "tmpdir"
require "bundler/setup"
require "jekyll"

# Indiquez le nom de votre dépôt
GITHUB_REPONAME = "bertrandkeller/jekyll-geocode"

namespace :site do
  desc "Génération des fichiers du site"
  task :generate do
    Jekyll::Site.new(Jekyll.configuration({
      "source"      => ".",
      "destination" => "_site"
    })).process
  end

  desc "Génération et publication des fichiers sur GitHub"
  task :publish => [:generate] do
    Dir.mktmpdir do |tmp|
      cp_r "_site/.", tmp
      
      pwd = Dir.pwd
      Dir.chdir tmp
      File.open(".nojekyll", "wb") { |f| f.puts("Site généré localement.") }
      
      system "git init"
      system "git add ."
      message = "Site mis à jour le #{Time.now.utc}"
      system "git commit -m #{message.inspect}"
      system "git remote add origin git@github.com:#{GITHUB_REPONAME}.git"
      p "git remote add origin git@github.com:#{GITHUB_REPONAME}.git"
      system "git push origin master:refs/heads/gh-pages --force"

      Dir.chdir pwd
    end
  end
end

0
