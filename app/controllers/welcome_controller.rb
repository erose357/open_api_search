class WelcomeController < ApplicationController
  def index
    @searches = order_previous_searches(params[:order])
  end
end
