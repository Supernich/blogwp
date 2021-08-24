Rails.application.routes.draw do
  match 'posts/pdf/:id' => 'posts#show', :defaults => { format: 'pdf' }, via: [:get]
  root 'posts#index'

  resources :posts do
    resources :comments
  end
end
