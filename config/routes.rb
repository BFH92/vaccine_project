Rails.application.routes.draw do
  resources :vaccinated_people
  devise_for :admins

    resources :countries
    resources :vaccines
  
  #namespace :api do
    get 'vaccines-list' => "api#vaccines_available_by_country"
    post'update-tracking' => "api#update_vaccination_tracking"
 #end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
