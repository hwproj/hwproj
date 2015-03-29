Rails.application.routes.draw do

  root 'welcome#index'

  devise_for :users, :controllers => { registrations: 'registrations' }

  get 'courses/:id/terms/:term_number', to: 'courses#show', as: "show_term"
  put 'courses/:id/terms/new', to: 'courses#add_term', as: "add_term"

  resources :courses
  resources :students
  resources :homeworks

  resources :tasks, only: [ :show, :update ]
  resources :submissions, only: [ :new, :create, :index, :update ]
  resources :problems, only: [ :show ]
  resources :notes
  resources :links
end
