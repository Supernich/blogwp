Rails.application.routes.draw do
  # TODO: Show pdf page by default
  match 'posts/:id' => 'posts#show', :defaults => { format: 'pdf' }, via: [:get]
  root 'posts#index'

  resources :posts do
    resources :comments
  end
end
