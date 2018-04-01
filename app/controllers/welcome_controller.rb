class WelcomeController < ApplicationController
  def index
    @searches = Search.all
  end
end
