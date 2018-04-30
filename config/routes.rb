Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :chat_rooms
  resources :messages
  resources :users

  root to: 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

