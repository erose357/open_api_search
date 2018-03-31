Rails.application.routes.draw do
  get '/search', to: 'search#index'
  root 'welcome#index'
end
