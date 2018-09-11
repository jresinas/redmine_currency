resources :currencies
resources :currency_exchange_rates, only: [:index]

match "currency_exchange_rates/create_year", :to => "currency_exchange_rates#create_year", :via => [:post]
match "currency_exchange_rates/edit_year/:year", :to => "currency_exchange_rates#edit_year", :via => [:get], :as => 'currency_exchange_rates_edit_year'
match "currency_exchange_rates/update_year/:year", :to => "currency_exchange_rates#update_year", :via => [:put], :as => 'currency_exchange_rates_update_year'
match "currency_exchange_rates/destroy_year/:year", :to => "currency_exchange_rates#destroy_year", :via => [:delete]