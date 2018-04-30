Rails.application.routes.draw do
  resources :chat_rooms
  resources :messages
  devise_for :users, :controllers => { registrations: 'registrations' }

  root to: 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
