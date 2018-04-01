class SearchController < ApplicationController
  def index
    @searches = Search.all
    @characters = MarvelService.new(params[:name]).characters_list
  end
end
