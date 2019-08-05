Rails.application.routes.draw do
  get 'sessions/new'
get '/admin', to: 'static_pages#admin'
get '/slider', to: 'static_pages#slider'
get 'not_allow', to: 'static_pages#not_allow'
get '/admin/user', to: 'static_pages#adminuser', as: "adminuser"
get '/index', to: 'static_pages#index'
get "/about" => 'static_pages#about', as: 'about'
get "/spp" => 'static_pages#spp', as: 'spp'
get "/deletep" => 'static_pages#deletep', as: 'deletep'
get "/setadmin" => 'static_pages#setadmin', as: 'setadmin'
get "/acceptp" => 'static_pages#acceptp', as: 'acceptp'
post "/index" => 'static_pages#searchp'
get "/searchpeople" => 'static_pages#searchpeople', as: 'searchpeople'
get '/signup', to: 'users#new'
post '/signup',  to: 'users#create'
get '/login', to: 'sessions#new'
post '/login', to: 'sessions#create'
delete '/logout', to: 'sessions#destroy'
root 'static_pages#index'
  resources :users do
    member do
      get :following, :followers
    end
  end
resources :microposts do
    resources :comments, except: [:show, :edit]
    resources :likes
    resources :save_posts
    
  end
resources :relationships,       only: [:create, :destroy]

end
