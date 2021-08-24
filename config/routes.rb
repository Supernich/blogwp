Rails.application.routes.draw do
  # TODO: Show pdf page by default
  root 'posts#index'

  resources :posts do
    resources :comments
  end
end
