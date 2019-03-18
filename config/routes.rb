Rails.application.routes.draw do
  resources :songs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root :to => "songs#index"
  #get '/songs/:id/edit', to:'songs#edit', as: 'edit_song'
end
    