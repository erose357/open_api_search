class SearchController < ApplicationController
  def index
    search_name = params[:name] || params[:format]
    @searches = Search.all
    @characters = MarvelService.new(search_name).characters_list
    Search.update_or_create(search_name)
  end
end
