class SearchController < ApplicationController
  def index
    @searches = Search.all
    @characters = MarvelService.new(params[:name] || params[:format]).characters_list
  end
end
