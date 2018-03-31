class SearchController < ApplicationController

  def index
    @characters = MarvelService.new(params[:name]).characters_list
  end
end
