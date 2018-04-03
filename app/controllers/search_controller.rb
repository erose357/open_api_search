class SearchController < ApplicationController
  def index
    search_name = params[:title] || params[:format]
    @searches = order_previous_searches(params[:order])
    @movies = TmdbService.new(search_name).movie_list
    if params[:order].nil?
      Search.update_or_create(search_name)
    end
  end
end
