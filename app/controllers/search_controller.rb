class SearchController < ApplicationController
  def index
    search_name = params[:title] || params[:format]
    @searches = Search.all
    @movies = TmdbService.new(search_name).movie_list
    Search.update_or_create(search_name)
  end
end
