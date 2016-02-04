Rails.application.routes.draw do
  root "home#index"
  resources :stack_word_trees, except: [:show]
end
