Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  
  resources :chat_rooms do
  	resources :messages, only: [:create, :index]
  end
  
  get '/js-ui', to: 'js_ui#index'

  resources :users
  root to: 'users#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

