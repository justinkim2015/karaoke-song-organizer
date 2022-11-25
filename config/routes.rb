Rails.application.routes.draw do
  root "songs#index"

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  resources :songs, :places
end
