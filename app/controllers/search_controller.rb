class SearchController < ApplicationController
  def index
    search_name = params[:title] || params[:format]

    if params[:order].nil?
      Search.update_or_create(search_name)
    end

    @searches = order_previous_searches(params[:order])
    @movies = TmdbService.new(search_name).movie_list
    @search = @searches.find { |search| search.search_term == search_name }
  end
end
