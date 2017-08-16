Rails.application.routes.draw do
  root 'static#index'
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :teams do
    get 'select', on: :member # set user's current team
  end
  
end
