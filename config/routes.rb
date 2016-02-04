Rails.application.routes.draw do
  root "stack_word_trees#new"
  resources :stack_word_trees, except: [:update, :edit]
end
