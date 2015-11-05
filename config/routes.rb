Rails.application.routes.draw do
  
  get '/api/expand' => 'url_shortener#expand'
  get '/api/shorten' => 'url_shortener#shorten'
  get '/api' => 'url_shortener#default'

  # root 'welcome#index'

end
