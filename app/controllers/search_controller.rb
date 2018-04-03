class SearchController < ApplicationController
  def index
    search_name = params[:title] || params[:format]
    @searches = order_previous_searches(params[:order])
    @movies = TmdbService.new(search_name).movie_list
    @search = Search.find_by(search_term: search_name)
    if params[:order].nil?
      Search.update_or_create(search_name)
    end
  end
end
