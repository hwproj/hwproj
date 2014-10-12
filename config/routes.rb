Rails.application.routes.draw do

  root 'welcome#index'

  devise_for :users, :controllers => { registrations: 'registrations' }

  devise_scope :user do
    put 'users/approve/:id', to: 'registrations#approve_student', as: "approve_student"
    delete 'users/:id', to:'registrations#destroy_student', as: "destroy_student"
  end

  get 'courses/:id/terms/:term_number', to: 'courses#show', as: "show_term"
  put 'courses/:id/terms/new', to: 'courses#add_term', as: "add_term"

  resources :courses
  resources :terms
  resources :students
  resources :homeworks

  resources :tasks, only: [ :show, :update ]
  resources :submissions, only: [ :new, :create, :index, :update ]
  resources :problems, only: [ :show ]
  resources :notes, only: [:update, :destroy ]
  resources :groups, only: [ :index, :show, :new, :edit, :create, :update ]
  resources :links
end
