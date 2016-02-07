Rails.application.routes.draw do
  root 'clients#new'
  resources :clients, only: [:create, :new, :show] 
  get '/time_slots/:month/coach/:coach_id', to: 'time_slots#get_slots', :defaults => { :format => 'json' }
  post '/time_slots/:time_slot_id', to: 'time_slots#reserve_delete_spot'
end
