Rails.application.routes.draw do
  devise_for :admins
  resources :countries
  resources :vaccines
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
