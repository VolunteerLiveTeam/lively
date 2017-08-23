Rails.application.routes.draw do
  
  # users
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # teams
  resources :teams, except: [:show] do
    member do
      post :select # set user's current team

      get :list_members, path: 'members'
      post :add_member, path: 'members'
      delete :remove_member, path: 'members'      
    end
  end

  # events
  root 'events#index'  
  resources :events do
    get 'go', on: :member
  end

  # admin
  post 'admin/toggle'  
  
end
