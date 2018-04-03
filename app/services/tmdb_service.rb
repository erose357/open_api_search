class TmdbService
  attr_reader :title

  def initialize(title)
    @title = title
    @conn = Faraday.new('https://api.themoviedb.org/3/')
  end

  def movie_list
    movie_instances(parse_json(movies_request)[:results]) 
  end

  private
    def movies_request
      @conn.get("search/movie?api_key=#{ENV['tmdb_key']}&page=1&query=#{@title}")
    end

    def parse_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def movie_instances(raw_movies)
      raw_movies.map { |raw_movie| Movie.new(raw_movie) }
    end
end
