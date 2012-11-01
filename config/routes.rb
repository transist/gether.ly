GetherLy::Application.routes.draw do
  devise_for :users

  scope module: :api do
    # constraints subdomain: 'api' do
      namespace :v1 do
        devise_scope :user do
          post '/signup', to: 'registrations#create'
          get '/account/verify_credentials', to: 'account#verify_credentials'
        end
      end
    # end
  end

  root to: 'pages#root'
end
