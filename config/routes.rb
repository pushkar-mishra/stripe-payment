Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations' }
  root 'welcome#index'
  get 'welcome/index'
end
