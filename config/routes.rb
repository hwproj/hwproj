Rails.application.routes.draw do

  root 'welcome#index'

  devise_for :users, :controllers => { registrations: 'registrations' }

  get 'courses/:id', to: 'courses#show_course', as: "show_course"
  get 'courses/:id/terms/:term_number', to: 'courses#show', as: "show_term"
  put 'courses/:id/terms/new', to: 'courses#add_term', as: "add_term"
  get 'courses/:id/statistics', to: 'courses#statistics', as: "show_statistics"
  put 'courses/:id/terms/delete_last', to: 'courses#delete_term', as: "delete_term"
  get 'courses/:id/terms/:term_number/homeworks/new', to: 'homeworks#new', as: "new_homework"
  # GitHub Authorization callback
  get 'github/callback'
  # Webhooks url
  post 'github/payload'

  resources :courses
  resources :students
  resources :homeworks

  resources :invitations, only: [ :new, :create, :edit, :update ]
  resources :tasks, only: [ :show, :update ] { member { get 'switch_chat' } }

  resources :messages
  
  resources :submissions, only: [ :new, :create, :index, :update ]
  resources :problems, only: [ :show ]
  resources :notes
  resources :links
  resources :notifications, only: [:update]
end
