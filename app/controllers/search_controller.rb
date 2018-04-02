class SearchController < ApplicationController
  def index
    search_name = params[:name] || params[:format]
    @searches = order_previous_searches({order: params[:order]})
    @characters = MarvelService.new(search_name).characters_list
    if params[:order].nil?
      Search.update_or_create(search_name)
    end
  end
end
