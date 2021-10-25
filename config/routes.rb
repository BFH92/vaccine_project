Rails.application.routes.draw do
    devise_for :admins
    resources  :countries
    resources  :vaccines
    resources :vaccinated_people
    root 'vaccines#index'
    get 'vaccines-list' => "api#get_vaccines_datas_by_country_and_user"
    post'update-tracking' => "api#update_vaccination_tracking"
 end
