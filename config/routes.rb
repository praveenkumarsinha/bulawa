Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #application's root
  root to: 'home#index'

  #application's dashboard (home of an account i.e subdomain)
  get 'dashboard', to: 'home#dashboard', as: 'dashboard'

  resource :sessions, only: [] do
    collection do
      get 'login'
      post 'login'

      delete 'logout'

      get 'account_signup'
      post 'account_signup'
    end
  end

  resource :apps

end
