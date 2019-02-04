Rails.application.routes.draw do
  root 'voters#index'
  post '/votante', to: 'voters#checkVoter', as: 'checkVoter'
  get '/votar', to: 'candidate#index', as: 'votar'
  post '/votar', to: 'candidate#registevote', as: 'registevote'  
  
  get '/code', to: 'code#index', as: 'codes'
  post 'code', to: 'code#create' 
  delete 'code', to: 'code#destroy', as: 'deleteallcodes'
end
