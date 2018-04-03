class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def order_previous_searches(order = nil)
    case order
    when 'date'
      Search.all.order(updated_at: :desc)
    when 'count'
      Search.all.order(search_count: :desc)
    when 'search'
      Search.all.order(search_term: :asc)
    else
      Search.all
    end
  end
end
