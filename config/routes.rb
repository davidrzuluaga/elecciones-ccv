Rails.application.routes.draw do
  root 'voters#index'
  
  get '/resultados', to: 'view#index', as: 'view'

  get '/login', to: 'login#index', as: 'login'
  post '/login', to: 'login#create'
  get '/logout', to: 'login#destroy', as: 'logout'
  
  get '/admin', to: 'admin#index', as: 'admin'
  
  get '/candidatos', to: 'position#index', as: 'positionlist'  
  get '/posicion/nuevo', to: 'position#new', as: 'positions'
  post '/posicion/nuevo', to: 'position#create', as: 'createposition'
  get '/posicion/modify/:id', to: 'position#modify', as: 'position'
  patch '/posicion/modify/:id', to: 'position#update', as: 'updateposition'
  delete '/posicion/delete/:id', to: 'position#delete', as: 'deleteposition'

  get '/candidato/nuevo', to: 'position#newcandidate', as: 'candidates'
  get '/candidato/modify/:id', to: 'position#modifycandidate', as: 'candidate'
  delete '/candidato/delete/:id', to: 'position#deletecandidate', as: 'deletecandidate'
  patch '/candidato/modify/:id', to: 'position#updatecandidate', as: 'updatecandidate'
  post '/candidato/nuevo', to: 'position#createcandidate', as: 'newcandidate'

  get '/grupos', to: 'group#index', as: 'groups'
  get '/grupo/e/:id', to: 'group#show', as: 'showgroup'
  get '/grupo/modify/:id', to: 'group#modify', as: 'group'
  patch '/grupo/modify/:id', to: 'group#update', as: 'updategroup'
  delete '/grupo/delete/:id', to: 'group#delete', as: 'deletegroup'
  get '/grupo/nuevo', to: 'group#new', as: 'newgroup'
  post '/grupos', to: 'group#create', as: 'creategroup'

  get '/voto', to: 'voters#index', as: 'votologin'
  post '/votante', to: 'voters#checkVoter', as: 'checkVoter'
  get '/votar', to: 'candidate#index', as: 'votar'
  post '/votar', to: 'candidate#registevote', as: 'registevote'  
  
  get '/code', to: 'code#index', as: 'codes'
  post 'code', to: 'code#create' 
  delete 'code', to: 'code#destroy', as: 'deleteallcodes'
end
