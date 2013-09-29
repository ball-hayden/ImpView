require 'csv'
require 'json'

module GamesBuilder
  class << self
    def registered(app)

      app.after_build do |builder|
        emotions = File.read(File.join(root, "games.txt"))
        emotions = emotions.split(/\n/)

        # Titleize
        emotions = emotions.map { |s| s.titleize }

        # Remove duplicates and sort.
        emotions = emotions.uniq.sort

        File.open(File.join(build_dir, "content/games.json"),"w") do |f|
          f.write(emotions.to_json)
        end

        builder.say_status :create, "build/content/games.json"
      end

    end
    alias :included :registered
  end
end

::Middleman::Extensions.register(:games_builder, GamesBuilder)