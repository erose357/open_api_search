class WelcomeController < ApplicationController
  def index
    @searches = order_previous_searches({order: params[:order]})
  end
end
