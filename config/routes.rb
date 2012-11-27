GetherLy::Application.routes.draw do
  devise_for :users

  scope module: :api do
    # constraints subdomain: 'api' do
      namespace :v1 do
        devise_scope :user do
          post '/signup', to: 'registrations#create'
          get '/account/verify_credentials', to: 'accounts#verify_credentials'
        end
        resources :events do
          collection do
            post '/create', to: 'events#create'
            get '/index', to: 'events#index'
          end

          member do
            get '/invitations', to: 'events#invitations'
            get '/accept', to: 'events#accept'
            get '/decline', to: 'events#decline'
          end
        end
      end
    # end
  end

  root to: 'pages#root'
end
