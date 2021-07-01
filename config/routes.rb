Rails.application.routes.draw do
  resources :preco_rota
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Dates
  get 'get_query_dates', to: 'application#get_dates'
  get 'get_query_body', to: 'application#get_body'

end
