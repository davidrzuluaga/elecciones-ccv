Rails.application.routes.draw do
  get 'student/index'
  root 'voters#index'
  
  get '/resultados', to: 'view#index', as: 'view'
  get '/resultados/:id', to: 'view#show', as: 'viewposition'

  get '/login', to: 'login#index', as: 'login'
  post '/login', to: 'login#create'
  get '/logout', to: 'login#destroy', as: 'logout'
  
  get '/admin', to: 'admin#index', as: 'admin'
  get '/claves/:id', to: 'admin#claves', as: 'claves'
  post '/claves/:id', to: 'admin#cambiarclave', as: 'cambiarclave'
  get '/voterslogout', to: 'admin#voterslogout', as: 'voterslogout'

  get '/estudiantes', to: 'student#index', as: 'students'  
  post '/estudiantes/nuevo(.:format)', to: 'student#create', as: 'createstudent'
  delete '/estudiantes/del/:id', to: 'student#destroy', as: 'destroystudent'

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
  get '/salirdevotar', to: 'candidate#closevotesession', as: 'salirdevotar'  
  
  get '/code', to: 'code#index', as: 'codes'
  get '/codestoprint', to: 'code#print', as: 'codestoprint'
  post 'code', to: 'code#create' 
  delete '/code', to: 'code#deleteunused', as: 'deleteunusedcodes'
  delete '/deleteallcodes', to: 'code#destroyall', as: 'deleteallcodes'
  delete '/deletecode/:id', to: 'code#destroy', as: 'deletecode'
end
