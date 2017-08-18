Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :teams do
    get 'select', on: :member # set user's current team
  end

  root 'events#index'  
  resources :events do
    get 'go', on: :member
  end
  
end
