Rails.application.routes.draw do
  resources :articles
  resources :events do
    member do
      get  'users'
      post 'remove_image'
      #get  'signup'
      post 'register'
    end
    #resources :teams
  end
  resources :users
  resources :site, :only => :show
  root :to => "site#index", :as => :home
end
